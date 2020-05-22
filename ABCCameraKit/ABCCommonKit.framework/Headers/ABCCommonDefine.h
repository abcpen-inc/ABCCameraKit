//
//  ABCCommonDefine.h
//  ABCCommonKit
//
//  Created by bingo on 2019/7/16.
//  Copyright © 2019 杭州笔声智能科技有限公司. All rights reserved.
//

#ifndef ABCCommonDefine_h
#define ABCCommonDefine_h

#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define APP_VERSION_CODE [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define APP_BUNDLE_IDENTIFIER [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]

#pragma mark - System
#define kResource_IOS11_OR_LATER        ( [[[UIDevice currentDevice] systemVersion] compare:@"11.0" options:NSNumericSearch] != NSOrderedAscending)
#define kResource_IOS12_OR_LATER        ( [[[UIDevice currentDevice] systemVersion] compare:@"12.0" options:NSNumericSearch] != NSOrderedAscending)

#pragma mark - Device
#define kResourceISIPhone5    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kResourceISIPhone6    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334),[[UIScreen mainScreen] currentMode].size)): NO)
#define kResourceISIPhonePlus    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define kResourceISIPhoneX    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define kResourceISIPhoneXR    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
#define kResourceISIPhoneXS    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define kResourceISIPhoneXSMax    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)
#define kResourceISIPhoneXAbove    (kResourceISIPhoneX || kResourceISIPhoneXR ||  kResourceISIPhoneXS || kResourceISIPhoneXSMax)

#define kResourceSafeAreaBottomHeight          (kResourceISIPhoneXAbove ? 34 : 0)
#define kResourceSafeAreaTopHeight             (kResourceISIPhoneXAbove ? 44 : 0)
#define kResourceStatusBarHeight               (kResourceISIPhoneXAbove ? 44 : 20)
#define kResourceNaviBarHeight                 (kResourceISIPhoneXAbove ? 88 : 64)

#define SCREEN_RATE_W (SCREEN_WIDTH/375.0)

//warn define
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


#define ABC_SINGLETON_DEF(_type_) + (_type_ *)sharedInstance;\
+(instancetype) alloc __attribute__((unavailable("call sharedInstance instead")));\
+(instancetype) new __attribute__((unavailable("call sharedInstance instead")));\
-(instancetype) copy __attribute__((unavailable("call sharedInstance instead")));\
-(instancetype) mutableCopy __attribute__((unavailable("call sharedInstance instead")));\

#define ABC_SINGLETON_IMP(_type_) + (_type_ *)sharedInstance{\
static _type_ *theSharedInstance = nil;\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
theSharedInstance = [[super alloc] init];\
});\
return theSharedInstance;\
}

#endif /* ABCCommonDefine_h */
