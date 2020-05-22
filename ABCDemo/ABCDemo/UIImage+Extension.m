//
//  UIImage+Extension.m
//  Zeus
//
//  Created by bingo on 2019/4/30.
//  Copyright © 2019 杭州笔声智能科技有限公司. All rights reserved.
//

#import "UIImage+Extension.h"
#import "BFKit.h"

@implementation UIImage (Extension)

+ (UIImage*)resizableImage:(NSString *)name
{
    UIImage *normal = [UIImage imageNamed:name];
    
    CGFloat imageW = normal.size.width * 0.5;
    CGFloat imageH = normal.size.height * 0.5;
    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(imageH, imageW, imageH, imageW)];
}

+ (NSData *) compressImage:(UIImage *)image toMaxLength:(NSInteger) maxLength newSize:(CGSize) newSize{
  
  UIImage *newImage = [image resizedImage:newSize];//[self resizeImage:image withNewSize:newSize];
  maxLength *= 1024;
  
  CGFloat compression = 0.7f;
  CGFloat max = 1;
  CGFloat min = 0;
  NSData *data = UIImageJPEGRepresentation(newImage, compression);
  if (data.length < maxLength) return data;
  for (int i = 0; i < 6; ++i) {
    @autoreleasepool {
      compression = (max + min) / 2;
      data = UIImageJPEGRepresentation(newImage, compression);
      if (data.length < maxLength * 0.9) {
        min = compression;
      } else if (data.length > maxLength) {
        max = compression;
      } else {
        break;
      }
    }
  }
  
  return data;
}

+ (NSData *) compressImage:(UIImage *)image toMaxLength:(NSInteger) maxLength{
  
  UIImage *newImage = image;

  if (image.size.width > 2048 || image.size.height > 2048) {
    CGSize newSize = [self scaleImage:image withLength:2048];
    newImage = [image resizedImage:newSize];
  }

    maxLength *= 1024;

    CGFloat compression = 0.7f;
    CGFloat max = 1;
    CGFloat min = 0;
    NSData *data = UIImageJPEGRepresentation(newImage, compression);
    if (data.length < maxLength) return data;
    for (int i = 0; i < 6; ++i) {
        @autoreleasepool {
            compression = (max + min) / 2;
            data = UIImageJPEGRepresentation(newImage, compression);
            if (data.length < maxLength * 0.9) {
                min = compression;
            } else if (data.length > maxLength) {
                max = compression;
            } else {
                break;
            }
        }
    }
    
    return data;
}

- (UIImage *)resizedImage:(CGSize)size {
  if (CGSizeEqualToSize(size, CGSizeZero)) {
    return self;
  }
  if (CGSizeEqualToSize(size, self.size)) {
    return self;
  }
  CGFloat maxPixelSize = MAX(size.width, size.height);
  CGImageSourceRef sourceRef = CGImageSourceCreateWithData((__bridge CFDataRef)UIImageJPEGRepresentation(self, 1.0), nil);
  NSDictionary *options = @{(__bridge id)kCGImageSourceCreateThumbnailFromImageAlways:(__bridge id)kCFBooleanTrue,
                            (__bridge id)kCGImageSourceThumbnailMaxPixelSize:[NSNumber numberWithFloat:maxPixelSize]
                            };
  CGImageRef imageRef = CGImageSourceCreateThumbnailAtIndex(sourceRef, 0, (__bridge CFDictionaryRef)options);
  UIImage *resultImage = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
  CGImageRelease(imageRef);
  CFRelease(sourceRef);
  return resultImage;
}

+ (CGSize) scaleImage:(UIImage *) image withLength:(CGFloat) imageLength{
    
    CGFloat newWidth = 0.0f;
    CGFloat newHeight = 0.0f;
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    
    if (width >= imageLength || height >= imageLength){
        
        if (width > height) {
            
            newWidth = imageLength;
            newHeight = newWidth * height / width;
            
        }else if(height > width){
            
            newHeight = imageLength;
            newWidth = newHeight * width / height;
            
        }else{
            
            newWidth = imageLength;
            newHeight = imageLength;
        }
        
    }else{
      newWidth = image.size.width;
      newHeight = image.size.height;
    }
    
    return CGSizeMake(newWidth, newHeight);
}

