//
//  EffectsListView.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 06/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import SwiftUI

struct EffectListRow: View {
    let item: Effect

    var body: some View {
        VStack(alignment: .leading) {
            Text(item.name)
                .font(.subheadline)
                .frame(height: 20, alignment: .center)
        }
    }
}

struct EffectsListView: View {
    @EnvironmentObject var model: EffectsListModel

    var body: some View {
        NavigationView {
            List(selection: $model.selectedEffect) {
                ForEach(model.effects) { (e) in
                    EffectListRow(item: e).tag(e)
                }.onAppear {
                    // TODO: fix that "preselected item" hack
                    self.model.selectedEffect = self.model.selectedEffect
                }
            }
            .listStyle(SidebarListStyle())
            .frame(width: 200)

            if model.selectedEffect != nil {
                EffectView(effect: model.selectedEffect!)
            }
        }
    }
}

struct EffectsListView_Previews: PreviewProvider {
    static var previews: some View {
        EffectsListView()
            .frame(width: 640, height: 480)
            .environmentObject(EffectsListModel())
    }
}
