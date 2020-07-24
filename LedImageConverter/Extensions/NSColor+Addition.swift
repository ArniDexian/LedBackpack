//
//  NSColor+Addition.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 01/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import SwiftUI

extension NSColor {
    var hexRgbColor: UInt32 {
        guard let color = CIColor(color: self) else {
            fatalError("need to fix the issue with color space")
        }
        return rgbHex(color.red, color.green, color.blue)
    }

    // For NSColor.some_color
    var systemsHexRbgColor: UInt32 {
        cgColor.systemsHexRgbColor
    }

    convenience init(hex: UInt32) {
        self.init(red: CGFloat((hex >> 16) & 0xFF) / 255,
                  green: CGFloat((hex >> 8) & 0xFF) / 255,
                  blue: CGFloat(hex & 0xFF) / 255,
                  // TODO: - so far don't support alfa
                  alpha: 1)//CGFloat((hex >> 24) & 0xFF) / 255)
    }
}

extension CGColor {
    var hexRgbColor: UInt32 {
        if components?.count ?? 0 >= 3 {
            return rgbHex(components![2], components![1], components![0])
        }
        assertionFailure("unknown case")
        return 0x000000
    }

    var systemsHexRgbColor: UInt32 {
        if components?.count == 4 {
            return rgbHex(components![0], components![1], components![2])
        }
        assertionFailure("unknown case")
        return 0x000000
    }

}

func rgbHex(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UInt32 {
    return UInt32(r * 255) << 16
        ^ UInt32(g * 255) << 8
        ^ UInt32(b * 255)
}
