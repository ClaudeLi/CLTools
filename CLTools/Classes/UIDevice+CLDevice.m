//
//  UIDevice+CLDevice.m
//  CLTools
//
//  Created by ClaudeLi on 2018/6/5.
//  Copyright © 2018年 claudeli@yeah.net. All rights reserved.
//

#import "UIDevice+CLDevice.h"
#import "NSString+CLString.h"
// IDFA
#import <AdSupport/AdSupport.h>
// MacAddress
#import <SystemConfiguration/CaptiveNetwork.h>
// deviceModel
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <Photos/Photos.h>

NSString *UUIDKeychainKey(){
    static NSString *uuidKey;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        uuidKey = [NSString stringWithFormat:@"%@.uuid", [NSBundle mainBundle].bundleIdentifier];
    });
    return uuidKey;
}

@implementation UIDevice (CLDevice)

+ (NSString *)appVersion{
    static NSString *appCurVersion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    });
    return appCurVersion;
}

+ (NSString *)appName{
    static NSString *appCurName;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        appCurName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    });
    return appCurName;
}

+ (NSString *)uuid{
    static NSString *uuidStr;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        uuidStr = [self readKeychainValue:UUIDKeychainKey()];
        if (!uuidStr) {
            uuidStr = self.idfv;
            [self saveKeychainValue:uuidStr key:UUIDKeychainKey()];
        }
    });
    return uuidStr;
}

+ (NSString *)idfv{
    static NSString *idfvStr;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSUUID *uuid = [[UIDevice currentDevice] identifierForVendor];
        idfvStr = [uuid UUIDString];
    });
    return idfvStr;
}

+ (NSString *)idfa{
    static NSString *idfaStr;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        idfaStr = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    });
    return idfaStr;
}

+ (NSString *)macAddress{
    NSArray *ifs = CFBridgingRelease(CNCopySupportedInterfaces());
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((CFStringRef)ifnam);
        if (info && [info count]) {
            break;
        }
    }
    //    NSString *name = [[info objectForKey:@"SSID"] lowercaseString];
    NSString *bssid = [info objectForKey:@"BSSID"];
    return bssid;
}

+ (NSString *)deviceModel{
    static NSString *platform = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        int mib[2];
        size_t len;
        char *machine;
        
        mib[0] = CTL_HW;
        mib[1] = HW_MACHINE;
        sysctl(mib, 2, NULL, &len, NULL, 0);
        machine = malloc(len);
        sysctl(mib, 2, machine, &len, NULL, 0);
        platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
        free(machine);
    });
    return platform;
}

