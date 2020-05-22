//
//  ImageFilterViewController.m
//  ABCDemo
//
//  Created by bingo on 2020/5/22.
//  Copyright © 2020 杭州笔声智能科技有限公司. All rights reserved.
//

#import "ImageFilterViewController.h"

@interface ImageFilterViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *currentOriginImage;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *btnEnhance;
@property (nonatomic, strong) UIButton *btnBlackWhite;
@property (nonatomic, strong) UIButton *btnOriginal;

@end

@implementation ImageFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"example_image" ofType:@"jpg"];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    self.currentOriginImage = image;

    [self setupViews];
}

- (void)setupViews {
    [self.view addSubview:self.bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.bottom.equalTo(self.view).offset(0);
      make.left.right.equalTo(self.view);
      make.height.equalTo(@(BOTTOM_MENU_HEIGHT));
    }];

    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.view).offset(kResourceNaviBarHeight);
      make.left.right.equalTo(self.view);
      make.bottom.equalTo(self.bottomView.mas_top);
    }];
}

- (void)btnEnhanceClick:(UIButton *)sender {
    ABCOpenCVImageHelp *filterManager = [[ABCOpenCVImageHelp alloc] initWithDefaultValue];
    self.imageView.image = [filterManager opencvCommonFilterWithImage:_currentOriginImage];
}

- (void)btnBlackWhiteClick:(UIButton *)sender {
    ABCOpenCVImageHelp *filterManager = [[ABCOpenCVImageHelp alloc] initWithDefaultValue];
    self.imageView.image = [filterManager opencvBlackWhiteFilterWithImage:_currentOriginImage floatValue:1.0];
}

- (void)btnOriginalClick:(UIButton *)sender {
    self.imageView.image = _currentOriginImage;
}

#pragma mark - set&get
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.clipsToBounds = YES;
        _imageView.opaque = YES;
        _imageView.image = self.currentOriginImage;
        _imageView.backgroundColor = [UIColor blackColor];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.translatesAutoresizingMaskIntoConstraints = false;
    }
    return _imageView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = [UIColor blackColor];
        [_bottomView addSubview:self.btnEnhance];
        [_bottomView addSubview:self.btnBlackWhite];

        [_bottomView addSubview:self.btnOriginal];

        float distance = (self.view.frame.size.width - 80 * 3) / 4.0;

        [_btnOriginal mas_makeConstraints:^(MASConstraintMaker *make) {
          make.height.equalTo(@(56));
          make.width.equalTo(@(80));
          make.right.equalTo(self.bottomView).offset(-distance);
          make.top.equalTo(self.bottomView);
        }];

        [_btnEnhance mas_makeConstraints:^(MASConstraintMaker *make) {
          make.right.equalTo(self.btnOriginal.mas_left).offset(-distance);
          make.top.height.equalTo(self.btnOriginal);
          make.width.equalTo(@(80));
        }];

        [_btnBlackWhite mas_makeConstraints:^(MASConstraintMaker *make) {
          make.right.equalTo(self.btnEnhance.mas_left).offset(-distance);
          make.top.height.equalTo(self.btnOriginal);
          make.width.equalTo(@(80));
        }];
    }
    return _bottomView;
}

- (UIButton *)btnEnhance {
    if (!_btnEnhance) {
        _btnEnhance = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnEnhance.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btnEnhance setTitle:@"增强并锐化" forState:UIControlStateNormal];
        [_btnEnhance addTarget:self action:@selector(btnEnhanceClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnEnhance.userInteractionEnabled = YES;
        _btnEnhance.alpha = 1;
    }
    return _btnEnhance;
}

- (UIButton *)btnBlackWhite {
    if (!_btnBlackWhite) {
        _btnBlackWhite = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnBlackWhite.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btnBlackWhite setTitle:@"黑白滤镜" forState:UIControlStateNormal];
        [_btnBlackWhite addTarget:self action:@selector(btnBlackWhiteClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnBlackWhite.userInteractionEnabled = YES;
        _btnBlackWhite.alpha = 1;
    }
    return _btnBlackWhite;
}

- (UIButton *)btnOriginal {
    if (!_btnOriginal) {
        _btnOriginal = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnOriginal.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btnOriginal setTitle:@"原图" forState:UIControlStateNormal];
        [_btnOriginal addTarget:self action:@selector(btnOriginalClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnOriginal.userInteractionEnabled = YES;
        _btnOriginal.alpha = 1;
    }
    return _btnOriginal;
}

@end
