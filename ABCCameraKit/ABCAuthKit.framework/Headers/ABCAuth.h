//
//  ABCAuth.h
//  ABCAuthKit
//
//  Created by bingo on 2020/5/22.
//  Copyright © 2020 杭州笔声智能科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ABCAuthState) {
    ABCAuthState_REQUEST_ERROR        = -10000, //请求失败
    ABCAuthState_SECRET_ISNULL         = -10001, //secret为空
    ABCAuthState_SECRET_EXPIRED        = 10006,  //secret过期
    ABCAuthState_SECRET_LLEGAL         = 10027,  //secret不合法
    ABCAuthState_PACKAGENAME_INVALID  = 10028,  //packageName无效
    ABCAuthState_SECRET_VALID          = 0, //secret有效
};

@interface ABCAuth : NSObject

@property(nonatomic, strong, readonly) NSString *secret;

@property(nonatomic, assign, readonly) ABCAuthState authState;

@property(nonatomic, assign, readonly) BOOL authed;


+ (ABCAuth *)sharedInstance;

-(void) initWithAuthSecret:(NSString *) secret;

@end

NS_ASSUME_NONNULL_END
