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
+ (nullable NSDictionary *)dictionaryWithQueryString:(nullable NSString *)string;

// json字符串转字典
+ (nullable NSDictionary *)dictionaryWithJsonString:(nullable NSString *)jsonString;

// 转json格式字符串
+ (nullable NSString*)toJsonString;

// 转json格式字符串, 去除格式化
+ (nullable NSString *)toJsonStringDelFormat;

// 转json格式字符串, js交互处理特殊字符"'"
+ (nullable NSString *)toJSJsonString;


@end
