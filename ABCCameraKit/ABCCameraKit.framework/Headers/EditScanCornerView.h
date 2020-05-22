//
//  EditScanCornerView.h
//  ABCCameraKit
//
//  Created by bingo on 2019/5/14.
//  Copyright © 2019 杭州笔声智能科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    topLeft,
    topRight,
    bottomRight,
    bottomLeft
} CornerPosition;

@interface EditScanCornerView : UIView

@property(nonatomic, assign) CornerPosition position;

@property(nonatomic, assign) BOOL isHighlighted;

- (instancetype)initWithFrame:(CGRect)frame position:(CornerPosition) position;

-(void) highlightWithImage:(UIImage *) image;

-(void) reset;

@end

NS_ASSUME_NONNULL_END
