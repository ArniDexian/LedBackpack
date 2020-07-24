//
//  FontEditorModel.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 01/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import SwiftUI

final class FontEditorModel: ObservableObject {
    private let charachters = "1234567890QWERTYUIOPASDFGHJKLZXCVBNM,.!?():@#$%^&*-=_+{}[];'|/><~"
    var fontSize: FontSize {
        didSet {
            let newSize = PointSize(rows: fontSize.height, columns: fontSize.width)
            fonts.forEach { m in
                m.bitmap.resize(to: newSize, defaultValue: false)
            }
            objectWillChange.send()
        }
    }
    private(set) var fonts: [FontModel]

    @Published var selectedFont: FontModel
    @Published var translationView: Bool = false
    @Published var translationViewText = ""

    init(fontSize: FontSize = .min) {
        self.fontSize = fontSize      
        fonts = charachters.map { (char) in
            FontModel(symbol: char,
                      bitmap: Bitmap(rows: fontSize.height,
                                     columns: fontSize.width,
                                     repeating: false)
            )
        }
        selectedFont = fonts.first!
    }

    func clearSelected() {
        selectedFont.clearBitmap()
        objectWillChange.send()
    }

    func translateAction() {
        translationView = true
        translationViewText = FontTranslator().translate(fonts)
    }

    func copyTranslation() {
        NSPasteboard.insert(translationViewText)
    }
}
