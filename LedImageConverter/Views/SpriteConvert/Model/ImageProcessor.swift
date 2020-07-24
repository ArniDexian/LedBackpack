//
//  ImageProcessor.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 02/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import AppKit
import CoreGraphics

struct ImageProcessor {
    private typealias ColorRepresentation = (palette: [NSColor: Int], colors: [NSColor])

    struct SpriteRepresentation {
        struct FrameRepresenation {
            enum Frame {
                /// all colors palletes are the same between frames in one sprite
                case sharedIndexedColors(IndexedColorFrame)
                case indexedColors(IndexedColorFrame)
                case rgb(ColorMapFrame)

                var erased: SpriteFrame {
                    switch self {
                    case let .sharedIndexedColors(frame):
                        return frame
                    case let .indexedColors(frame):
                        return frame
                    case let .rgb(rgb):
                        return rgb
                    }
                }
            }

            let originalImageName: String?
            let frame: Frame
        }
        let name: String
        let frames: [FrameRepresenation]
    }

    struct Constants {
        static let resourcesFolderName = "pics"
        static let sourceArrayDelimeter = ", "
    }

    private let rootPath = URL(string: Constants.resourcesFolderName, relativeTo: Bundle.main.resourceURL)
    private let fileManager = FileManager.default
    private let cppGenerator = CppSourceCodeGenerator()

    typealias ProcessResult = (sprites: [SpriteRepresentation],
        pictures: [SpriteRepresentation.FrameRepresenation],
        concatenatedSourceCode: String)

    func process() -> ProcessResult? {
        guard let (rootPackPaths, picturePaths) = paths() else { return nil }

        let sprites = processSprites(at: rootPackPaths)
        let pictures = processPictures(at: picturePaths)

        let source = (sprites.compactMap {
                cppGenerator.generate(from: $0)
            }
            + pictures.map { cppGenerator.generate(from: $0) })
            .joined(separator: .newLine)

        print(source)

        return (sprites, pictures, source)
    }

    // MARK: - Processing private

    private func processSprites(at paths: [String]) -> [SpriteRepresentation] {
        return paths.map { packPath -> SpriteRepresentation in
            let spritePicPaths = try! fileManager.contentsOfDirectory(atPath: packPath).sorted()
            let spriteName = URL(string: packPath)?.lastPathComponent ?? "noname_sprite"

            let palette = sharedColorPalette(for: spritePicPaths, packPath: packPath).indexed

            let frames = spritePicPaths.compactMap { fileName -> SpriteRepresentation.FrameRepresenation? in
                guard let image = spriteFrameImage(for: fileName, in: packPath) else { return nil }

                do {
                    return try spriteFrameRepresentation(for: image, name: fileName, indexedColorPalette: palette)
                } catch {
                    print("failed to create image from file \(fileName) for pack \(packPath), reason: \(error)")
                    return nil
                }
            }

            return SpriteRepresentation(name: spriteName, frames: frames)
        }
    }

    private func processPictures(at paths: [String]) -> [SpriteRepresentation.FrameRepresenation] {
        return paths.compactMap { (picPath) -> SpriteRepresentation.FrameRepresenation? in
            guard picPath.isBmpFile, let imageData = fileManager.contents(atPath: picPath) else {
                    print("failed to open picture file \(picPath)")
                    return nil
            }

            guard let image = NSImage(data: imageData) else {
                print("failed to create image from file \(picPath)")
                return nil
            }

            do {
                let name = URL(fileURLWithPath: picPath)
                    .deletingPathExtension()
                    .lastPathComponent
                let res = try frameRepresentation(for: image, name: name)
                return res
            } catch {
                print("failed to create image from file \(picPath), reason: \(error)")
                return nil
            }
        }
    }

    // MARK: - transforming logic

    private func frameRepresentation(for image: NSImage, name: String) throws -> SpriteRepresentation.FrameRepresenation {
        let (uniqueColors, colors) = try colorRepresentation(for: image, name: name)

        return try frameRepresentation(colors: colors,
                                       columns: Int(image.pixelSize.width),
                                       rows: Int(image.pixelSize.height),
                                       uniqueColors: uniqueColors,
                                       name: name)
    }

    /// Uses color given palette instead
    private func spriteFrameRepresentation(for image: NSImage, name: String, indexedColorPalette: [NSColor: Int]) throws -> SpriteRepresentation.FrameRepresenation {
        let (_, colors) = try colorRepresentation(for: image, name: name)

        let res =  try frameRepresentation(colors: colors,
                                       columns: Int(image.pixelSize.width),
                                       rows: Int(image.pixelSize.height),
                                       uniqueColors: indexedColorPalette,
                                       sharedPalette: true,
                                       name: name)
        return res
    }

