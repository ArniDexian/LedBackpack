//
//  AppModel.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 06/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import Foundation

struct AppConstants {
    let displaySize: PointSize = PointSize(rows: 12, columns: 12)
}

struct AppModel {
    lazy var fontEditorModel = FontEditorModel()
    lazy var spriteConverterModel = SpriteConverterModel()
    lazy var effectListModel = EffectsListModel()
    let preselectedMenu: MenuItem = .effects
}

var appModel = AppModel()
var constants = AppConstants()
