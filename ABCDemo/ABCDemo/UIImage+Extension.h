//
//  UIImage+Extension.h
//  Zeus
//
//  Created by bingo on 2019/4/30.
//  Copyright © 2019 杭州笔声智能科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface  UIImage (Extension)

- (UIImage *) resizedImage:(CGSize)size;

+ (CGSize) scaleImage:(UIImage *) image withLength:(CGFloat) imageLength;

+ (NSData *) compressImage:(UIImage *)image toMaxLength:(NSInteger) maxLength;

+ (NSData *) compressImage:(UIImage *)image toMaxLength:(NSInteger) maxLength newSize:(CGSize) newSize;

- (UIImage *) scaledImage:(CGPoint) point scaleFactor:(CGFloat) scaleFactor targetSize:(CGSize) size;

- (UIImage * _Nonnull)imageRotateByDegrees:(CGFloat)degrees;

- (UIImage *)cutImageWithRect:(CGRect)newRect;

- (UIImage *)imageWithCornerRadius:(CGFloat)radius;

- (UIImage *)rotatedImage:(int)rotation;

- (UIImage * _Nonnull)imageRotatedByImageDegrees:(CGFloat)degrees;

+ (UIImage *)fixOrientation:(UIImage *)srcImg;

@end

NS_ASSUME_NONNULL_END
