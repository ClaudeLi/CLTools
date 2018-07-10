//
//  NSString+CLString.m
//  CLTools
//
//  Created by ClaudeLi on 2018/6/5.
//  Copyright © 2018年 claudeli@yeah.net. All rights reserved.
//

#import "NSString+CLString.h"

@implementation NSString (CLString)

- (BOOL)isNilOrEmpty{
    return [NSString isNilOrEmptyString:self];
}

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

+ (NSString *)stringWithArray:(NSArray *)array connector:(NSString *)connector{
    return [array componentsJoinedByString:connector];
}

- (NSArray *)toArrayWithSeparate:(NSString *)separate{
    return [self componentsSeparatedByString:separate];
}

@end
