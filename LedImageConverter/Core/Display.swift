//
//  Display.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 04/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import Foundation
import class AppKit.NSColor

protocol Display {
    func set(color: NSColor, row: Int, column: Int)
    func flush()
    func clear()
}

@objc class DisplayWrapper: NSObject {
    private let wrappedValue: Display

    init(display: Display) {
        self.wrappedValue = display
    }

    @objc
    func set(nsColor: NSColor, row: Int, column: Int) {
        wrappedValue.set(color: nsColor, row: row, column: column)
    }

    @objc
    func set(color: uint32, row: Int, column: Int) {
        set(nsColor: NSColor(hex: color), row: row, column: column)
    }

    @objc
    func flush() {
        wrappedValue.flush()
    }

    @objc
    func clear() {
        wrappedValue.clear()
    }
}
