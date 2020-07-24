//
//  ContentWrapper.m
//  LedImageConverter
//
//  Created by Arni Dexian on 16/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

#import "ContentWrapper.hpp"
#import "LedImageConverter-Swift.h"
#import "../CppSources/LEDMatrix.hpp"


@interface ContentWrapper () {
//    LEDMatrix* ledMatrix;
}
@property (nonatomic, weak) NSTimer* timer;
@property (nonatomic, strong) DisplayWrapper* displayWrapper;

@end

@implementation ContentWrapper

- (void)setUpdateInterval:(NSTimeInterval)updateInterval {
    _updateInterval = updateInterval;
    [self startLoop];
}

- (instancetype)initWithDisplayWrapper:(DisplayWrapper*)displayWrapper width:(uint8_t)width height:(uint8_t)height {
    self = [super init];
    if (self) {
        self.displayWrapper = displayWrapper;
        self->ledMatrix = new LEDMatrix((__bridge void*)self.displayWrapper, height, width);

        _updateInterval = 1. / 60.;
        [self startLoop];
    }
    return self;
}

- (void)dealloc {
    [self stopLoop];
    delete self->ledMatrix;
}

- (void)startLoop {
    [self stopLoop];
    __weak typeof(self) welf = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval: self.updateInterval
                                                 repeats: true
                                                   block: ^(NSTimer * _Nonnull timer) {
        typeof(self) _Nullable strongSelf = welf;
        [strongSelf fireUpdate];
    }];
}

- (void)fireUpdate {
    if ([self respondsToSelector:@selector(update)]) {
        [self update];
    } else {
        NSAssert(false, @"Need to override update function in subclass");
    }
}

- (void)stopLoop {
    if ([self.timer isValid]) {
        [self.timer invalidate];
    }
    self.timer = nil;
}

@end
