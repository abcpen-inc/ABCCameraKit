//
//  ABCModel256Handler.h
//  ABCDetector
//
//  Created by bingo on 2020/3/31.
//  Copyright © 2020 杭州笔声智能科技有限公司. All rights reserved.
//

#import "ABCBaseModelHandler.h"
#import "ABCRectangle.h"

NS_ASSUME_NONNULL_BEGIN

@interface ABCModel256Handler : ABCBaseModelHandler

/** Unavailable. */
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithThreadCount:(int)threadCount;

- (ABCRectangle *)runModel:(UIImage *)image;

- (ABCRectangle *)runModelOnPixelBuffer:(CVPixelBufferRef)pixelBuffer orgianSize:(CGSize)size;

/// 图片需要自己处理，返回原始数据
/// 输入大小为128*128, 且输入RGB值域需放缩到[-1, 1].
/// 输出为属于正类的概率值, 在[0, 1]
/// @param imageData
- (NSData *)runModelInOriginal:(NSData *)imageData;

@end

NS_ASSUME_NONNULL_END
