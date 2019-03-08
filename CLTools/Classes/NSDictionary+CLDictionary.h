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

@end
