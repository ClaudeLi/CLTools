//
//  NSString+CLString.m
//  CLTools
//
//  Created by ClaudeLi on 2018/6/5.
//  Copyright © 2018年 claudeli@yeah.net. All rights reserved.
//

#import "NSString+CLString.h"

@implementation NSString (CLString)

- (BOOL)isNilOrEmpty {
    return [NSString isNilOrEmptyString:self];
}

+ (BOOL)isNilOrEmptyString:(NSString *)string {
    if (string == nil ||
        string == NULL ||
        [string isEqual:@"null"] ||
        [string isEqual:[NSNull null]] ||
        [string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    if (!string.length) {
        return YES;
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if([string isEqualToString:@"(null)"]){
        return YES;
    }
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    return NO;
}

// 字典转json格式字符串
+ (NSString*)jsonStringWithObject:(id)object {
    if ([object isKindOfClass:[NSString class]]) {
        return (NSString *)object;
    } else if ([object isKindOfClass:[NSData class]]) {
        return [[NSString alloc] initWithData:(NSData *)object encoding:NSUTF8StringEncoding];
    }
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:kNilOptions
                                                         error:&error];
    if (error) {
        NSLog(@"error=%@", error);
        return @"";
    }
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

// js交互 \\'
+ (NSString *)jsonStringForJSWithObject:(id)object {
    NSString *jsonString = [self jsonStringWithObject:object];
    if (!jsonString.length) {
        return @"";
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0, mutStr.length};
    [mutStr replaceOccurrencesOfString:@"'" withString:@"\\'" options:NSLiteralSearch range:range];
    return mutStr;
}

/**
 *  数组转字符串, connector: 连接符
 */
+ (NSString *)stringWithArray:(NSArray *)array connector:(NSString *)connector {
    return [array componentsJoinedByString:connector];
}

/**
 *  字符串转数组, separate: 分割符
 */
- (NSArray *)toArrayWithSeparate:(NSString *)separate {
    return [self componentsSeparatedByString:separate];
}

/**
 *  URLEncode
 */
- (NSString *)URLEncodedString
{
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    
    NSString *unencodedString = self;
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}

/**
 *  URLDecode
 */
-(NSString *)URLDecodedString
{
    //NSString *decodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    
    NSString *encodedString = self;
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)encodedString,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}

@end
