//
//  SpriteDrawerWrapper.h
//  LedImageConverter
//
//  Created by Arni Dexian on 10/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContentWrapper.hpp"

NS_ASSUME_NONNULL_BEGIN

@interface SpriteDrawerWrapper : ContentWrapper
- (void)play;
- (void)stop;
@end

NS_ASSUME_NONNULL_END