+ (NSString *)deviceModelName{
    static dispatch_once_t one;
    static NSString *name;
    dispatch_once(&one, ^{
        NSString *model = [self deviceModel];
        if (!model) return;
        NSDictionary *dic = @{
                              @"Watch1,1" : @"Apple Watch 38mm",
                              @"Watch1,2" : @"Apple Watch 42mm",
                              @"Watch2,3" : @"Apple Watch Series 2 38mm",
                              @"Watch2,4" : @"Apple Watch Series 2 42mm",
                              @"Watch2,6" : @"Apple Watch Series 1 38mm",
                              @"Watch2,7" : @"Apple Watch Series 1 42mm",
                              @"Watch3,1" : @"Apple Watch Series 3 38mm",
                              @"Watch3,2" : @"Apple Watch Series 3 42mm",
                              @"Watch3,3" : @"Apple Watch Series 3 38mm",
                              @"Watch3,4" : @"Apple Watch Series 3 42mm",
                              @"Watch4,1" : @"Apple Watch Series 4 40mm",
                              @"Watch4,2" : @"Apple Watch Series 4 44mm",
                              @"Watch4,3" : @"Apple Watch Series 4 40mm",
                              @"Watch4,4" : @"Apple Watch Series 4 44mm",
                              
                              @"iPod1,1" : @"iPod touch 1",
                              @"iPod2,1" : @"iPod touch 2",
                              @"iPod3,1" : @"iPod touch 3",
                              @"iPod4,1" : @"iPod touch 4",
                              @"iPod5,1" : @"iPod touch 5",
                              @"iPod7,1" : @"iPod touch 6",
                              
                              @"iPhone1,1" : @"iPhone 1G",
                              @"iPhone1,2" : @"iPhone 3G",
                              @"iPhone2,1" : @"iPhone 3GS",
                              @"iPhone3,1" : @"iPhone 4 (GSM)",
                              @"iPhone3,2" : @"iPhone 4",
                              @"iPhone3,3" : @"iPhone 4 (CDMA)",
                              @"iPhone4,1" : @"iPhone 4S",
                              @"iPhone5,1" : @"iPhone 5",
                              @"iPhone5,2" : @"iPhone 5",
                              @"iPhone5,3" : @"iPhone 5c",
                              @"iPhone5,4" : @"iPhone 5c",
                              @"iPhone6,1" : @"iPhone 5s",
                              @"iPhone6,2" : @"iPhone 5s",
                              @"iPhone7,1" : @"iPhone 6 Plus",
                              @"iPhone7,2" : @"iPhone 6",
                              @"iPhone8,1" : @"iPhone 6s",
                              @"iPhone8,2" : @"iPhone 6s Plus",
                              @"iPhone8,4" : @"iPhone SE",
                              @"iPhone9,1" : @"iPhone 7",
                              @"iPhone9,2" : @"iPhone 7 Plus",
                              @"iPhone9,3" : @"iPhone 7",
                              @"iPhone9,4" : @"iPhone 7 Plus",
                              @"iPhone10,1": @"iPhone 8",
                              @"iPhone10,4": @"iPhone 8",
                              @"iPhone10,2": @"iPhone 8 Plus",
                              @"iPhone10,5": @"iPhone 8 Plus",
                              @"iPhone10,3": @"iPhone X",
                              @"iPhone10,6": @"iPhone X",
                              @"iPhone11,8" : @"iPhone XR",
                              @"iPhone11,2" : @"iPhone XS",
                              @"iPhone11,6" : @"iPhone XS Max",

                              @"iPad1,1" : @"iPad 1",
                              @"iPad2,1" : @"iPad 2 (WiFi)",
                              @"iPad2,2" : @"iPad 2 (GSM)",
                              @"iPad2,3" : @"iPad 2 (CDMA)",
                              @"iPad2,4" : @"iPad 2",
                              @"iPad2,5" : @"iPad mini 1",
                              @"iPad2,6" : @"iPad mini 1",
                              @"iPad2,7" : @"iPad mini 1",
                              @"iPad3,1" : @"iPad 3 (WiFi)",
                              @"iPad3,2" : @"iPad 3 (4G)",
                              @"iPad3,3" : @"iPad 3 (4G)",
                              @"iPad3,4" : @"iPad 4",
                              @"iPad3,5" : @"iPad 4",
                              @"iPad3,6" : @"iPad 4",
                              @"iPad4,1" : @"iPad Air",
                              @"iPad4,2" : @"iPad Air",
                              @"iPad4,3" : @"iPad Air",
                              @"iPad4,4" : @"iPad mini 2",
                              @"iPad4,5" : @"iPad mini 2",
                              @"iPad4,6" : @"iPad mini 2",
                              @"iPad4,7" : @"iPad mini 3",
                              @"iPad4,8" : @"iPad mini 3",
                              @"iPad4,9" : @"iPad mini 3",
                              @"iPad5,1" : @"iPad mini 4",
                              @"iPad5,2" : @"iPad mini 4",
                              @"iPad5,3" : @"iPad Air 2",
                              @"iPad5,4" : @"iPad Air 2",
                              @"iPad6,3" : @"iPad Pro (9.7 inch)",
                              @"iPad6,4" : @"iPad Pro (9.7 inch)",
                              @"iPad6,7" : @"iPad Pro (12.9 inch)",
                              @"iPad6,8" : @"iPad Pro (12.9 inch)",
                              @"iPad6,11" : @"iPad 5",
                              @"iPad6,12" : @"iPad 5",
                              @"iPad7,1" : @"iPad PRO 2 (12.9 inch)",
                              @"iPad7,2" : @"iPad PRO 2 (12.9 inch)",
                              @"iPad7,3" : @"iPad PRO (10.5 inch)",
                              @"iPad7,4" : @"iPad PRO (10.5 inch)",
                              @"iPad7,5" : @"iPad 6",
                              @"iPad7,6" : @"iPad 6",
                              @"iPad8,1" : @"iPad PRO (11.0 inch)",
                              @"iPad8,2" : @"iPad PRO (11.0 inch)",
                              @"iPad8,3" : @"iPad PRO (11.0 inch)",
                              @"iPad8,4" : @"iPad PRO (11.0 inch)",
                              @"iPad8,5" : @"iPad PRO 3 (12.9 inch)",
                              @"iPad8,6" : @"iPad PRO 3 (12.9 inch)",
                              @"iPad8,7" : @"iPad PRO 3 (12.9 inch)",
                              @"iPad8,8" : @"iPad PRO 3 (12.9 inch)",
                              
                              @"AppleTV2,1" : @"Apple TV 2",
                              @"AppleTV3,1" : @"Apple TV 3",
                              @"AppleTV3,2" : @"Apple TV 3",
                              @"AppleTV5,3" : @"Apple TV 4",
                              
                              @"i386" : @"Simulator x86",
                              @"x86_64" : @"Simulator x64",
                              };
        name = dic[model];
        if (!name) name = model;
    });
    return name;
}


#pragma mark -
#pragma mark -- 钥匙串操作 --
// Keychain
+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge_transfer id)kSecClassGenericPassword,
            (__bridge_transfer id)kSecClass,service,
            (__bridge_transfer id)kSecAttrService,service,
            (__bridge_transfer id)kSecAttrAccount,
            (__bridge_transfer id)kSecAttrAccessibleAfterFirstUnlock,
            (__bridge_transfer id)kSecAttrAccessible,
            nil];
}

