//
//  UIDevice+CLDevice.h
//  CLTools
//
//  Created by ClaudeLi on 2018/6/5.
//  Copyright © 2018年 claudeli@yeah.net. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXTERN NSString * _Nonnull UUIDKeychainKey(void);

@interface UIDevice (CLDevice)

// 当前应用软件版本
+ (nonnull NSString *)appVersion;

// 当前应用软件名称
+ (nonnull NSString *)appName;

// UUID write to the Keychain
+ (nonnull NSString *)uuid;

// IDFV
+ (nonnull NSString *)idfv;

// IDFA 广告标识符
+ (nonnull NSString *)idfa;

// macAddress
+ (nonnull NSString *)macAddress;

// 设备型号, e.g. "iPhone6,1" "iPad4,6"
+ (nonnull NSString *)deviceModel;

// 设备型号名称, e.g. "iPhone 5s" "iPad mini 2"
+ (nonnull NSString *)deviceModelName;

#pragma mark - 钥匙串
/**
 保存到钥匙串
 
 @param sValue  value
 @param sKey    key
 */
+ (void)saveKeychainValue:(NSString *_Nullable)sValue key:(NSString *_Nullable)sKey;

/**
 根据key读取钥匙串中的value
 
 @param sKey key
 @return     value
 */
+ (nullable NSString *)readKeychainValue:(NSString *_Nullable)sKey;

/**
 删除钥匙串中对应的key-value
 
 @param sKey key
 */
+ (void)deleteKeychainValue:(NSString *_Nullable)sKey;

#pragma mark - save to Ablum
/**
 保存图片至相册

 @param image 图片
 @param completion completion
 */
+ (void)saveImageToAblum:(nullable UIImage *)image
              completion:(nullable void (^)(BOOL success, id _Nullable asset))completion;

/**
 保存文件至相册
 
 @param url 文件地址
 @param completion completion
 */
+ (void)saveFileToAblumWithURL:(nullable NSURL *)url
                    completion:(nullable void (^)(BOOL success, id _Nullable asset))completion;

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
+ (BOOL)isLandscape;

@end
