//
//  ABCBaseModelHandler.h
//  ABCDetector
//
//  Created by bingo on 2020/3/31.
//  Copyright © 2020 杭州笔声智能科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ABCRectangle.h"

NS_ASSUME_NONNULL_BEGIN

@interface ABCBaseModelHandler : NSObject

- (BOOL) configureModel:(NSString *)name;
- (NSData *)runModel:(UIImage *)image modeSize:(CGSize)modeSize;
- (NSData *)runModelOnPixelBuffer:(CVPixelBufferRef)pixelBuffer  modeSize:(CGSize)modeSize;
- (NSData *)runModelInOriginal:(NSData *)imageData;
- (ABCRectangle *) handleCorners:(NSData *) inputData scale:(int) scale orgSize:(CGSize) size;

@end

NS_ASSUME_NONNULL_END
