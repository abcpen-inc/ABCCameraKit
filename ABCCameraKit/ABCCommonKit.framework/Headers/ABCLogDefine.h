//
//  ABCLogDefine.h
//  ABCCommonKit
//
//  Created by bingo on 2019/7/16.
//  Copyright © 2019 杭州笔声智能科技有限公司. All rights reserved.
//

#ifndef ABCLogDefine_h
#define ABCLogDefine_h

//log
#if __has_include("CocoaLumberjack.h")
#define LogDebug(fmt, ...) DDLogDebug((@"Debug : \n%s [Line %d] \n" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define LogError(fmt, ...) DDLogError((@"Error : \n%s [Line %d] \n" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define LogWarn(fmt, ...) DDLogWarn((@"Warn : \n%s [Line %d] \n" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define LogInfo(fmt, ...) DDLogInfo((@"Info : \n%s [Line %d] \n" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define LogVerbose(fmt, ...) DDLogVerbose((@"Verbose : \n%s [Line %d]\n" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define LogTodo(fmt, ...) DDLogWarn((@"TODO : \n%s [Line %d] \n" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#else

#define LogDebug(fmt, ...) NSLog((@"Debug : \n%s [Line %d] \n" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define LogError(fmt, ...) NSLog((@"Error : \n%s [Line %d] \n" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define LogWarn(fmt, ...) NSLog((@"Warn : \n%s [Line %d] \n" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define LogInfo(fmt, ...) NSLog((fmt), ##__VA_ARGS__)
#define LogVerbose(fmt, ...) NSLog((@"Verbose : \n%s [Line %d]\n" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define LogTodo(fmt, ...) NSLog((@"TODO : \n%s [Line %d] \n" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#endif

#endif /* ABCLogDefine_h */
