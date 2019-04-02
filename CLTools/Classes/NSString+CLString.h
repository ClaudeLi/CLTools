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

 @return BOOL
 */
- (BOOL)isNilOrEmpty;

/**
 *  判断字符串是否为空
 */
+ (BOOL)isNilOrEmptyString:(nullable NSString *)string;

/**
 *  object转json格式字符串
 */
+ (nullable NSString*)jsonStringWithObject:(nullable id)object;

/**
 *  js交互, 特殊字符处理 替换'->\\'
 */
+ (nullable NSString *)jsonStringForJSWithObject:(nullable id)object;

/**
 *  数组转字符串, connector: 连接符
 */
+ (nullable NSString *)stringWithArray:(nullable NSArray *)array connector:(nullable NSString *)connector;

/**
 *  字符串转数组, separate: 分割符
 */
- (nullable NSArray *)toArrayWithSeparate:(nullable NSString *)separate;

/**
 *  URLEncode
 */
- (nullable NSString *)URLEncodedString;

/**
 *  URLDecode
 */
- (nullable NSString *)URLDecodedString;

@end
