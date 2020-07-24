//
//  FontContentWrapper.h
//  LedImageConverter
//
//  Created by Arni Dexian on 08/05/2020.
//  Copyright © 2020 ArniDexian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContentWrapper.hpp"

NS_ASSUME_NONNULL_BEGIN

@class DisplayWrapper;

@interface FontContentWrapper : ContentWrapper
- (void)displayText:(NSString*)text color:(UInt32)color;
@end

NS_ASSUME_NONNULL_END
