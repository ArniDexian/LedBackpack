//
//  LEDMatrix.h
//  LedImageConverter
//
//  Created by Arni Dexian on 07/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

#ifndef LEDMatrix_h
#define LEDMatrix_h

#include "Arduino.hpp"

class LEDMatrix {
    uint32_t ledColors[144];
    void* displayWrapper;

   public:
    const uint8_t rows;
    const uint8_t columns;

    LEDMatrix(void* displayWrapper, uint8_t rows, uint8_t columns)
        : displayWrapper(displayWrapper), rows(rows), columns(columns) {}

    void setColor(uint8_t x, uint8_t y, uint32_t color);

    void flush();

    void clear(bool _flush = true);
};

#endif /* LEDMatrix_h */
