//
//  Effect.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 06/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import SwiftUI

final class Effect: Identifiable {
    let id = UUID()
    let name: String
    let displayableEffect: DisplayableEffect

    init(name: String, displayableEffect: DisplayableEffect) {
        self.name = name
        self.displayableEffect = displayableEffect
    }
}

extension Effect: Hashable {
    static func == (lhs: Effect, rhs: Effect) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Effect: Equatable {
}

protocol DisplayableEffect {
    /// Retrieve all available properties for given effect
    var availableProperties: Set<Property> { get }

    /// Instance of DisplayController which controlls pixel data flow
    var displayController: DisplayController { get }

    func update(property: Property)

    func start()
    func stop()
}
