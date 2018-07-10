//
//  UIDevice+CLDevice.h
//  CLTools
//
//  Created by ClaudeLi on 2018/6/5.
//  Copyright © 2018年 claudeli@yeah.net. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXTERN NSString *UUIDKeychainKey(void);

@interface UIDevice (CLDevice)

// 当前应用软件版本
+ (NSString *)appVersion;

// 当前应用软件名称
+ (NSString *)appName;

// UUID write to the Keychain
+ (NSString *)uuid;

// IDFV
+ (NSString *)idfv;

// IDFA 广告标识符
+ (NSString *)idfa;

// macAddress
+ (NSString *)macAddress;

// 设备型号, e.g. "iPhone6,1" "iPad4,6"
+ (NSString *)deviceModel;

// 设备型号名称, e.g. "iPhone 5s" "iPad mini 2"
+ (NSString *)deviceModelName;

#pragma mark - 钥匙串
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


#pragma mark - Orientation
/**
 *  切换横竖屏
 *
 *  @param orientation ：UIInterfaceOrientation
 */
+ (void)setOrientation:(UIInterfaceOrientation)orientation;

/**
 *  判断是否竖屏
 *
 *  @return 布尔值
 */
+ (BOOL)isOrientationLandscape;

@end
