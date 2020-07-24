//
//  FontTranslator.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 02/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import Foundation

struct FontTranslator {
    func translate(_ fonts: [FontModel]) -> String {
        guard let fontHeight = fonts.first?.bitmap.rows,
            let fontWidth = fonts.first?.bitmap.columns else { return "" }

        var result = ""
        let commaDelimeter = ", "

        let bytesPerGlyph = UInt8(ceil(Double(fontWidth * fontHeight) / 8.0))
        let glyphsCount = fonts.count

        assert(glyphsCount < UInt8.max)

        result.append("// this font containts symbols: \(fonts.map { $0.symbol})\n")
        result.append("const uint8_t PROGMEM font\(fontWidth)x\(fontHeight)[] = {\n")
        result.append("// bit height, bit width, glyphs count\n")
        result.appendPrefixHex(fontHeight.uint8, delimeter: commaDelimeter)
        result.appendPrefixHex(fontWidth.uint8, delimeter: commaDelimeter)
        result.appendPrefixHex(glyphsCount.uint8, delimeter: commaDelimeter)

        result.append("\n//The format is 1 byte ASCII symbol code + \(bytesPerGlyph) bytes per glyph:\n")
        for font in fonts {
            guard let ascii = font.symbol.asciiValue else {
                print("can't fint ascii code for symbol \(font.symbol)")
                continue
            }

            result.append("//char '\(font.symbol)'\n")
            result.appendPrefixHex(ascii, delimeter: commaDelimeter)

            result.append(
                font.bitmap.byteSequence().reduce(into: "") { (_result, byte) in
                    _result.appendPrefixHex(byte, delimeter: commaDelimeter)
                }
            )
            result.append("\n")
        }

        result.remove(upTo: ",")
        result.append("\n};")

        return result
    }
}
