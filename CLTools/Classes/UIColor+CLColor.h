//
//  UIColor+CLColor.h
//  CLTools
//
//  Created by ClaudeLi on 2018/6/5.
//  Copyright © 2018年 claudeli@yeah.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CLColor)

FOUNDATION_EXTERN UIColor *rgba(CGFloat r, CGFloat g, CGFloat b, CGFloat a);
FOUNDATION_EXTERN UIColor *rgbaDP3(CGFloat r, CGFloat g, CGFloat b, CGFloat a) NS_AVAILABLE_IOS(10_0);

// 随机色
+(UIColor *)randomColor;

@end
