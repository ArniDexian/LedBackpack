//
//  Sprite.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 04/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import SwiftUI

protocol SpriteFrame {
    var colorMap: Matrix<NSColor> { get }
    var duration: TimeInterval? { get }
}

struct Sprite: Identifiable {
    let id: UUID
    let frames: [SpriteFrame]
    let name: String

    init(id: UUID = UUID(), name: String, frames: [SpriteFrame]) {
        self.id = id
        self.name = name
        self.frames = frames
    }
}

struct IndexedColorFrame: SpriteFrame {
    let indexedColors: [NSColor]
    let indexMap: Matrix<UInt8>

    let duration: TimeInterval?

    var colorMap: Matrix<NSColor>

    init(indexedColors: [NSColor], indexMap: Matrix<UInt8>, duration: TimeInterval? = nil) {
        self.indexedColors = indexedColors
        self.indexMap = indexMap

        var matrix = Matrix<NSColor>(rows: indexMap.rows, columns: indexMap.columns, repeating: .black)
        for (row, col, index) in indexMap {
            matrix[row, col] = indexedColors[Int(index)]
        }
        self.colorMap = matrix
        self.duration = duration
    }
}

struct ColorMapFrame: SpriteFrame {
    let colorMap: Matrix<NSColor>
    let duration: TimeInterval?
}
