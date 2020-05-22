//
//  ABCGestureViewController.h
//  OwlScanner
//
//  Created by bingo on 2019/6/15.
//  Copyright © 2019 杭州笔声智能科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ABCCameraKit/QuadrilateralView.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABCGestureViewController : UIViewController

- (instancetype)init:(UIImage *)image quadView:(QuadrilateralView *)quadView;

- (void)handle:(UIGestureRecognizer *)pan;

@end

NS_ASSUME_NONNULL_END
