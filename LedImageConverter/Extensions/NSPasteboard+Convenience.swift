//
//  NSPasteboard+Convenience.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 02/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import AppKit

extension NSPasteboard {
    static func insert(_ string: String) {
        let pasteBoard = NSPasteboard.general
        pasteBoard.declareTypes([.string], owner: nil)
        pasteBoard.setString(string, forType: .string)
    }
}
