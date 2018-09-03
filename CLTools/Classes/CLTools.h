//
//  CLTools.h
//  CLTools
//
//  Created by ClaudeLi on 2018/6/27.
//

#import <Foundation/Foundation.h>

#if __has_include(<CLTools/CLTools.h>)

FOUNDATION_EXPORT double CLToolsVersionNumber;
FOUNDATION_EXPORT const unsigned char CLToolsVersionString[];

#import <CLTools/NSDictionary+CLDictionary.h>
#import <CLTools/NSString+CLString.h>
#import <CLTools/UIColor+CLColor.h>
#import <CLTools/UIView+CLView.h>
#import <CLTools/UIDevice+CLDevice.h>
#import <CLTools/UIImage+CLImage.h>
#import <CLTools/CLFunctions.h>

#else

#import "NSDictionary+CLDictionary.h"
#import "NSString+CLString.h"
#import "UIColor+CLColor.h"
#import "UIView+CLView.h"
#import "UIDevice+CLDevice.h"
#import "UIImage+CLImage.h"
#import "CLFunctions.h"

#endif /* CLTools_h */