-(UIImage *) scaledImage:(CGPoint) point scaleFactor:(CGFloat) scaleFactor targetSize:(CGSize) size
{
  CGSize scaledSize = CGSizeMake(size.width/scaleFactor, size.height/scaleFactor);
  CGRect rect = CGRectMake(point.x - scaledSize.width / 2.0, point.y - scaledSize.height / 2.0, scaledSize.width, scaledSize.height);
  CGImageRef croppedImage = CGImageCreateWithImageInRect(self.CGImage, rect);
  UIImage *image = [UIImage imageWithCGImage:croppedImage];
  CGImageRelease(croppedImage);
  return image;
}

- (UIImage * _Nonnull)imageRotateByDegrees:(CGFloat)degrees {
  UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.size.width, self.size.height)];
  CGAffineTransform t = CGAffineTransformMakeRotation(BFDegreesToRadians(degrees));
  rotatedViewBox.transform = t;
  CGSize rotatedSize = rotatedViewBox.frame.size;
  
  UIGraphicsBeginImageContext(rotatedSize);
  //    UIGraphicsBeginImageContextWithOptions(rotatedSize, NO, [[UIScreen mainScreen] scale]);
  CGContextRef bitmap = UIGraphicsGetCurrentContext();
  
  CGContextTranslateCTM(bitmap, rotatedSize.width / 2, rotatedSize.height / 2);
  
  CGContextRotateCTM(bitmap, BFDegreesToRadians(degrees));
  
  CGContextScaleCTM(bitmap, 1.0, -1.0);
  CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
  
  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return newImage;
}


// 根据坐标剪切图片
- (UIImage *)cutImageWithRect:(CGRect)newRect {
  CGSize originImageSize = self.size;
  if (originImageSize.width <= newRect.size.width && originImageSize.height <= newRect.size.height) {
    return self;
  }
  
  float scale = [UIScreen mainScreen].scale;
  CGRect cropRect = CGRectMake(newRect.origin.x*scale, newRect.origin.y*scale, newRect.size.width*scale, newRect.size.height*scale);
  CGImageRef croppedImage = CGImageCreateWithImageInRect(self.CGImage, cropRect);
  UIImage *newImg = [UIImage imageWithCGImage:croppedImage scale:scale orientation:self.imageOrientation];
  return newImg;
}

-(UIImage*)imageWithCornerRadius:(CGFloat)radius {
  if (radius<=0) return self;
  
  CGFloat w = self.size.width;
  CGFloat h = self.size.height;
  
  UIImage *image = nil;
  CGRect imageFrame = CGRectMake(0., 0., w, h);
  UIGraphicsBeginImageContextWithOptions(self.size, NO, 1.0);
  [[UIBezierPath bezierPathWithRoundedRect:imageFrame cornerRadius:radius] addClip];
  [self drawInRect:imageFrame];
  image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return image;
}

- (UIImage *) rotatedImage:(int)rotation
{
  CGSize size = self.size;
  CGSize rotatedSize = (rotation % 2 == 1) ? CGSizeMake(size.height, size.width) : size;
  
  UIGraphicsBeginImageContext(rotatedSize);
  CGContextRef ctx = UIGraphicsGetCurrentContext();
  
  if (rotation == 1) {
    CGContextTranslateCTM(ctx, size.height, 0.0f);
  } else if (rotation == 2) {
    CGContextTranslateCTM(ctx, size.width, size.height);
  } else if (rotation == 3) {
    CGContextTranslateCTM(ctx, 0.0f, size.width);
  }
  
  CGContextRotateCTM(ctx, (M_PI / 2.0f) * rotation);
  
  [self drawAtPoint:CGPointZero];
  
  UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return result;
}


- (UIImage * _Nonnull)imageRotatedByImageDegrees:(CGFloat)degrees {
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(BFDegreesToRadians(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    UIGraphicsBeginImageContextWithOptions(rotatedSize, NO, 1);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(bitmap, rotatedSize.width / 2, rotatedSize.height / 2);
    
    CGContextRotateCTM(bitmap, BFDegreesToRadians(degrees));
    
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


+ (UIImage *)fixOrientation:(UIImage *)srcImg {
    if (srcImg.imageOrientation == UIImageOrientationUp) {
        return srcImg;
    }

    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (srcImg.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, srcImg.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;

        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;

        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, srcImg.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }

    switch (srcImg.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;

        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }

    CGContextRef ctx = CGBitmapContextCreate(NULL, srcImg.size.width, srcImg.size.height, CGImageGetBitsPerComponent(srcImg.CGImage), 0, CGImageGetColorSpace(srcImg.CGImage), CGImageGetBitmapInfo(srcImg.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (srcImg.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,srcImg.size.height,srcImg.size.width), srcImg.CGImage);
            break;

        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,srcImg.size.width,srcImg.size.height), srcImg.CGImage);
            break;
    }

    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end
