//
//  CppSourceCodeGenerator.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 13/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import AppKit

struct CppSourceCodeGenerator {
    struct Constants {
        static let sourceArrayDelimeter = ", "
    }

    func generate(from sprite: ImageProcessor.SpriteRepresentation) -> String {
        var sourceCode = ""

        let name = sprite.name

        let frames = sprite.frames.map { (frameRepres) -> IndexedColorFrame in
            guard case let .sharedIndexedColors(frame) = frameRepres.frame else {
                fatalError("Sprite must have shared palette representation")
            }
            return frame
        }

        guard frames.count > 0 else {
            return sourceCode
        }

        sourceCode.append(generateColorPaletteSource(indexedColors: frames[0].indexedColors,
                                                     name: name))

        sourceCode.append("const uint8_t \(colorIndexesVarSource(name: name))[] PROGMEM = {\(Character.newLine)")

        for (i, frame) in frames.enumerated() {
            sourceCode.append("// frame \(i)\n")
            sourceCode.append(generateIndexMapBlobSource(indexMap: frame.indexMap))
            sourceCode.append(",\(Character.newLine)")
        }

        sourceCode.remove(upTo: ",")
        sourceCode.append("\(Character.newLine)};\(Character.newLine)")

        let frameSequenceVar = "img_\(name)_frameSequence"
        sourceCode.append("const uint8_t \(frameSequenceVar)[] PROGMEM = ")
        let seqString = (0..<frames.count).map {String($0)}.joined(separator: Constants.sourceArrayDelimeter)
        sourceCode.append("{\(seqString)};")

        sourceCode.append("\nSprite sprite\(name.capitalized) = { \(colorPaletteVarSource(name: name)), \(frames.count), \(frameSequenceVar), \(colorIndexesVarSource(name: name)) };\n");

        return sourceCode
    }

    func generate(from frame: ImageProcessor.SpriteRepresentation.FrameRepresenation) -> String {
        var sourceCode = ""

        let name = frame.originalImageName ?? "noname"

        switch frame.frame {
        case let .indexedColors(frame):
            sourceCode.append(generateSource(for: frame, name: name))
        case let .sharedIndexedColors(frame):
            sourceCode.append(generateSource(for: frame, name: name))

        case .rgb(_):
            assertionFailure("Not implemented RGB color conversion")
        }

        return sourceCode
    }

    private func generateSource(for frame: IndexedColorFrame, name: String) -> String {
        var sourceCode = ""

        sourceCode.append(generateColorPaletteSource(indexedColors: frame.indexedColors, name: name))

        sourceCode.append("const uint8_t \(colorIndexesVarSource(name: name))[] PROGMEM = {\(Character.newLine)")

        sourceCode.append(generateIndexMapBlobSource(indexMap: frame.indexMap))

        sourceCode.remove(upTo: ",")
        sourceCode.append("\(Character.newLine)};\(Character.newLine)")

        return sourceCode
    }

    private func generateColorPaletteSource(indexedColors: [NSColor], name: String) -> String {
        var sourceCode = ""

        sourceCode.append("const uint32_t \(colorPaletteVarSource(name: name))[] PROGMEM = {\(Character.newLine)")

        let indexedColorsKeyVal = indexedColors.enumerated().reduce(into: [NSColor: Int]()) { (res, arg) in
            res[arg.element] = arg.offset
        }

        for colorPair in indexedColorsKeyVal.sorted(by: { (p0, p1) in p0.value < p1.value }) {
            sourceCode.appendPrefixHex(colorPair.key.hexRgbColor,
                                       delimeter: Constants.sourceArrayDelimeter)
        }

        sourceCode.remove(upTo: ",")
        sourceCode.append("\(Character.newLine)};\(Character.newLine)")

        return sourceCode
    }
    
    private func generateIndexMapBlobSource(indexMap: Matrix<UInt8>) -> String {
        var sourceCode = ""

        for (_, iCol, index) in indexMap {
            sourceCode.appendPrefixHex(index, delimeter: Constants.sourceArrayDelimeter)
            if iCol == indexMap.columns - 1 {
                sourceCode.append(Character.newLine)
            }
        }

        sourceCode.remove(upTo: ",")

        return sourceCode
    }

    // MARK: -

    private func colorPaletteVarSource(name: String) -> String {
        "img_\(name)_colorPalette"
    }

    private func colorIndexesVarSource(name: String) -> String {
        "img_\(name)_colorIndexes"
    }
}
