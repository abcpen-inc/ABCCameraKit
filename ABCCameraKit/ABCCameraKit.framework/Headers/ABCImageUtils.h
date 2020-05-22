//
//  ABCImageUtils.h
//  ABCCameraKit
//
//  Created by bingo on 2019/5/14.
//  Copyright © 2019 杭州笔声智能科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABCImageUtils : NSObject

+ (UIImage *)generatePhotoOfSize:(CGSize)size;
+ (UIImage *)cropImage:(UIImage *)image toRect:(CGRect)rect;
+ (UIImage *)mirrorImage:(UIImage *)image;
+ (UIImage *)forceUpOrientation:(UIImage *)image;
+ (NSString *)writeImage:(NSData *)image toPath:(NSString *)path;
+ (UIImage *) scaleImage:(UIImage*)image toWidth:(NSInteger)width;
+ (void)updatePhotoMetadata:(CMSampleBufferRef)imageSampleBuffer withAdditionalData:(NSDictionary *)additionalData inResponse:(NSMutableDictionary *)response;
+ (NSData *) compressImage:(UIImage *)image toMaxLength:(NSInteger) maxLength;
+ (UIImage *) fixImageOrientation:(UIImage *) image;

/*
 * 矫正图片
 */
+ (UIImage *)adjustImageWithAngle:(UIImage *)input;

/*
 * 获取图片角度
 */
+ (double) getAngleFromImage:(UIImage *) image;

@end

NS_ASSUME_NONNULL_END
