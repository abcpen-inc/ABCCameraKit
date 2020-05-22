//
//  ABCCameraView.h
//  ABCCameraKit
//
//  Created by bingo on 2019/5/14.
//  Copyright © 2019 杭州笔声智能科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class Quadrilateral;
@class ABCCameraError;

NS_ASSUME_NONNULL_BEGIN

@protocol ABCCameraViewDelegate <NSObject>

-(void) onPictureTaken;

-(void) onPictureSaved:(UIImage *) image quad:(Quadrilateral *) quad;

-(void) onPicturePathSaved:(NSString *) imageUrl quad:(Quadrilateral *) quad;

-(void) onCameraError:(ABCCameraError *) error;

-(void) onDetectConfluence:(float) confluence;

@end

@interface ABCCameraView : UIView

@property(nonatomic, weak) id<ABCCameraViewDelegate> delegate;

@property(nonatomic) AVCaptureDevicePosition position;

@property(nonatomic, assign) AVCaptureTorchMode torchMode;

@property(nonatomic, strong) UIColor *fillColor;

@property(nonatomic, strong) UIColor *strokeColor;


//是否自动发现，默认YES
@property (nonatomic, assign) BOOL autoDetect;

@property (nonatomic, assign) BOOL showDelectView;

//是否自动裁剪
@property (nonatomic, assign) BOOL autoScan;

//s
@property (nonatomic, assign) BOOL autoSave;

//自动拍摄权重 默认 35帧
@property(nonatomic, assign) int autoScanThreshold;

@property(nonatomic, assign) BOOL useTFLite;

/**
 *  摄像头开启
 */
- (void)startPreview;

/**
 *  摄像头停止（disappear时调用）
 */
- (void)stopPreview;

/**
 *  切换前后摄像头
 *  @param isFront          前置YES  后置NO，默认后置
 */
//- (void)switchCamera:(BOOL)isFront;

/**
 *  拍照
 *  return imgRet           返回拍照的图片
 */
- (void)take;

- (void)destory;

@end

NS_ASSUME_NONNULL_END
