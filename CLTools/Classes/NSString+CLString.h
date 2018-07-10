//
//  NSString+CLString.h
//  CLTools
//
//  Created by ClaudeLi on 2018/6/5.
//  Copyright © 2018年 claudeli@yeah.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CLString)

/**
 判断字符串是否为空
 */
+ (BOOL)isNilOrEmpty:(NSString *)string;

/**
 object转json格式字符串
 */
+ (NSString*)jsonStringWithObject:(id)object;

/**
 去除 " "、"\n"格式
 */
+ (NSString *)jsonStringDelFormatWithObject:(id)object;

/**
 js交互, 特殊字符处理 替换'->\\'
 */
+ (NSString *)jsonStringForJSWithObject:(id)object;

/**
 数组转字符串, connector: 连接符
 */
+ (NSString *)stringWithArray:(NSArray *)array connector:(NSString *)connector;

/**
 字符串转数组, separate: 分割符
 */
- (NSArray *)toArrayWithSeparate:(NSString *)separate;

#pragma mark -
#pragma mark -- 钥匙串操作 --

/**
 保存到钥匙串

 @param sValue  value
 @param sKey    key
 */
+ (void)saveKeychainValue:(NSString *)sValue key:(NSString *)sKey;

/**
 根据key读取钥匙串中的value

 @param sKey key
 @return     value
 */
+ (NSString *)readKeychainValue:(NSString *)sKey;

/**
 删除钥匙串中对应的key-value

 @param sKey key
 */
+ (void)deleteKeychainValue:(NSString *)sKey;

@end
