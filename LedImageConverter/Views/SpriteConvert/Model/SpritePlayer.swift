//
//  SpritePlayer.swift
//  LedImageConverter
//
//  Created by Arni Dexian on 04/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

import SwiftUI

final class SpritePlayer: ObservableObject {
    enum State: CaseIterable {
        case idle
        case playing
        case paused
    }

    let defaultInterval: TimeInterval = 0.25
    let sprite: Sprite

    @Published private(set) var state: State = .idle
    @Published private(set) var frame: SpriteFrame?
    @Published private(set) var currentFrameIndex: Int?

    private(set) var repeats: Bool = true

    private weak var nextFrameDispath: DispatchWorkItem?

    init(sprite: Sprite) {
        self.sprite = sprite
        self.currentFrameIndex = 0
        displayFrame()
    }

    @discardableResult
    func play(repeats: Bool = true) -> SpritePlayer {
        stop()
        currentFrameIndex = 0
        self.repeats = repeats
        state = .playing

        playFrame()

        return self
    }

    private func playFrame() {
        if let index = currentFrameIndex, index >= sprite.frames.count {
            currentFrameIndex = 0
        }

        state = .playing
        displayFrame()
        dispatchNextFrame()
    }

    private func displayFrame() {
        guard let index = currentFrameIndex else { return }
        frame = sprite.frames[index]
    }

    private func dispatchNextFrame() {
        guard let index = currentFrameIndex else { return }
        let nextIndex = index + 1
        guard nextIndex < sprite.frames.count || repeats else {
            state = .idle
            return
        }

        var nextFrame: DispatchWorkItem!
        nextFrame = DispatchWorkItem { [weak self] in
            guard !nextFrame.isCancelled else { return }
            self?.currentFrameIndex = nextIndex
            self?.playFrame()
        }

        let interval = frame?.duration ?? defaultInterval

        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Int(interval * 1000)),
                                      execute: nextFrame)

        nextFrameDispath = nextFrame
    }

    @discardableResult
    func pause() -> SpritePlayer {
        nextFrameDispath?.cancel()
        state = .paused
        return self
    }

    @discardableResult
    func resume() -> SpritePlayer {
        playFrame()
        return self
    }

    @discardableResult
    func stop() -> SpritePlayer {
        nextFrameDispath?.cancel()
        state = .idle
        currentFrameIndex = 0
        displayFrame()
        return self
    }
}
