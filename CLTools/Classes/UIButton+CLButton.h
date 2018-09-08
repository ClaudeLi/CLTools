//
//  UIButton+CLButton.h
//  CLTools
//
//  Created by ClaudeLi on 2018/9/8.
//

#import <UIKit/UIKit.h>

@interface UIButton (CLButton)

/**
 扩大点击范围
 
 @param size 扩大半径
 */
- (void)setEnlargeRadius:(CGFloat)size;

/**
 扩大点击范围
 
 @param inset inset
 */
- (void)setEnlargeEdgeInset:(UIEdgeInsets)inset;

/**
 交换图片/title位置
 */
- (void)exchangeImageTextEdgeInset;

@end
