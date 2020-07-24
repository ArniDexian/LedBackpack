//
//  SpriteConverterView.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 01/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import SwiftUI

struct SpriteConverterView: View {
    struct Constants {
        static let listWidth: CGFloat = 130
    }

    @EnvironmentObject var model: SpriteConverterModel

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            List(model.rows) { n in
                IconTitleRow(model: .init(spriteRow: n,
                                          selected: self.model.selectedSprite?.name == n.name))
                    .onTapGesture {
                        self.model.select(row: n)
                }
            }.frame(width: Constants.listWidth, alignment: .topLeading)

            model.spritePlayer.map { pl in
                SpritePlayerView(player: pl)
            }
        }
    }
}

struct SpriteConverterView_Previews: PreviewProvider {
    static var previews: some View {
        SpriteConverterView()
            .environmentObject(SpriteConverterModel())
    }
}
