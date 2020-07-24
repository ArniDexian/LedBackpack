//
//  SpritePlayer.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 04/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import SwiftUI

struct SpritePlayerView: View {
    @ObservedObject var player: SpritePlayer

    var body: some View {
        VStack() {
            player.frame.map { frame in
                DisplayView(matrix: frame.colorMap)
            }

            HStack(alignment: .center) {
                Button(action: {
                    switch self.player.state {
                    case .idle:
                        self.player.play()
                    case .playing:
                        self.player.pause()
                    case .paused:
                        self.player.resume()
                    }

                }) {
                    Text(self.player.state.playButtonTitle)
                        .font(.subheadline)
                }

                Button(action: {
                    self.player.stop()
                }) {
                    Text("Stop").font(.subheadline)
                }
            }
        }
    }

    init(player: SpritePlayer) {
        self.player = player
    }

    init(sprite: Sprite) {
        player = SpritePlayer(sprite: sprite)
    }
}

extension SpritePlayer.State {
    var playButtonTitle: String {
        switch self {
        case .idle:
            return "Play"
        case .playing:
            return "Pause"
        case .paused:
            return "Resume"
        }
    }
}

//struct SpritePlayer_Previews: PreviewProvider {
//    static var previews: some View {
//        SpritePlayerView(player: SpritePlayer(sprite: Sprite(name: "test", frames: [
//            Sprite.Frame(colorMap: try! Matrix(data: [
//                [.red, .red, .red],
//                [.red, .red, .red],
//                [.red, .red, .red]
//            ]), duration: 0.5),
//
//            Sprite.Frame(colorMap: try! Matrix(data: [
//                [.green, .green, .red],
//                [.green, .green, .red],
//                [.red, .red, .red]
//            ]), duration: 0.5),
//
//            Sprite.Frame(colorMap: try! Matrix(data: [
//                [.blue, .red, .red],
//                [.red, .red, .red],
//                [.red, .red, .red]
//            ]), duration: 0.5)
//
//            ]))).frame(width: 400, height: 400)
//    }
//}
