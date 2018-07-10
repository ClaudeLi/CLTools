#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "CLTools.h"
#import "NSDictionary+CLDictionary.h"
#import "NSString+CLString.h"
#import "UIColor+CLColor.h"
#import "UIDevice+CLDevice.h"
#import "UIView+CLView.h"

FOUNDATION_EXPORT double CLToolsVersionNumber;
FOUNDATION_EXPORT const unsigned char CLToolsVersionString[];

