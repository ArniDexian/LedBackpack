//
//  SpriteDrawer.h
//  LedImageConverter
//
//  Created by Arni Dexian on 10/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

#ifndef SpriteDrawer_hpp
#define SpriteDrawer_hpp

#include "Arduino.hpp"
#include "LEDMatrix.hpp"
#include "Sprite.h"
#include "Ticker.h"

class SpriteDrawer {
    LEDMatrix* display;
    Ticker drawTicker;
    uint16_t currentFrame;

public:
    uint16_t repeats;
    uint16_t frameDuration;
    bool isPlaying;
    Sprite* sprite;

    SpriteDrawer(LEDMatrix* display);

    void play();
    void stop();
    void next();

    // emulates Arduino's loop
    void update();

    void drawNextFrame();
private:
    void draw(const uint32_t* colorPalette, const uint8_t* colorMap);
};

#endif /* SpriteDrawer_hpp */
