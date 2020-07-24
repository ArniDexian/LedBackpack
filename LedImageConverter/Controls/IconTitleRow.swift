//
//  FontEditorSymbolRow.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 02/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import SwiftUI

struct IconTitleRow: View {
    struct Model {
        let title: String
        let icon: Image
        let selected: Bool
    }

    var model: Model
    
    var body: some View {
        HStack() {
            model.icon
            Text(model.title)
                .foregroundColor(model.selected ? .green : .white)
        }
    }
}
