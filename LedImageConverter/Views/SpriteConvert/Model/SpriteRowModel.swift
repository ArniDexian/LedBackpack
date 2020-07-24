//
//  SpriteRowModel.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 05/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import SwiftUI

struct SpriteRowModel: Identifiable {
    let id = UUID()
    let preview: Image
    let name: String
}

extension IconTitleRow.Model {
    init(spriteRow: SpriteRowModel, selected: Bool) {
        title = spriteRow.name
        icon = spriteRow.preview
        self.selected = selected
    }
}

