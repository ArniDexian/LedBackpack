//
//  Property.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 06/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import Foundation
import AppKit

struct Property {
    let name: String
    let modifiable: Bool
    let value: Value?

    init(name: String, modifiable: Bool = false, value: Value?) {
        self.name = name
        self.modifiable = modifiable
        self.value = value
    }
}

enum Value {
    case uint8(UInt8)
    case floating(CGFloat)
    case boolean(Bool)
    case string(String)
    case character(Character)
    case pointSize(PointSize)
    case fontSize(FontSize)
    case color(NSColor)
}

extension Property: Hashable {
    static func == (lhs: Property, rhs: Property) -> Bool {
        lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

//extension Value: Hashable {
//}
