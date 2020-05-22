//
//  CGPointUtils.h
//  ABCCameraKit
//
//  Created by bingo on 2019/5/14.
//  Copyright © 2019 杭州笔声智能科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuadrilateralView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CGPointUtils : NSObject

+(CornerPosition )closestCornerFrom:(CGPoint) point quad:(Quadrilateral *)quad;

+(CGRect)surroundingSquare:(CGPoint) point withSize:(CGFloat)size;

+(BOOL)isWithin:(CGPoint)point delta:(CGFloat) delta ofPoint:(CGPoint) ofPoint;

+(CGPoint) scaled:(CGPoint )point ToSize:(CGSize) size;

+(CGPoint) intValue:(CGPoint) point;

+(CGFloat) distanceTo:(CGPoint) point poin1:(CGPoint) point1;

@end

NS_ASSUME_NONNULL_END
