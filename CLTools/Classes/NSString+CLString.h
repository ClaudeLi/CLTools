//
//  NSString+CLString.h
//  CLTools
//
//  Created by ClaudeLi on 2018/6/5.
//  Copyright © 2018年 claudeli@yeah.net. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 目录路径
 
 @param dir 目录
 @return path string
 */
static inline NSString *NSPathAtDir(NSSearchPathDirectory dir){
    return [NSSearchPathForDirectoriesInDomains(dir, NSUserDomainMask, YES) firstObject];
}

/**
 Document目录路径
 
 @return path string
 */
static inline NSString *NSDocumentDirPath(void){
    static NSString *document;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        document = NSPathAtDir(NSDocumentDirectory);
    });
    return document;
}

/**
 Library目录路径
 
 @return path string
 */
static inline NSString *NSLibraryDirPath(void){
    static NSString *library;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        library = NSPathAtDir(NSLibraryDirectory);
    });
    return library;
}

/**
 Caches目录路径
 
 @return path string
 */
static inline NSString *NSCachesDirPath(void){
    static NSString *caches;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        caches = NSPathAtDir(NSCachesDirectory);
    });
    return caches;
}

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
