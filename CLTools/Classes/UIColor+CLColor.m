//
//  UIColor+CLColor.m
//  CLTools
//
//  Created by ClaudeLi on 2018/6/5.
//  Copyright © 2018年 claudeli@yeah.net. All rights reserved.
//

#import "UIColor+CLColor.h"

@implementation UIColor (CLColor)

// 随机色
+(UIColor *)randomColor{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

+(UIColor *)colorWithR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b a:(CGFloat)a{
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a];
}

+(UIColor *)colorWithDP3R:(CGFloat)r g:(CGFloat)g b:(CGFloat)b a:(CGFloat)a{
    return [UIColor colorWithDisplayP3Red:r/255.0f green:g/255.0f blue:b/255.0f alpha:a];
}

@end
