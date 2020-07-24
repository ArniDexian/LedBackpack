//
//  FontEditorView.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 01/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import SwiftUI

struct FontEditorView: View {
    private struct Constants {
        static let listWidth: CGFloat = 130
        static let toolboxHeight: CGFloat = 36
        static let translationViewHeight: CGFloat = 80
        static let buttonPadding: CGFloat = 4
    }

    @EnvironmentObject var model: FontEditorModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack() {
                List(model.fonts) { e in
                    IconTitleRow(model: .init(fontModel: e, selected: self.model.selectedFont == e))
                        .onTapGesture {
                        self.model.selectedFont = e
                    }
                }
                .frame(width: Constants.listWidth, alignment: Alignment.topLeading)

                VStack() {
                    FontEditorToolbox()
                        .frame(height: Constants.toolboxHeight, alignment: .center)
                    FontEditorGrid(matrix: $model.selectedFont.bitmap)
                        .frame(alignment: .topLeading)
                }
            }

            if model.translationView {
                HStack {
                    Button("Copy", action: self.model.copyTranslation)
                        .padding(Constants.buttonPadding)

                    Spacer()

                    Button("Hide", action: {
                        self.model.translationView = false
                    }).padding(Constants.buttonPadding)
                }

                VStack() {
                    ScrollView(.vertical, showsIndicators: true) {
                        Text(model.translationViewText)
                            .fixedSize(horizontal: false, vertical: false)
                            .frame(maxWidth: .infinity,
                                   maxHeight: .infinity,
                                   alignment: .topLeading)
                    }
                    .frame(height: Constants.translationViewHeight,
                           alignment: .bottom)
                }.padding(Constants.buttonPadding)
            }
        }
    }
}

struct FontEditorView_Previews: PreviewProvider {
    static var previews: some View {
        FontEditorView()
            .environmentObject(FontEditorModel())
            .frame(width: 800, height: 600)
    }
}
