//
//  EffectView.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 06/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import SwiftUI

struct EffectView: View {
    let effect: Effect

    var body: some View {
        VStack {
            Text(effect.name)
                .font(.headline)
                .foregroundColor(.green)

            Divider()
            
            DisplayView(controller: effect.displayableEffect.displayController)
        }
    }
}
