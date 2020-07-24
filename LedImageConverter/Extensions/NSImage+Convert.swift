//
//  NSImage+Convert.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 01/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import AppKit
import SwiftUI

extension NSImage {
    static func fontIcon(bitmap: Bitmap, color: NSColor = .systemGreen, scale: Int = 1) -> NSImage? {
        let height = bitmap.rows * scale
        let width = bitmap.columns * scale
        let scale = max(scale, 1)

        let hexColor: UInt32 = color.hexRgbColor

        var rawData: [UInt32] = Array(repeating: 0, count: height * width)
        for (i, j, value) in bitmap {
            for si in 0..<scale {
                for sj in 0..<scale {
                    rawData[(i * scale + si) * width + j * scale + sj] = value ? hexColor : 0
                }
            }
        }
        let data = rawData.withUnsafeBufferPointer { (pointer) in
            Data(buffer: pointer)
        }

        guard let dataProvider = CGDataProvider(data: data as CFData) else {
            print("failed to create data prvider")
            return nil
        }

        guard let cgImage = CGImage(width: width,
                              height: height,
                              bitsPerComponent: 8,
                              bitsPerPixel: 32,
                              bytesPerRow: 4 * width,
                              space: CGColorSpaceCreateDeviceRGB(),
                              bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.noneSkipLast.rawValue),
                              provider: dataProvider,
                              decode: nil,
                              shouldInterpolate: false,
                              intent: .defaultIntent) else {
                                print("failed to create CGImage")
                                return nil
        }


        let image = NSImage(cgImage: cgImage, size: CGSize(width: CGFloat(width), height: CGFloat(height)))

        return image
    }
}

extension NSImage {
    func findColors(orienation: Image.Orientation = .left) -> [NSColor] {
        let pixelSize = self.pixelSize
        let (pixelsWide, pixelsHigh) = (Int(pixelSize.width), Int(pixelSize.height))

        guard let pixelData = cgImage?
            .rotated(orienation: orienation)?
            .dataProvider?.data else { return [] }
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)

        var imageColors: [NSColor] = []
        for x in 0..<pixelsWide {
            for y in 0..<pixelsHigh {
                let point = CGPoint(x: x, y: y)
                let pixelInfo: Int = ((pixelsWide * Int(point.y)) + Int(point.x)) * 4
                let color = NSColor(red: CGFloat(data[pixelInfo]) / 255.0,
                                    green: CGFloat(data[pixelInfo + 1]) / 255.0,
                                    blue: CGFloat(data[pixelInfo + 2]) / 255.0,
                                    alpha: CGFloat(data[pixelInfo + 3]) / 255.0)
                imageColors.append(color)
            }
        }
        return imageColors
    }

    var cgImage: CGImage? {
        return self.cgImage(forProposedRect: nil, context: nil, hints: nil)
    }

    var pixelSize: CGSize {
        guard let rep = representations.first else {
            print("NSImage.pixelSize failed to get representation for image \(self)")
            return size
        }
        return CGSize(width: rep.pixelsWide, height: rep.pixelsHigh)
    }
}
