//
//  UIImage+CLImage.h
//  CLTools
//
//  Created by ClaudeLi on 2018/9/3.
//

#import <UIKit/UIKit.h>

@interface UIImage (CLImage)

+ (UIImage *)imageGIFWithData:(NSData *)data;

- (BOOL)isGIF;

@end
