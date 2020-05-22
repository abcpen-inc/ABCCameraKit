//
//  Quadrilateral.h
//  ABCCameraKit
//
//  Created by bingo on 2019/5/14.
//  Copyright © 2019 杭州笔声智能科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIkit/UIKit.h>
#import <Vision/Vision.h>

NS_ASSUME_NONNULL_BEGIN

@interface Quadrilateral : NSObject<NSCoding>

@property(nonatomic, strong) UIBezierPath *path;

@property(nonatomic, assign) CGPoint topLeft;
@property(nonatomic, assign) CGPoint topRight;
@property(nonatomic, assign) CGPoint bottomRight;
@property(nonatomic, assign) CGPoint bottomLeft;

-(instancetype) init:(CIRectangleFeature *) rectangleFeature;

-(instancetype) initWithVNRectangle:(VNRectangleObservation *) rectangleObservation API_AVAILABLE(ios(11.0));

-(instancetype) init:(CGPoint) topLeft
            topRight:(CGPoint) topRight
         bottomRight:(CGPoint) bottomRight
          bottomLeft:(CGPoint) bottomLeft;

-(instancetype) initWithDictionary:(NSDictionary *) dic;

-(Quadrilateral *) applying:(CGAffineTransform) transform;

-(Quadrilateral *) applyTransforms:(NSArray *)transforms;

-(Quadrilateral *) scale:(CGSize) fromSize toSize:(CGSize) toSize withRotationAngle:(CGFloat) rotationAngle;

-(Quadrilateral *) tranformToSize:(CGSize) imageSize toRect:(CGRect) toRect;

-(Quadrilateral *)toCartesian:(CGFloat )height;

-(void) reorganize;

-(BOOL) isEquelZero;

-(BOOL) isEqualQuad:(Quadrilateral *) quad;

-(BOOL) isWithin:(CGFloat) distance ofRectangleFeature:(Quadrilateral *) rectangleFeature;

-(NSDictionary *) transformToDictionary;

+(Quadrilateral *)defaultQuad:(UIImage *)image;

-(double) perimeter;

@end

NS_ASSUME_NONNULL_END
