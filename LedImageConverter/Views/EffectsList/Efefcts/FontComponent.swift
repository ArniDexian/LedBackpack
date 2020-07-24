//
//  FontComponent.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 06/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import Foundation
import class AppKit.NSColor

final class FontComponent {
    private let controller: DisplayController
    let fontSize: FontSize
    private var contentWrapped: FontContentWrapper?

    init(fontSize: FontSize, displaySize: PointSize = constants.displaySize) {
        self.fontSize = fontSize
        self.controller = DisplayController(rows: displaySize.rows, columns: displaySize.columns)
    }
}

extension FontComponent: DisplayableEffect {
    enum Properties: String, CustomStringConvertible {
        case fontSize = "Font size"
        var description: String {
            rawValue
        }
    }

    var availableProperties: Set<Property> {
        Set([
            Property(name: Properties.fontSize.description, value: .fontSize(fontSize))
        ])
    }

    var displayController: DisplayController {
        controller
    }

    func start() {
        // wrap DisplayController into Obj wrapper
        let displayWrapper = DisplayWrapper(display: controller)
        // pass it to ObjC's wrapper for target C++ functionality
        contentWrapped = FontContentWrapper(displayWrapper: displayWrapper,
                                            width: UInt8(controller.matrix.columns),
                                            height: UInt8(controller.matrix.rows))
        contentWrapped?.displayText("PSIHO3%", color: NSColor.green.systemsHexRbgColor)
        //        contentWrapped.displayText(" long", color: NSColor.red.systemsHexRbgColor)
        //        contentWrapped.displayText(" text", color: NSColor.red.systemsHexRbgColor)
        //        contentWrapped.displayText("to", color: NSColor.red.systemsHexRbgColor)
        //        contentWrapped.displayText("to", color: NSColor.red.systemsHexRbgColor)
    }

    func stop() {
        contentWrapped = nil
    }

    func update(property: Property) {
//        switch Properties(rawValue: property.name) {
//        case .some(.fontSize):
//
//        case .none: break
//        }
    }
}
