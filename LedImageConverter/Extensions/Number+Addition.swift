//
//  Number+Addition.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 02/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import Foundation

extension UInt8 {
    var prefixHexString: String {
        return String(format:"0x%02X", self)
    }

    var hexString: String {
        return String(format:"%02X", self)
    }
}

extension UInt32 {
    var prefixHexString: String {
        return String(format:"0x%08X", self)
    }

    var hexString: String {
        return String(format:"%08X", self)
    }
}

extension Int {
    var uint8: UInt8 {
        UInt8(self)
    }
}
