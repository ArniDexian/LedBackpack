//
//  FontModel.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 02/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import SwiftUI

final class FontModel: ObservableObject, Identifiable {
    let id = UUID()
    let symbol: Character
    var bitmap: Bitmap

    init(symbol: Character, bitmap: Bitmap) {
        self.symbol = symbol
        self.bitmap = bitmap
    }

    func clearBitmap() {
        for (i, j, _) in bitmap {
            bitmap[i, j] = false
        }
    }
}

extension FontModel: Equatable {
    static func == (lhs: FontModel, rhs: FontModel) -> Bool {
        lhs.symbol == rhs.symbol
    }
}

extension FontModel {
    var previewIcon: NSImage? {
        return NSImage.fontIcon(bitmap: bitmap, color: .systemGreen, scale: 5)
    }
}

extension IconTitleRow.Model {
    init(fontModel: FontModel, selected: Bool) {
        title = "Symbol '\(String(fontModel.symbol))'"
        icon = Image(nsImage: fontModel.previewIcon ?? NSImage())
        self.selected = selected
    }
}
