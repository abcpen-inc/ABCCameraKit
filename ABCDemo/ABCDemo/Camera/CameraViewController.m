//
//  CameraViewController.m
//  ABCDemo
//
//  Created by bingo on 2019/5/14.
//  Copyright © 2019 杭州笔声智能科技有限公司. All rights reserved.
//

#import "CameraViewController.h"
#import "ImagePreviewViewController.h"

@interface CameraViewController () <ABCCameraViewDelegate>

@property (nonatomic, strong) ABCCameraView *cameraView;
@property (nonatomic, strong) UIButton *cameraBtn;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.cameraView];
    [self.view addSubview:self.cameraBtn];
}

- (void)viewWillAppear:(BOOL)animated {
    [_cameraView startPreview];
}

- (void)viewWillDisappear:(BOOL)animated {
    [_cameraView stopPreview];
}

- (void)dealloc {
    [_cameraView destory];
}

#pragma mark - events
- (void)onCameraClick:(id)sender {
    [_cameraView take];
}

- (ABCCameraView *)cameraView {
    if (!_cameraView) {
        _cameraView = [[ABCCameraView alloc] initWithFrame:self.view.bounds];
        _cameraView.delegate = self;
    }
    return _cameraView;
}

- (UIButton *)cameraBtn {
    if (!_cameraBtn) {
        _cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cameraBtn.contentMode = UIViewContentModeCenter;
        [_cameraBtn setImage:[UIImage imageNamed:@"cameta_shoot"] forState:UIControlStateNormal];
        [_cameraBtn addTarget:self action:@selector(onCameraClick:) forControlEvents:UIControlEventTouchUpInside];
        _cameraBtn.frame = CGRectMake(self.view.bounds.size.width / 2 - 50, self.view.bounds.size.height - 100, 100, 100);
        _cameraBtn.layer.shadowColor = [UIColor blackColor].CGColor;
        _cameraBtn.layer.shadowOffset = CGSizeMake(0, -3);
        _cameraBtn.layer.shadowRadius = 5;
        _cameraBtn.layer.shadowOpacity = 0.5;
    }
    return _cameraBtn;
}

- (void)onPictureTaken {
}

- (void)onPictureSaved:(UIImage *)image quad:(Quadrilateral *)quad {
    ImagePreviewViewController *previewCtrl = [[ImagePreviewViewController alloc] init];
    UIImage *finalimage = [DetectRectanglesUtils imageWithQuad:image quad:quad];
    previewCtrl.image = image;
    previewCtrl.quadImage = finalimage;
    [self.navigationController pushViewController:previewCtrl animated:YES];
}

- (void)onCameraError:(ABCCameraError *)error {
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
