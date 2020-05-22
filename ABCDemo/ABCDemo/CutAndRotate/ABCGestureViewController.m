//
//  ABCGestureViewController.m
//  OwlScanner
//
//  Created by bingo on 2019/6/15.
//  Copyright © 2019 杭州笔声智能科技有限公司. All rights reserved.
//

#import "ABCGestureViewController.h"
#import "ABCMagnifierView.h"

@interface ABCGestureViewController ()

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) QuadrilateralView *quadView;

@property (nonatomic, assign) CGPoint previousPanPosition;
@property (nonatomic, assign) CornerPosition closestCorner;

@property (nonatomic, assign) BOOL isReset;

@property (nonatomic, strong) ABCMagnifierView *magnifierView;

@end

@implementation ABCGestureViewController

- (instancetype)init:(UIImage *)image quadView:(QuadrilateralView *)quadView {
    self = [super init];
    if (self) {
        _isReset = YES;
        self.previousPanPosition = CGPointMake(-1, -1);
        self.image = image;
        self.quadView = quadView;
    }
    return self;
}

- (void)handle:(UIGestureRecognizer *)pan {
    Quadrilateral *drawnQuad = self.quadView.quad;
    if (!drawnQuad) {
        return;
    }

    if (pan.state == UIGestureRecognizerStateEnded) {
        self.previousPanPosition = CGPointMake(-1, -1);
        _isReset = YES;
        [self.quadView cornerViews:NO];
        [self.quadView resetHighlightedCornerViews];
        self.magnifierView = nil;
        return;
    }

    CGPoint position = [pan locationInView:self.quadView];

    if (CGPointEqualToPoint(_previousPanPosition, CGPointMake(-1, -1))) {
        _previousPanPosition = position;
    }

    CornerPosition closestCorner = self.closestCorner;
    if (_isReset) {
        _isReset = NO;
        closestCorner = [CGPointUtils closestCornerFrom:position quad:drawnQuad];
    }

    CGAffineTransform offset = CGAffineTransformMakeTranslation(position.x - _previousPanPosition.x, position.y - _previousPanPosition.y);
    EditScanCornerView *cornerView = [self.quadView cornerViewForCornerPosition:closestCorner];

    CGPoint draggedCornerViewCenter = CGPointApplyAffineTransform(cornerView.center, offset);

    [self.quadView moveCorner:cornerView atPoint:draggedCornerViewCenter];

    self.previousPanPosition = position;
    self.closestCorner = closestCorner;

    [self.quadView cornerViews:YES];
    CGPoint position2 = [self.quadView convertPoint:draggedCornerViewCenter toView:self.quadView.window];

    self.magnifierView.targetPoint = position2;
}

- (ABCMagnifierView *)magnifierView {
    if (!_magnifierView) {
        _magnifierView = [[ABCMagnifierView alloc] init];
        _magnifierView.magStyle = ABCMagnifierStyleCircular; //设为圆形
        _magnifierView.targetWindow = self.quadView.window;
        _magnifierView.adjustPoint = CGPointMake(0, -25); //放大镜位置调整
        _magnifierView.magnifierWidth = 60;               //设置宽度
        _magnifierView.AddLabelIsHidden = YES;
    }
    return _magnifierView;
}

@end
