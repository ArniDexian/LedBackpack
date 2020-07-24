//
//  FontEditorToolbox.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 01/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import SwiftUI

struct FontEditorToolbox: View {
    @EnvironmentObject private var model: FontEditorModel

    var body: some View {
        let widthBinding = Binding(
            get: { self.model.fontSize.width },
            set: { self.model.fontSize = FontSize(width: $0,
                                                  height: self.model.fontSize.height) }
        )

        let heightBinding = Binding(
            get: { self.model.fontSize.height },
            set: { self.model.fontSize = FontSize(width: self.model.fontSize.width,
                                                  height: $0) }
        )

        return HStack(alignment: .center, spacing: 5) {
            Button("Translate to C++", action: self.model.translateAction)

            Divider()

            Picker(selection: widthBinding, label: Text("Font width:").lineLimit(1)) {
                ForEach(FontSize.min.width...FontSize.max.width, id: \.self) { v in
                    Text("\(v) pt").fixedSize().tag(v)
                }
            }.frame(width: 150)

            Picker(selection: heightBinding, label: Text("height:")) {
                ForEach(FontSize.min.height...FontSize.max.height, id: \.self) { v in
                    Text("\(v) pt").fixedSize().tag(v)
                }
            }.frame(width: 110)

            Divider()

            Spacer()

            Button("Clear", action: self.model.clearSelected)
        }
    }
}


struct FontEditorToolbox_Previews: PreviewProvider {
    static var previews: some View {
        FontEditorToolbox()
            .frame(height: 40)
            .environmentObject(FontEditorModel())
    }
}
