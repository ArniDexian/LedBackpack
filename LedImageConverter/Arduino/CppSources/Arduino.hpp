//
//  Arduino.hpp
//  LedImageConverter
//
//  Created by Arni Dexian on 09/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

#ifndef Arduino_hpp
#define Arduino_hpp

#define pgm_read_byte(address_short) (uint8_t)(*address_short)
#define pgm_read_dword(address_short) (uint32_t)(*address_short)

//#define ceil(a, b) (a + b - 1) / b
#define max(a, b)                    a > b ? a : b

#ifndef NULL
#define NULL (0)
#endif

unsigned long millis();
unsigned long micros();

typedef unsigned char  uint8_t;
typedef unsigned short uint16_t;
typedef short          int16_t;
typedef unsigned int uint32_t;

#endif /* Arduino_hpp */
