//
//  String+Additions.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 02/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import Foundation

extension String {
    static var newLine: String {
        return String(Character.newLine)
    }

    var isBmpFile: Bool {
        return URL(string: self)?.lastPathComponent.split(separator: ".").last?.lowercased() == "bmp"
    }

    var removingExtension: String {
        var copy = self
        copy.remove(upTo: ".")
        return copy
    }

    mutating func remove(upTo value: Character) {
        guard let ind = lastIndex(of: value) else { return }
        removeSubrange(ind...)
    }

    mutating func appendPrefixHex(_ byte: UInt8, delimeter: String = "") {
        append("\(byte.prefixHexString)\(delimeter)")
    }

    mutating func appendHex(_ byte: UInt8) {
        append(byte.hexString)
    }

    mutating func appendPrefixHex(_ byte: UInt32, delimeter: String = "") {
        append("\(byte.prefixHexString)\(delimeter)")
    }

    mutating func appendHex(_ byte: UInt32) {
        append(byte.hexString)
    }
}
