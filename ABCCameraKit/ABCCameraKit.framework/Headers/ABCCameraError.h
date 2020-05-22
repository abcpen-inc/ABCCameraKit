//
//  ScanError.h
//  Shibie_RN
//
//  Created by bingo on 2018/11/1.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef enum : NSUInteger {
    ABCCameraErrorCode_Authorization,
    ABCCameraErrorCode_InputDevice,
    ABCCameraErrorCode_Capture,
    ABCCameraErrorCode_CiImageCreation
} ABCCameraErrorCode;

@interface ABCCameraError : NSError

+(ABCCameraError *_Nonnull) errorWithCode:(ABCCameraErrorCode) errorCode;

+(NSString *) errorDescription:(ABCCameraErrorCode) errorCode;

@end

NS_ASSUME_NONNULL_END

