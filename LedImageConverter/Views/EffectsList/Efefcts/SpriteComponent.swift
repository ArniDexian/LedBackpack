//
//  SpriteComponent.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 10/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import Foundation
import class AppKit.NSColor

final class SpriteComponent {
    private let controller: DisplayController
    private var contentWrapped: SpriteDrawerWrapper?

    init(displaySize: PointSize = constants.displaySize) {
        self.controller = DisplayController(rows: displaySize.rows, columns: displaySize.columns)
    }
}

extension SpriteComponent: DisplayableEffect {
//    enum Properties: String, CustomStringConvertible {
//
//        var description: String {
//            rawValue
//        }
//    }
    var availableProperties: Set<Property> {
        Set()
    }

    var displayController: DisplayController {
        controller
    }

    func start() {
        // TODO: extract super class for every component coz this block everywhere is the same
        let displayWrapper = DisplayWrapper(display: controller)
        contentWrapped = SpriteDrawerWrapper(displayWrapper: displayWrapper,
                                             width: UInt8(controller.matrix.columns),
                                             height: UInt8(controller.matrix.rows))
        contentWrapped?.play()
    }

    func stop() {
        contentWrapped = nil
    }

    func update(property: Property) { }
}
