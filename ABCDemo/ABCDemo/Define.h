//
//  Define.h
//  ABCDemo
//
//  Created by 葛聪颖 on 2020/5/22.
//  Copyright © 2020 杭州笔声智能科技有限公司. All rights reserved.
//

#ifndef Define_h
#define Define_h

#define kResourceISIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kResourceISIPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size)) : NO)
#define kResourceISIPhonePlus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define kResourceISIPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define kResourceISIPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
#define kResourceISIPhoneXS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define kResourceISIPhoneXSMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)
#define kResourceISIPhoneXAbove (kResourceISIPhoneX || kResourceISIPhoneXR || kResourceISIPhoneXS || kResourceISIPhoneXSMax)
#define kResourceSafeAreaBottomHeight (kResourceISIPhoneXAbove ? 34 : 0)
#define kResourceSafeAreaTopHeight (kResourceISIPhoneXAbove ? 44 : 0)
#define kResourceStatusBarHeight (kResourceISIPhoneXAbove ? 44 : 20)
#define kResourceNaviBarHeight (kResourceISIPhoneXAbove ? 88 : 64)
#define BOTTOM_MENU_HEIGHT (56 + kResourceSafeAreaBottomHeight)

#endif /* Define_h */
