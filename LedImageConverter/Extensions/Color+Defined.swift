//
//  Color+Defined.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 02/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import SwiftUI

extension Color {
    static var menuBackground: Color {
        Color(.sRGB, red: 0.3, green: 0.3, blue: 0.3, opacity: 1)
    }

    // MARK: - GRID

    static var fontGridEmpty: Color {
        return Color(NSColor.white.withAlphaComponent(0.1))
    }

    static var fontGridFilled: Color {
        return .green
    }
}
