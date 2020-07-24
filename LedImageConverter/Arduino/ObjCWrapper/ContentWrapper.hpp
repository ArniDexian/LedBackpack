//
//  ContentWrapper.h
//  LedImageConverter
//
//  Created by Arni Dexian on 16/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class DisplayWrapper;
#ifdef __cplusplus
class LEDMatrix;
#else
typedef void LEDMatrix;
#endif

@interface ContentWrapper : NSObject {
    LEDMatrix* ledMatrix;
}

@property (nonatomic, assign) NSTimeInterval updateInterval;

- (instancetype)initWithDisplayWrapper:(DisplayWrapper*)displayWrapper width:(uint8_t)width height:(uint8_t)height;

/// Simulates Arduino's loop function call
- (void)update;

@end

NS_ASSUME_NONNULL_END
