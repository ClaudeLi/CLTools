//
//  NSString+CLString.m
//  CLTools
//
//  Created by ClaudeLi on 2018/6/5.
//  Copyright © 2018年 claudeli@yeah.net. All rights reserved.
//

#import "NSString+CLString.h"

@implementation NSString (CLString)

+ (BOOL)isNilOrEmptyString:(NSString *)string{
    if(string==nil||string==NULL||[string isEqual:@"null"]||[string isEqual:[NSNull null]]||[string isKindOfClass:[NSNull class]]){
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
+ (NSString*)jsonStringWithObject:(id)object{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (error) {
        NSLog(@"error=%@", error);
        return @"";
    }
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

// 去除' '、'\n'格式
+ (NSString *)jsonStringDelFormatWithObject:(id)object{
    NSString *jsonString = [self jsonStringWithObject:object];
    if (!jsonString.length) {
        return @"";
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0, jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0, mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

// js交互 \\'
+ (NSString *)jsonStringForJSWithObject:(id)object{
    NSString *str = [self jsonStringDelFormatWithObject:object];
    if (!str.length) {
        return @"";
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:str];
    NSRange range3 = {0, mutStr.length};
    [mutStr replaceOccurrencesOfString:@"'" withString:@"\\'" options:NSLiteralSearch range:range3];
    return mutStr;
}

/**
 *  数组转字符串, connector: 连接符
 */
+ (NSString *)stringWithArray:(NSArray *)array connector:(NSString *)connector{
    return [array componentsJoinedByString:connector];
}

/**
 *  字符串转数组, separate: 分割符
 */
- (NSArray *)toArrayWithSeparate:(NSString *)separate{
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
