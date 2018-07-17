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
 *  判断字符串是否为空
 */
+ (BOOL)isNilOrEmptyString:(NSString *)string;

/**
 *  object转json格式字符串
 */
+ (NSString*)jsonStringWithObject:(id)object;

/**
 *  去除 " "、"\n"格式
 */
+ (NSString *)jsonStringDelFormatWithObject:(id)object;

/**
 *  js交互, 特殊字符处理 替换'->\\'
 */
+ (NSString *)jsonStringForJSWithObject:(id)object;

/**
 *  数组转字符串, connector: 连接符
 */
+ (NSString *)stringWithArray:(NSArray *)array connector:(NSString *)connector;

/**
 *  字符串转数组, separate: 分割符
 */
- (NSArray *)toArrayWithSeparate:(NSString *)separate;

/**
 *  URLEncode
 */
- (NSString *)URLEncodedString;

/**
 *  URLDecode
 */
- (NSString *)URLDecodedString;

@end
