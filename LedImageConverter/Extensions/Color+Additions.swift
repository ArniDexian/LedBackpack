//
//  Color+Additions.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 04/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import SwiftUI

extension Color {
    init(hex: UInt32) {
        self.init(NSColor(hex: hex))
    }
}
