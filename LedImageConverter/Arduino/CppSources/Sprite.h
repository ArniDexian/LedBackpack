//
//  Sprite.h
//  LedImageConverter
//
//  Created by Arni Dexian on 14/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

#ifndef Sprite_hpp
#define Sprite_hpp

#include <stdio.h>

struct Sprite {
    const uint32_t* palette;
    const uint8_t framesCount;
    const uint8_t* framesSequence;
    const uint8_t* frameData;
};

#endif /* Sprite_hpp */
