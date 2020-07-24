//
//  SpriteConverterModel.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 03/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import SwiftUI

final class SpriteConverterModel: ObservableObject {
    @Published var rows: [SpriteRowModel]
    @Published var spritePlayer: SpritePlayer?
    @Published var selectedSprite: ImageProcessor.SpriteRepresentation?

    private var sprites: [ImageProcessor.SpriteRepresentation]

    init() {
        sprites = ImageProcessor().process()?.sprites ?? []
        rows = sprites.map { sprite in
            let image = Image(nsImage: sprite.frames.first?
                .frame.erased.colorMap
                .image(scale: 3, orienation: .downMirrored)
                ?? NSImage())
            return SpriteRowModel(preview: image, name: sprite.name)
        }
        
        if let frow = rows.first {
            select(row: frow)
        }
    }

    func select(row: SpriteRowModel) {
        selectedSprite = sprites.first(where: { $0.name == row.name })
        if let sprite = selectedSprite?.sprite {
            spritePlayer = SpritePlayer(sprite: sprite)
        } else {
            spritePlayer = nil
        }
    }
}

extension ImageProcessor.SpriteRepresentation {
    var sprite: Sprite {
        return Sprite(name: name,
                      frames: frames.map { $0.frame.erased })
    }
}
