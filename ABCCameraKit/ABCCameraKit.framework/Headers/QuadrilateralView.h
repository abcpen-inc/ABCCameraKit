//
//  QuadrilateralView.h
//  ABCCameraKit
//
//  Created by bingo on 2019/5/14.
//  Copyright © 2019 杭州笔声智能科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditScanCornerView.h"

NS_ASSUME_NONNULL_BEGIN

@class Quadrilateral;
@interface QuadrilateralView : UIView

@property(nonatomic, strong) Quadrilateral *quad;

@property(nonatomic, assign) BOOL editable;

@property(nonatomic, strong) UIColor *fillColor;

@property(nonatomic, strong) UIColor *strokeColor;

-(void) drawQuadrilateral:(Quadrilateral *) quad animated:(BOOL)animated;
-(void) removeQuadrilateral;
-(void) moveCorner:(EditScanCornerView *) cornerView atPoint:(CGPoint) point;
-(void) highlightCornerAtPosition:(CornerPosition) position with:(UIImage *) image;
-(void) resetHighlightedCornerViews;
-(void) cornerViews:(BOOL) hidden;
-(EditScanCornerView *)cornerViewForCornerPosition:(CornerPosition) position;

@end

NS_ASSUME_NONNULL_END
