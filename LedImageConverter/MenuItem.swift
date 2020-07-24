//
//  MenuItem.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 01/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import SwiftUI

enum MenuItem: Int, Identifiable {
    var id: Int {
        rawValue
    }

    case fontEditor
    case spriteConverter
    case effects
    case aboutView

    var title: String {
        switch self {
        case .fontEditor:
            return "Font Editor"
        case .spriteConverter:
            return "Sprite Converter"
        case .effects:
            return "Effects"
        case .aboutView:
            return "About View"
        }
    }

    var view: AnyView {
        switch self {
        case .fontEditor:
            return AnyView(FontEditorView()
                .environmentObject(appModel.fontEditorModel)
            )
        case .spriteConverter:
            return AnyView(SpriteConverterView()
                .environmentObject(appModel.spriteConverterModel)
            )
        case .effects:
            return AnyView(EffectsListView()
                .environmentObject(appModel.effectListModel)
            )
        case .aboutView:
            return AnyView(AboutView())
        }
    }

    static var all: [MenuItem] {
        [.fontEditor, .spriteConverter, .effects, .aboutView]
    }
}