    private func frameRepresentation(colors: [NSColor], columns: Int, rows: Int, uniqueColors: [NSColor: Int],
                                     sharedPalette: Bool = false, name: String)
        throws -> SpriteRepresentation.FrameRepresenation {

        // assume 2 bytes per pixel: 1 byte per indexed color map + 1 remains for palette
        // full palette size is 4 byte per color, remaining 1 byte * colors count
        // using more that colors count bytes / 4 RGBa bytes doesn't make sense
        // so it's preferreble to use 2 bytes RGB bitmap
        let maxOptimalPaletteSize = colors.count / 4
        assert(uniqueColors.count < maxOptimalPaletteSize, "doesn't have any sense to use palette with so many colors in image")

        guard uniqueColors.count <= UInt8.max else {
            throw CoreError.failure("So far only 256 colors in an image is supported, but got \(uniqueColors.count)")
        }

        // palette

        let indexedColorsKeyVal = uniqueColors.sorted(by: { (p0, p1) -> Bool in p0.value < p1.value })

        var indexMatrix = Matrix<UInt8>(rows: rows, columns: columns, repeating: 0)
        for (row, col, _) in indexMatrix {
            let color = colors[row * columns + col]
            let index = UInt8(uniqueColors[color]!)
            indexMatrix[row, col] = index
        }

        let indexedColorFrame = IndexedColorFrame(indexedColors: indexedColorsKeyVal.map { $0.key },
                                                  indexMap: indexMatrix)

            
        return .init(originalImageName: name,
                     frame: sharedPalette ? .sharedIndexedColors(indexedColorFrame) : .indexedColors(indexedColorFrame))
    }

    // MARK: - colors

    private func colorRepresentation(for image: NSImage, name: String) throws -> ColorRepresentation {
        let columns = Int(image.pixelSize.width)
        let rows = Int(image.pixelSize.height)

        guard columns > 0, rows > 0 else {
            throw CoreError.failure("Failed to get frame represenation for an image \(image) as size should be non zero (got {\(rows), \(columns)})")
        }

        let colors = image.findColors(orienation: .left)

        guard colors.count == columns * rows else {
            throw CoreError.failure("Failed to get all colors for image \(name), expected count is \(columns * rows) but got \(colors.count)")
        }

        return (colors.indexed, colors)
    }

    private func sharedColorPalette(for spritePicPaths: [String], packPath: String) -> Set<NSColor> {
        let result = spritePicPaths.reduce(into: Set<NSColor>()) { (result, fileName) in
            guard let image = spriteFrameImage(for: fileName, in: packPath) else { return }
            guard let (unique, _) = try? self.colorRepresentation(for: image, name: fileName) else { return }
            result.formUnion(Set(unique.keys))
        }
        return result
    }

    // MARK: - FS related jobs

    private func spriteFrameImage(for fileName: String, in packPath: String) -> NSImage? {
        guard fileName.isBmpFile, let pictureData = fileManager.contents(atPath: "\(packPath)/\(fileName)") else {
            print("failed to open file \(fileName) for pack \(packPath)")
            return nil
        }

        guard let image = NSImage(data: pictureData) else {
            print("failed to create image from file \(fileName) for pack \(packPath)")
            return nil
        }

        return image
    }

    private func paths() -> (packsPaths: [String], picPaths: [String])? {
        guard let picsDir = rootPath?.path,
            let iconSetPaths = try? fileManager.contentsOfDirectory(atPath: picsDir) else {
            print("no valid pics path")
            return nil
        }

        var packsPaths: [String] = []
        var picPaths: [String] = []

        for ip in iconSetPaths {
            let ipPath = "\(picsDir)/\(ip)"
            var isDir: ObjCBool = false
            fileManager.fileExists(atPath: ipPath, isDirectory: &isDir)
            if isDir.boolValue {
                packsPaths.append(ipPath)
            } else if ip.isBmpFile {
                picPaths.append(ipPath)
            }
        }

        return (packsPaths, picPaths)
    }
}

extension Collection where Element == NSColor {
    /// Creates a map with indexed colors i.e [Color: Index]
    var indexed: [NSColor: Int] {
        reduce(into: Set<NSColor>()) { (result, color) in
            result.insert(color)
        }.sorted(by: {
            $0.hexRgbColor < $1.hexRgbColor
        }).reduce(into: [NSColor: Int]()) { (res, color) in
            res[color] = res.count
        }
    }
}
