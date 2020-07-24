//
//  SpriteDrawer.cpp
//  LedImageConverter
//
//  Created by Arni Dexian on 10/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

#include "SpriteDrawer.h"
#include "Arduino.hpp"


void drawCallback(void* erasedDrawer) {
    ((SpriteDrawer*)erasedDrawer)->drawNextFrame();
}

SpriteDrawer::SpriteDrawer(LEDMatrix* display)
    : display(display), currentFrame(0), repeats(0), isPlaying(false), frameDuration(180), drawTicker(Ticker(drawCallback, 1, 0, MILLIS)) {
    drawTicker.userInfo = this;
}

void SpriteDrawer::play() {
    if (sprite == NULL) { return; }
    drawTicker.setInterval(frameDuration);
    drawTicker.setRepeats(repeats * sprite->framesCount);
    isPlaying = true;
    drawNextFrame();
    drawTicker.start();
}

void SpriteDrawer::stop() {
    isPlaying = false;
    drawTicker.stop();
    currentFrame = 0;
    display->clear();
}

void SpriteDrawer::update() {
    if (!isPlaying) { return; }
    drawTicker.update();
    if (drawTicker.state() == STOPPED) {
        stop();
    }
}

void SpriteDrawer::draw(const uint32_t* colorPalette, const uint8_t* colorMap) {
    for (uint8_t i = 0; i < display->rows; i++) {
        for (uint8_t j = 0; j < display->columns; j++) {
            int pxIndex = i * display->rows + j;

            uint8_t colorInd = pgm_read_byte(&(colorMap[pxIndex]));
            uint32_t color = pgm_read_dword(&(colorPalette[colorInd]));
            display->setColor(j, i, color);
        }
    }
}

void SpriteDrawer::drawNextFrame() {
    if (sprite == NULL) { return; };

    if (currentFrame >= sprite->framesCount) {
        currentFrame = 0;
    }

    uint8_t frameInd = pgm_read_byte(&(sprite->framesSequence[currentFrame]));

    draw(sprite->palette, sprite->frameData + (uint16_t)frameInd * ((uint16_t)display->rows * (uint16_t)display->columns));
    display->flush();

    currentFrame += 1;
}
