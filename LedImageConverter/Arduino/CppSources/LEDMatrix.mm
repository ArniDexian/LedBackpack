//
//  LEDMatrix.cpp
//  LedImageConverter
//
//  Created by Arni Dexian on 08/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "LEDMatrix.hpp"
#import "LedImageConverter-Swift.h"

void LEDMatrix::setColor(uint8_t x, uint8_t y, uint32_t color) {
    [(__bridge DisplayWrapper*)displayWrapper setWithColor:color row:y column:x];
}

void LEDMatrix::flush() {
    [(__bridge DisplayWrapper*)displayWrapper flush];
}

void LEDMatrix::clear(bool _flush) {
    [(__bridge DisplayWrapper*)displayWrapper clear];
}
