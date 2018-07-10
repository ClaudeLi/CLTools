//
//  NSDictionary+CLDictionary.h
//  CLTools
//
//  Created by ClaudeLi on 2018/6/5.
//  Copyright © 2018年 claudeli@yeah.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (CLDictionary)

// URL.query 转字典
+ (NSDictionary *)dictionaryWithQueryString:(NSString *)string;

// json字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

// 转json格式字符串
+ (NSString*)toJsonString;

// 转json格式字符串, 去除格式化
+ (NSString *)toJsonStringDelFormat;

// 转json格式字符串, js交互处理特殊字符"'"
+ (NSString *)toJSJsonString;


@end