+ (void)saveKeychainValue:(NSString *)sValue key:(NSString *)sKey{
    if ([NSString isNilOrEmptyString:sKey]) {
        return;
    }
    NSMutableDictionary * keychainQuery = [self getKeychainQuery:sKey];
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
    
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:sValue] forKey:(__bridge_transfer id)kSecValueData];
    
    SecItemAdd((__bridge_retained CFDictionaryRef)keychainQuery, NULL);
    
}

+ (NSString *)readKeychainValue:(NSString *)sKey{
    if ([NSString isNilOrEmptyString:sKey]) {
        return nil;
    }
    NSString *ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:sKey];
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge_transfer id)kSecReturnData];
    [keychainQuery setObject:(__bridge_transfer id)kSecMatchLimitOne forKey:(__bridge_transfer id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = (NSString *)[NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", sKey, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

+ (void)deleteKeychainValue:(NSString *)sKey {
    if ([NSString isNilOrEmptyString:sKey]) {
        return;
    }
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:sKey];
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
}


#pragma mark - 保存图片到系统相册
+ (void)saveImageToAblum:(UIImage *)image completion:(void (^)(BOOL, id))completion{
    if (!image) {
        if (completion) completion(NO, nil);
        return;
    }
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusDenied) {
        if (completion) completion(NO, nil);
    } else if (status == PHAuthorizationStatusRestricted) {
        if (completion) completion(NO, nil);
    } else {
        __block PHObjectPlaceholder *placeholderAsset=nil;
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            PHAssetChangeRequest *newAssetRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
            placeholderAsset = newAssetRequest.placeholderForCreatedAsset;
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (!success) {
                if (completion) completion(NO, nil);
                return;
            }
            PHAsset *asset = [self getAssetFromlocalIdentifier:placeholderAsset.localIdentifier];
            PHAssetCollection *desCollection = [self getDestinationCollection];
            if (!desCollection) completion(NO, nil);
            
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                [[PHAssetCollectionChangeRequest changeRequestForAssetCollection:desCollection] addAssets:@[asset]];
            } completionHandler:^(BOOL success, NSError * _Nullable error) {
                if (completion) completion(success, asset);
            }];
        }];
    }
}

+ (void)saveFileToAblumWithURL:(NSURL *)url completion:(void (^)(BOOL, id))completion{
    if (!url) {
        if (completion) completion(NO, nil);
        return;
    }
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusDenied) {
        if (completion) completion(NO, nil);
    } else if (status == PHAuthorizationStatusRestricted) {
        if (completion) completion(NO, nil);
    } else {
        __block PHObjectPlaceholder *placeholderAsset=nil;
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            PHAssetChangeRequest *newAssetRequest = [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:url];
            placeholderAsset = newAssetRequest.placeholderForCreatedAsset;
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (!success) {
                if (completion) completion(NO, nil);
                return;
            }
            PHAsset *asset = [self getAssetFromlocalIdentifier:placeholderAsset.localIdentifier];
            PHAssetCollection *desCollection = [self getDestinationCollection];
            if (!desCollection) completion(NO, nil);
            
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                if (asset) {
                    [[PHAssetCollectionChangeRequest changeRequestForAssetCollection:desCollection] addAssets:@[asset]];
                }
            } completionHandler:^(BOOL success, NSError * _Nullable error) {
                if (completion) completion(success, asset);
            }];
        }];
    }
}

+ (PHAsset *)getAssetFromlocalIdentifier:(NSString *)localIdentifier{
    if(localIdentifier == nil){
        NSLog(@"Cannot get asset from localID because it is nil");
        return nil;
    }
    PHFetchResult *result = [PHAsset fetchAssetsWithLocalIdentifiers:@[localIdentifier] options:nil];
    if(result.count){
        return result[0];
    }
    return nil;
}

// 获取自定义相册
+ (PHAssetCollection *)getDestinationCollection{
    // 找是否已经创建自定义相册
    PHFetchResult<PHAssetCollection *> *collectionResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in collectionResult) {
        if ([collection.localizedTitle isEqualToString:self.appName]) {
            return collection;
        }
    }
    // 新建自定义相册
    __block NSString *collectionId = nil;
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        collectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:[UIDevice appName]].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    if (error) {
        NSLog(@"Creat '%@' Ablum Error：%@", self.appName, error.localizedDescription);
        return nil;
    }
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[collectionId] options:nil].lastObject;
}

#pragma mark -
#pragma mark -- Orientation --
//调用私有方法实现
+ (void)setOrientation:(UIInterfaceOrientation)orientation {
    SEL selector = NSSelectorFromString(@"setOrientation:");
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self instanceMethodSignatureForSelector:selector]];
    [invocation setSelector:selector];
    [invocation setTarget:[self currentDevice]];
    int val = orientation;
    [invocation setArgument:&val atIndex:2];
    [invocation invoke];
}

+ (BOOL)isLandscape{
    //if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])) {
    if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        return YES;
    } else {
        return NO;
    }
}

@end
