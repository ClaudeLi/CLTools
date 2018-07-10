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

#else

#import "NSDictionary+CLDictionary.h"
#import "NSString+CLString.h"
#import "UIColor+CLColor.h"
#import "UIView+CLView.h"

#endif /* CLTools_h */
