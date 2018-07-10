//
//  NSDictionary+CLDictionary.m
//  CLTools
//
//  Created by ClaudeLi on 2018/6/5.
//  Copyright © 2018年 claudeli@yeah.net. All rights reserved.
//

#import "NSDictionary+CLDictionary.h"
#import "NSString+CLString.h"

@implementation NSDictionary (CLDictionary)

+ (NSDictionary *)dictionaryWithQueryString:(NSString *)string{
    NSArray *subArray = [string componentsSeparatedByString:@"&"];
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithCapacity:4];
    for (int j = 0 ; j < subArray.count; j++){
        NSArray *dicArray = [subArray[j] componentsSeparatedByString:@"="];
        if (dicArray && dicArray.count) {
            if (dicArray.count > 1) {
                NSString *valueStr = [dicArray[1] stringByRemovingPercentEncoding];
                [tempDic setObject:valueStr forKey:dicArray[0]];
            }else{
                [tempDic setObject:@"" forKey:dicArray[0]];
            }
        }
    }
    return tempDic;
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{
    if ([NSString isNilOrEmpty:jsonString]) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

// 转json格式字符串
+ (NSString*)toJsonString{
    return [NSString jsonStringWithObject:self];
}

// 转json格式字符串, 去除格式化
+ (NSString *)toJsonStringDelFormat{
    return [NSString jsonStringDelFormatWithObject:self];
}

// 转json格式字符串, 处理"'"
+ (NSString *)toJSJsonString{
    return [NSString jsonStringForJSWithObject:self];
}


@end
