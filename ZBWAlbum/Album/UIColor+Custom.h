//
//  UIColor+Custom.h
//  TZVideo
//
//  Created by TanZhou on 09/04/2018.
//  Copyright © 2018 tztv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Custom)

+ (instancetype)colorWithHexString:(NSString *)hexStr;

+ (instancetype)colorWithHexString:(NSString *)hexStr alpha:(CGFloat)alpha;

@end
