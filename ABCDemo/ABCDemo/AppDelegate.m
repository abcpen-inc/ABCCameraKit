//
//  AppDelegate.m
//  ABCDemo
//
//  Created by bingo on 2019/5/14.
//  Copyright © 2019 杭州笔声智能科技有限公司. All rights reserved.
//

#import "AppDelegate.h"
#import <CommonCrypto/CommonCrypto.h>
#import <ABCAuthKit/ABCAuth.h>

static NSString *appId = @"";

static NSString *appSecret = @"";

@interface AppDelegate () <UISplitViewControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[ABCAuth sharedInstance] initWithAuthSecret:[self genneraSecret]];
    return YES;
}

/**
 secret建议放在服务端生成
 */
-(NSString *) genneraSecret
{
    NSString *packageName = [[NSBundle mainBundle] bundleIdentifier];
    NSString *expireTime = [self getExpireTime];//生成过期时间
    NSString *secret = [NSString stringWithFormat:@"appId=%@&expireTime=%@&packageName=%@",appId,expireTime,packageName];//生产密钥
    secret = [self stringToMD5:secret]; //md5转换
    secret = [NSString stringWithFormat:@"%@&appSecret=%@",secret,appSecret];//生成带有secret的密钥
    secret = [[self stringToMD5:secret] uppercaseString];
    secret = [NSString stringWithFormat:@"%@.%@",expireTime,secret];//拼接expireTime 和secert 逗号隔开
    return secret;
}

- (NSString *)stringToMD5:(NSString *)str {
    const char *fooData = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(fooData, (CC_LONG)strlen(fooData), result);
    NSMutableString *saveResult = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [saveResult appendFormat:@"%02x", result[i]];
    }
    return saveResult;
}

- (NSString *)getExpireTime {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time = [date timeIntervalSince1970]*1000 + 5*60*1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
@end
