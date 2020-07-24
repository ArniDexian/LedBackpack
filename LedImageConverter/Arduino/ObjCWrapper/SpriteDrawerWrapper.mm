//
//  SpriteDrawerWrapper.m
//  LedImageConverter
//
//  Created by Arni Dexian on 10/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

#import "SpriteDrawerWrapper.hpp"
#import "LedImageConverter-Swift.h"
#import "../CppSources/LEDMatrix.hpp"
#import "../CppSources/Assets/sprites.h"
#import "../CppSources/SpriteDrawer.h"


@interface SpriteDrawerWrapper () {
    SpriteDrawer* drawer;
}
@end

@implementation SpriteDrawerWrapper

- (instancetype)initWithDisplayWrapper:(DisplayWrapper*)displayWrapper width:(uint8_t)width height:(uint8_t)height {
    self = [super initWithDisplayWrapper:displayWrapper width:width height:height];
    if (self) {
        self->drawer = new SpriteDrawer(self->ledMatrix);
    }
    return self;
}

- (void)dealloc {
    [self stop];
    delete self->drawer;
}

- (void)play {
//    [self startLoop];
    self->drawer->repeats = 0;
    self->drawer->sprite = &spriteMshrm;
    self->drawer->play();
}

- (void)stop {
    self->drawer->stop();
//    [self stopLoop];
}

- (void)update {
    drawer->update();
}

//- (void)startLoop {
//    __weak typeof(self) welf = self;
//    self.timer = [NSTimer scheduledTimerWithTimeInterval: 1.0 / 60.0 repeats: true block:^(NSTimer * _Nonnull timer) {
//        typeof(self) strongSelf = welf;
//        if (strongSelf == nil) {
//            return;
//        }
//        strongSelf->drawer->update();
//    }];
//}
//
//- (void)stopLoop {
//    if ([self.timer isValid]) {
//        [self.timer invalidate];
//    }
//}

@end
