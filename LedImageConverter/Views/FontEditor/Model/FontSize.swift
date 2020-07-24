//
//  FontSize.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 10/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import Foundation

struct FontSize {
    let width: Int
    let height: Int

    static let min = FontSize(width: 3, height: 5)
    static var max: FontSize = {
        FontSize(width: constants.displaySize.columns,
                 height: constants.displaySize.rows)
    }()
}
