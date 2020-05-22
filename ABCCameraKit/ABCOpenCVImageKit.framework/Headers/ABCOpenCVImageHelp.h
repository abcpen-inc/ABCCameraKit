//
//  ABCOpenCVImageHelp.h
//  ABCOpenCVImageKit
//
//  Created by 葛聪颖 on 2019/9/10.
//  Copyright © 2019 葛聪颖. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, OpenCVPhotoProcessMode) {
    PhotoProcessMode_Original = 1,               // 原图
    PhotoProcessMode_BlackWhite = 2,             // 黑白文档
    PhotoProcessMode_ColorEnhance = 3,           // 色彩增强
    PhotoProcessMode_BrightnessImprovement = 4,  // 亮度提升
    PhotoProcessMode_PictureBook = 5,            // 绘本
    PhotoProcessMode_Grayscale = 6,              // 灰度
    PhotoProcessMode_SharpenEnhance = 7,         // 增强并锐化

    PhotoProcessMode_Common = 8,                 // 通用
    PhotoProcessMode_Document = 9,               // 文档
    PhotoProcessMode_Bill = 10,                  // 票据
    PhotoProcessMode_Credentials = 11,           // 证件
    PhotoProcessMode_Books = 12,                 // 书籍
    PhotoProcessMode_Businesscard = 13,          // 名片
  
    PhotoProcessMode_A9 = 14,         // A9
    PhotoProcessMode_AL1 = 15,        // AL1
    PhotoProcessMode_C4 = 16,         // C4
    PhotoProcessMode_C8 = 17,         // C8
    PhotoProcessMode_G6 = 18,         // G6
    PhotoProcessMode_G7 = 19,         // G7
    PhotoProcessMode_J2 = 20,         // J2
    PhotoProcessMode_L4 = 21,         // L4
    PhotoProcessMode_M6 = 22,         // M6
    PhotoProcessMode_S3 = 23,         // S3
    PhotoProcessMode_V5 = 24,         // V5
    PhotoProcessMode_V6 = 25,         // V6
};

@interface ABCOpenCVImageHelp : NSObject

- (instancetype)initWithDefaultValue;

// 增强并锐化滤镜
- (UIImage *)opencvSharpenEnhanceWithImage:(UIImage *)image contrastValue:(double)contrastValue brightValue:(double)brightValue  colorValue:(double)colorValue sharpenValue:(double)sharpenValue;
// 亮度提升滤镜
- (UIImage *)opencvBrightnessImprovementFilterWithImage:(UIImage *)image floatValue:(float)floatValue;
// 黑白滤镜
- (UIImage *)opencvBlackWhiteFilterWithImage:(UIImage *)image floatValue:(float)floatValue;
// 绘本滤镜
- (UIImage *)opencvPictureBookFilterWithImage:(UIImage *)image;
// 灰度滤镜
- (UIImage *)opencvGrayscaleFilterWithImage:(UIImage *)image;
// 通用滤镜
- (UIImage *)opencvCommonFilterWithImage:(UIImage *)image;
// 文档滤镜
- (UIImage *)opencvDocumentFilterWithImage:(UIImage *)image;
// 票据滤镜
- (UIImage *)opencvBillFilterWithImage:(UIImage *)image;
// 证件滤镜
- (UIImage *)opencvCredentialFilterWithImage:(UIImage *)image;
// 书籍滤镜
- (UIImage *)opencvBookFilterWithImage:(UIImage *)image;
// 名片滤镜
- (UIImage *)opencvBusinesscardFilterWithImage:(UIImage *)image;

//获取预设十二种滤镜缩略图
- (NSMutableArray *)getBasicFilterImageIcons:(UIImage *)image iconSize:(CGSize)iconSize;
//获取更多十二种滤镜缩略图
- (NSMutableArray *)getLutsFilterImageIcons:(UIImage *)image iconSize:(CGSize)iconSize;

//更多滤镜中的12种类滤镜
- (UIImage *)opencvLutsFilterWithImage:(UIImage *)image openCVPhotoProcessMode:(OpenCVPhotoProcessMode)openCVPhotoProcessMode ;

//滤镜微调函数
- (UIImage *)opencvAdjustFilterWithImage:(UIImage *)image brightValue:(float)brightValue contrastValue:(float)contrastValue sharpenValue:(float)sharpenValue;

//滤镜重置函数
- (UIImage *)opencvResetAdjustValue:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
