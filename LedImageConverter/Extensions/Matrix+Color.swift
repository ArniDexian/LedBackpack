//
//  Matrix+Color.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 05/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import AppKit
import SwiftUI

extension Matrix where Element == NSColor {
    func image(scale: Int = 1, orienation: Image.Orientation?) -> NSImage? {
        let height = rows * scale
        let width = columns * scale
        let scale = Swift.max(scale, 1)

        var rawData: [UInt32] = Array(repeating: 0, count: height * width)
        for (i, j, value) in self {
            for si in 0..<scale {
                for sj in 0..<scale {
                    rawData[(i * scale + si) * width + j * scale + sj] = rgbHex(value.blueComponent, value.greenComponent, value.redComponent)
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

        guard var cgImage = CGImage(width: width,
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

        if let orientation = orienation, let rotated = cgImage.rotated(orienation: orientation) {
            cgImage = rotated
        }
        let image = NSImage(cgImage: cgImage, size: CGSize(width: CGFloat(width), height: CGFloat(height)))

        return image
    }
}
