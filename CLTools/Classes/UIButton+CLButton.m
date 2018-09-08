//
//  UIButton+CLButton.m
//  CLTools
//
//  Created by ClaudeLi on 2018/9/8.
//

#import "UIButton+CLButton.h"
#import <objc/runtime.h>

static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;
@implementation UIButton (CLButton)

- (void)setEnlargeRadius:(CGFloat) size{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void) setEnlargeEdgeInset:(UIEdgeInsets)inset{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:inset.top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:inset.right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:inset.bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:inset.left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect) enlargedRect{
    NSNumber* topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge){
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    }else{
        return self.bounds;
    }
}

- (UIView*) hitTest:(CGPoint) point withEvent:(UIEvent*) event{
    CGRect rect = [self enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds) || self.hidden){
        return [super hitTest:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? self : nil;
}

- (void)exchangeImageTextEdgeInset{
    CGFloat imageWidth = self.imageView.frame.size.width;
    CGFloat titleWidth = self.titleLabel.frame.size.width;
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, titleWidth, 0, -titleWidth)];
}

@end
