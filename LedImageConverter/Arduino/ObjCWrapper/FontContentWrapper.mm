//
//  FontContentWrapper.m
//  LedImageConverter
//
//  Created by Arni Dexian on 08/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

#import "FontContentWrapper.hpp"
#import "LedImageConverter-Swift.h"
#import "../CppSources/LEDMatrix.hpp"
#import "../CppSources/FontDrawer.h"

#define MAX_POINTERS 128

@interface FontContentWrapper () {
    FontDrawer* drawer;
    void* pointers[MAX_POINTERS];
}
@end

@implementation FontContentWrapper

- (instancetype)initWithDisplayWrapper:(DisplayWrapper*)displayWrapper width:(uint8_t)width height:(uint8_t)height {
    self = [super initWithDisplayWrapper:displayWrapper width:width height:height];
    if (self) {
        self->drawer = new FontDrawer(self->ledMatrix);
    }
    return self;
}

- (void)dealloc {
    delete self->drawer;
    for(int i = 0; i < MAX_POINTERS && pointers[i]; i++) {
        free(pointers[i]);
    }
}

- (void)displayText:(NSString*)text color:(UInt32)color {

    NSStringEncoding encoding = NSASCIIStringEncoding;
    const char* cstr = [[text uppercaseString] cStringUsingEncoding: encoding];

    char* copiedCStr = (char*)malloc(strlen(cstr) + 1);
    strcpy(copiedCStr, cstr);
    pointers[0] = copiedCStr;

    self->drawer->lineBreakMode = TextLineBreakModeScrollHorizontally;
    self->drawer->color = color;
    self->drawer->drawText(copiedCStr);
}

- (void)update {
    self->drawer->update();
}

@end
