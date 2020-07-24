//
//  Arduino.cpp
//  LedImageConverter
//
//  Created by Arni Dexian on 09/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

#include "Arduino.hpp"
#import <Foundation/Foundation.h>
NSDate* bootLoadDate;

void arduinoBootload() {
    bootLoadDate = [NSDate date];
}

unsigned long millis() {
    if (bootLoadDate == nil) {
        arduinoBootload();
    }
    unsigned long interval = (unsigned long)([[NSDate date] timeIntervalSinceDate: bootLoadDate] * 1E3);
    return interval;
}

unsigned long micros() {
    if (bootLoadDate == nil) {
        arduinoBootload();
    }
    unsigned long interval = (unsigned long)([[NSDate date] timeIntervalSinceDate: bootLoadDate] * 1E6);
    return interval;
}
