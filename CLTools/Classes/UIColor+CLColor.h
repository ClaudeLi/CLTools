//
//  UIColor+CLColor.h
//  CLTools
//
//  Created by ClaudeLi on 2018/6/5.
//  Copyright © 2018年 claudeli@yeah.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CLColor)

// 随机色
+(UIColor *)randomColor;

// RGBA
+(UIColor *)colorWithR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b a:(CGFloat)a;

// DisplayP3 RGBA >iOS10.0
+(UIColor *)colorWithDP3R:(CGFloat)r g:(CGFloat)g b:(CGFloat)b a:(CGFloat)a NS_AVAILABLE_IOS(10_0);

@end
