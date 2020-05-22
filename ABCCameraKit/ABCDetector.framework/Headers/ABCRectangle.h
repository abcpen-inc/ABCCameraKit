//
//  ABCRectangle.h
//  ABCRectangleTool
//
//  Created by bingo on 2020/3/31.
//  Copyright © 2020 杭州笔声智能科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIkit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABCRectangle : NSObject

@property(nonatomic, assign) CGPoint topLeft;
@property(nonatomic, assign) CGPoint topRight;
@property(nonatomic, assign) CGPoint bottomRight;
@property(nonatomic, assign) CGPoint bottomLeft;

-(instancetype) init:(CGPoint) topLeft
            topRight:(CGPoint) topRight
         bottomRight:(CGPoint) bottomRight
          bottomLeft:(CGPoint) bottomLeft;

@end

NS_ASSUME_NONNULL_END
