//
//  NSObject+CLFunc.h
//  CLTools
//
//  Created by ClaudeLi on 2018/8/23.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 Synthsize a weak or strong reference.
 
 Example:
 @weakly(self, weakSelf)
 [self doSomething^{
 @strongly(self, strongSelf)
 if (!self) return;
 ...
 }];
 
 */
#ifndef weakly
#if DEBUG
#if __has_feature(objc_arc)
#define weakly(objc, weakObjc) autoreleasepool{} __weak __typeof__(objc) weakObjc = objc;
#else
#define weakly(objc, weakObjc) autoreleasepool{} __block __typeof__(objc) weakObjc = objc;
#endif
#else
#if __has_feature(objc_arc)
#define weakly(objc, weakObjc) try{} @finally{} {} __weak __typeof__(objc) weakObjc = objc;
#else
#define weakly(objc, weakObjc) try{} @finally{} {} __block __typeof__(objc) weakObjc = objc;
#endif
#endif
#endif

#ifndef strongly
#if DEBUG
#define strongly(objc, strongObjc) autoreleasepool{} __strong __typeof__(objc) strongObjc = objc;
#else
#define strongly(objc, strongObjc) try{} @finally{} __strong __typeof__(objc) strongObjc = objc;
#endif
#endif

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


/**
 删除文件
 
 @param path 文件路径
 @return BOOL 是否删除成功
 */
static inline BOOL NSRemoveFileAtPath(NSString *path){
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:path]) {
        NSError *err;
        BOOL suc = [fm removeItemAtPath:path error:&err];
        if (err) {
            NSLog(@"file remove error, %@", err);
        }
        return suc;
    }
    return NO;
}

/**
 删除文件
 
 @param URL 文件地址
 @return BOOL 是否删除成功
 */
static inline BOOL NSRemoveFileAtURL(NSURL *URL){
    if ([URL isKindOfClass:[NSURL class]]) {
        return NSRemoveFileAtPath(URL.path);
    }
    return NO;
}


/**
 删除指定类型文件
 
 @param directory 目录
 @param suffixName 后缀
 */
static inline void NSRemoveFilesAtDirectory(NSString *directory, NSString *suffixName)
{
    NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:directory];
    NSString *toDelFile;
    while (toDelFile = [dirEnum nextObject])
    {
        NSComparisonResult result = [[toDelFile pathExtension] compare:suffixName options:NSCaseInsensitiveSearch|NSNumericSearch];
        if (result == NSOrderedSame)
        {
            NSRemoveFileAtPath([directory stringByAppendingPathComponent:toDelFile]);
        }
    }
}

/**
 获取文件大小
 
 @param filePath 文件路径
 @return long long
 */
static inline long long GetFileSizeAtPath(NSString *filePath)
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        return [[[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}


/**
 获取文件夹大小
 
 @param folderPath 路径
 @return long long
 */
static inline long long GetFolderSizeAtPath(NSString *folderPath)
{
    NSFileManager* fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[fm subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += GetFileSizeAtPath(fileAbsolutePath);
    }
    return folderSize;
}


/**
 OpenURL
 
 @param URLString URLString
 @param completionHandler completionHandler
 */
static inline void OpenURL(NSString *URLString, void(^__nullable completionHandler)(BOOL success))
{
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:URLString];
    if (@available(iOS 10.0, *)) {
        [application openURL:URL options:@{}
           completionHandler:completionHandler];
    }else{
        if ([application canOpenURL:URL]) {
            [application openURL:URL];
            if (completionHandler) {
                completionHandler(YES);
            }
        }else{
            if (completionHandler) {
                completionHandler(NO);
            }
        }
    }
}

@interface NSObject (CLFunc)

@end
