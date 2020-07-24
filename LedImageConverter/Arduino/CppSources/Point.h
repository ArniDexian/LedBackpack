
//
//  Point.hpp
//  LedImageConverter
//
//  Created by Arni Dexian on 16/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

#ifndef Point_hpp
#define Point_hpp

#include "Arduino.hpp"

struct Point2D {
    int16_t x;
    int16_t y;

    Point2D(int16_t x, int16_t y);

    void addX(int16_t x);
    void addY(int16_t y);
    void addXY(int16_t x, int16_t y);

    /// set x, y to 0
    void nullify();
};

#endif /* Point_hpp */
