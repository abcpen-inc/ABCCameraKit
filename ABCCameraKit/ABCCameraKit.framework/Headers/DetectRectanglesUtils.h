//
//  DetectRectanglesUtils.h
//  ABCCameraKit
//
//  Created by bingo on 2019/5/14.
//  Copyright © 2019 杭州笔声智能科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Quadrilateral;
@interface DetectRectanglesUtils : NSObject

@property(nonatomic,strong) Quadrilateral *quad;
/**
 * 获取图片最大矩形
 */
-(Quadrilateral *) detect:(UIImage *) image;

-(Quadrilateral *)detectWithTFLite:(UIImage *)image;

-(Quadrilateral *)detectWithTFLite128:(UIImage *)image;

/**
 * 获取图片最大矩形快速的,相机实时发现
 */
-(Quadrilateral *) detectQuickly:(UIImage *) image;

+ (UIImage *) imageWithQuad:(UIImage *) image quad:(Quadrilateral *) quad;

@end

NS_ASSUME_NONNULL_END
