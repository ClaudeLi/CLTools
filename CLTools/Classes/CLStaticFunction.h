//
//  CLStaticFunction.h
//  CLTools
//
//  Created by ClaudeLi on 2019/3/6.
//

#ifndef CLStaticFunction_h
#define CLStaticFunction_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 Synthsize a weak or strong reference.
 
 Example:
 @cl_weakify(self.view, weakView)
 [weakView doSomething^{
 @cl_strongify(self.view, strongView)
 if (!strongView) return;
 ...
 }];
 
 */
#ifndef cl_weakify
#if DEBUG
#if __has_feature(objc_arc)
#define cl_weakify(objc, weakObjc) autoreleasepool{} __weak __typeof__(objc) weakObjc = objc;
#else
#define cl_weakify(objc, weakObjc) autoreleasepool{} __block __typeof__(objc) weakObjc = objc;
#endif
#else
#if __has_feature(objc_arc)
#define cl_weakify(objc, weakObjc) try{} @finally{} {} __weak __typeof__(objc) weakObjc = objc;
#else
#define cl_weakify(objc, weakObjc) try{} @finally{} {} __block __typeof__(objc) weakObjc = objc;
#endif
#endif
#endif

#ifndef cl_strongify
#if DEBUG
#define cl_strongify(objc, strongObjc) autoreleasepool{} __strong __typeof__(objc) strongObjc = objc;
#else
#define cl_strongify(objc, strongObjc) try{} @finally{} __strong __typeof__(objc) strongObjc = objc;
#endif
#endif


#define cl_kBounds         [UIScreen mainScreen].bounds
#define cl_kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define cl_kScreenHeight   [UIScreen mainScreen].bounds.size.height

#define cl_isPad           (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define cl_isPhone         (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define cl_isIPhoneX       ((cl_is_iPhone && (MAX(cl_kScreenWidth, cl_kScreenHeight)/MIN(cl_kScreenWidth, cl_kScreenHeight) > 2.0))?YES:NO)
// 状态栏
#define cl_kStateHeight        (cl_isIPhoneX?44:20)
// 导航栏
#define cl_kNavigationHeight   (cl_isIPhoneX?88:64)
// 标题高度
#define cl_kTitleHeight        (cl_kNavigationHeight-cl_kStateHeight)

#define cl_kSafeAreaTop        (cl_isIPhoneX?44.0f:0)
#define cl_kSafeAreaBottom     (cl_isIPhoneX?34.0f:0)

// tabBar高度
#define cl_kTabBarItemHeight    49
#define cl_kTabBarHeight        (cl_kSafePortraitBottom+cl_kTabBarItemHeight)

/**
 视图安全区
 
 @param view 指定视图
 @return UIEdgeInsets
 */
static inline UIEdgeInsets cl_safeAreaInset(UIView * _Nullable view) {
    if (view) {
        if (@available(iOS 11.0, *)) {
            return view.safeAreaInsets;
        }
    }
    return UIEdgeInsetsZero;
}

/**
 屏幕安全区
 
 @return UIEdgeInsets
 */
static inline UIEdgeInsets cl_kSafeAreaInset(void) {
    return cl_safeAreaInset(UIApplication.sharedApplication.keyWindow);
}

#pragma mark -
#pragma mark -- NSPath --

/**
 目录路径
 
 @param dir 目录
 @return path string
 */
static inline NSString * _Nonnull NSPathAtDir(NSSearchPathDirectory dir) {
    return [NSSearchPathForDirectoriesInDomains(dir, NSUserDomainMask, YES) firstObject];
}

/**
 Document目录路径
 
 @return path string
 */
static inline NSString * _Nonnull NSDocumentDirPath(void) {
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
static inline NSString * _Nonnull NSLibraryDirPath(void) {
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
static inline NSString * _Nonnull NSCachesDirPath(void) {
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
static inline BOOL NSRemoveFileAtPath(NSString * _Nullable path) {
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
static inline BOOL NSRemoveFileAtURL(NSURL * _Nullable URL) {
    if (URL && [URL isKindOfClass:[NSURL class]]) {
        return NSRemoveFileAtPath(URL.path);
    }
    return NO;
}


/**
 删除指定类型文件
 
 @param directory 目录
 @param suffixName 后缀
 */
static inline void NSRemoveFilesAtDirectory(NSString * _Nullable directory, NSString * _Nullable suffixName)
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
static inline long long GetFileSizeAtPath(NSString * _Nullable filePath)
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
static inline long long GetFolderSizeAtPath(NSString * _Nullable folderPath)
{
    NSFileManager* fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[fm subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil) {
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += GetFileSizeAtPath(fileAbsolutePath);
    }
    return folderSize;
}

/**
 OpenURL
 
 @param URL URL
 @param completionHandler completionHandler
 */
static inline void OpenURL(NSURL *__nullable URL, void(^__nullable completionHandler)(BOOL success))
{
    if (!URL) {
        if (completionHandler) {
            completionHandler(NO);
        }
        return;
    }
    UIApplication *application = [UIApplication sharedApplication];
    if (@available(iOS 10.0, *)) {
        [application openURL:URL options:@{}
           completionHandler:completionHandler];
    } else {
        if ([application canOpenURL:URL]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            [application openURL:URL];
#pragma clang diagnostic pop
            if (completionHandler) {
                completionHandler(YES);
            }
        } else {
            if (completionHandler) {
                completionHandler(NO);
            }
        }
    }
}

/**
 OpenURLStr
 
 @param URLStr URLStr
 @param completionHandler completionHandler description
 */
static inline void OpenURLStr(NSString *__nullable URLStr, void(^__nullable completionHandler)(BOOL success))
{
    if (!URLStr) {
        if (completionHandler) {
            completionHandler(NO);
        }
        return;
    }
    OpenURL([NSURL URLWithString:URLStr], completionHandler);
}

#endif /* CLStaticFunction_h */
