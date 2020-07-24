//
//  EffectsListModel.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 06/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import SwiftUI

final class EffectsListModel: ObservableObject {
    let effects: [Effect]
    @Published var selectedEffect: Effect? {
        didSet {
            oldValue?.displayableEffect.stop()
            selectedEffect?.displayableEffect.start()
        }
    }

    init() {
        let _effects = [
            Effect(name: "Font component",
                   displayableEffect: FontComponent(fontSize: .min)
            ),
            Effect(name: "Sprite Player",
                   displayableEffect: SpriteComponent()
            ),
        ]

        effects = _effects
        selectedEffect = effects[0]
    }
}
