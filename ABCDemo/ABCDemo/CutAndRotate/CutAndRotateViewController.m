//
//  CutAndRotateViewController.m
//  ABCDemo
//
//  Created by bingo on 2020/5/22.
//  Copyright © 2020 杭州笔声智能科技有限公司. All rights reserved.
//

#import "CutAndRotateViewController.h"
#import "ABCGestureViewController.h"

#define angle2Rad(angle) ((angle) / 180.0 * M_PI)
#define rad2Angle(rad) (rad * 180.0 * M_PI)

@interface CutAndRotateViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) QuadrilateralView *quadView;
@property (nonatomic, strong) Quadrilateral *originalQuad;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSLayoutConstraint *quadViewWidthConstraint;
@property (nonatomic, strong) NSLayoutConstraint *quadViewHeightConstraint;
@property (nonatomic, strong) UIImage *currentOriginImage;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *btnLeftRotate;
@property (nonatomic, strong) UIButton *btnRightRotate;
@property (nonatomic, strong) UIButton *btnReMakeQuad;
@property (nonatomic, strong) UILongPressGestureRecognizer *touchDown;
@property (nonatomic, strong) ABCGestureViewController *zoomGestureController;
@property (nonatomic, assign) NSInteger rotateAngle;
@property (nonatomic, assign) NSInteger originalRotateAngle;
@property (nonatomic, copy) void (^cutCompletion)(UIImage *image, Quadrilateral *quad, NSInteger rotateAngle, BOOL isChanage);
@end

@implementation CutAndRotateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"example_image1" ofType:@"jpg"];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];

    Quadrilateral *quad = nil;
    DetectRectanglesUtils *rectanglesUtils = [[DetectRectanglesUtils alloc] init];
    quad = [rectanglesUtils detectWithTFLite:image];

    self.currentOriginImage = image;
    self.originalQuad = quad;

    [self setupViews];
    [self setupConstraints];

    _zoomGestureController = [[ABCGestureViewController alloc] init:self.currentOriginImage quadView:self.quadView];
    _touchDown = [[UILongPressGestureRecognizer alloc] initWithTarget:_zoomGestureController action:@selector(handle:)];
    _touchDown.delegate = self;
    _touchDown.minimumPressDuration = 0;
    [self.view addGestureRecognizer:_touchDown];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self adjustQuadViewConstraints];
    [self displayQuad:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
    self.navigationController.navigationBar.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
}

- (void)setupViews {
    CGSize viewMaxSize = self.view.frame.size;
    CGRect contentViewMaxFrame = CGRectMake(8, 8 + kResourceSafeAreaTopHeight, viewMaxSize.width - 16, viewMaxSize.height - 16 - (BOTTOM_MENU_HEIGHT + kResourceSafeAreaTopHeight));
    CGRect imageFrame = AVMakeRectWithAspectRatioInsideRect(self.currentOriginImage.size, contentViewMaxFrame);

    [self.view addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.center.equalTo(self.view);
      make.centerY.equalTo(self.view).offset(-(BOTTOM_MENU_HEIGHT - kResourceSafeAreaTopHeight + 8) / 2);
      make.width.equalTo(@(imageFrame.size.width));
      make.height.equalTo(@(imageFrame.size.height));
    }];

    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.quadView];
    [self.view addSubview:self.bottomView];
}

- (void)setupConstraints {
    NSArray *imageViewConstraints = @[ [self.imageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
                                       [self.imageView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor],
                                       [self.contentView.bottomAnchor constraintEqualToAnchor:self.imageView.bottomAnchor],
                                       [self.contentView.leadingAnchor constraintEqualToAnchor:self.imageView.leadingAnchor] ];
    _quadViewWidthConstraint = [self.quadView.widthAnchor constraintEqualToConstant:0.0];
    _quadViewHeightConstraint = [self.quadView.heightAnchor constraintEqualToConstant:0.0];

    NSArray *quadViewConstraints = @[ [self.quadView.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor],
                                      [self.quadView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
                                      _quadViewWidthConstraint,
                                      _quadViewHeightConstraint ];

    NSMutableArray *constarints = [NSMutableArray arrayWithArray:imageViewConstraints];
    [constarints addObjectsFromArray:quadViewConstraints];
    [NSLayoutConstraint activateConstraints:constarints];

    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.bottom.equalTo(self.view).offset(0);
      make.left.right.equalTo(self.view);
      make.height.equalTo(@(BOTTOM_MENU_HEIGHT));
    }];
}

- (void)adjustQuadViewConstraints {
    CGRect frame = AVMakeRectWithAspectRatioInsideRect(self.currentOriginImage.size, self.imageView.bounds);
    self.quadViewWidthConstraint.constant = frame.size.width;
    self.quadViewHeightConstraint.constant = frame.size.height;
}

- (void)displayQuad:(BOOL)isReMake {
    Quadrilateral *defaultQuad = [Quadrilateral defaultQuad:self.currentOriginImage];
    if (!self.originalQuad) {
        self.originalQuad = defaultQuad;
    }
    CGSize imageSize = self.currentOriginImage.size;
    CGRect imageFrame = CGRectMake(self.quadView.frame.origin.x, self.quadView.frame.origin.y, self.quadViewWidthConstraint.constant, self.quadViewHeightConstraint.constant);
    CGAffineTransform scaleTransform = [self scaleTransform:imageSize aspectFillInSize:imageFrame.size];
    DetectRectanglesUtils *detectUtils = [[DetectRectanglesUtils alloc] init];
    Quadrilateral *reQuad = [detectUtils detectWithTFLite:self.currentOriginImage];
    Quadrilateral *quad = (isReMake && reQuad) ? reQuad : self.originalQuad;
    Quadrilateral *transformedQuad = [quad applyTransforms:@[ [NSValue valueWithCGAffineTransform:scaleTransform] ]];
    [self.quadView drawQuadrilateral:transformedQuad animated:false];
}

- (CGAffineTransform)scaleTransform:(CGSize)fromSize aspectFillInSize:(CGSize)toSize {
    float scale = MAX(toSize.width / fromSize.width, toSize.height / fromSize.height);
    return CGAffineTransformMakeScale(scale, scale);
}

- (BOOL)compareQuad:(Quadrilateral *)quad withAnotherQuad:(Quadrilateral *)anotherQuad {
    BOOL isTopLeftEqual = CGPointEqualToPoint(quad.topLeft, anotherQuad.topLeft);
    BOOL isTopRightEqual = CGPointEqualToPoint(quad.topRight, anotherQuad.topRight);
    BOOL isBottomLeftEqual = CGPointEqualToPoint(quad.bottomLeft, anotherQuad.bottomLeft);
    BOOL isBottomRightEqual = CGPointEqualToPoint(quad.bottomRight, anotherQuad.bottomRight);
    return isTopLeftEqual && isTopRightEqual && isBottomLeftEqual && isBottomRightEqual;
}

#pragma mark - Action
- (void)btnRightRotateClick:(UIButton *)sender {
    if (self.rotateAngle < 270) {
        self.rotateAngle = self.rotateAngle + 90;
    } else {
        self.rotateAngle = 0;
    }

    [self rotateContentView:90];
}

- (void)btnLeftRotateClick:(UIButton *)sender {
    self.rotateAngle = self.rotateAngle - 90;
    if (self.rotateAngle < 0) {
        self.rotateAngle = 270;
    }

    [self rotateContentView:-90];
}

- (void)rotateContentView:(CGFloat)rotateAngle {
    CGFloat scale;
    CGFloat viewWidth = self.contentView.bounds.size.width;
    CGFloat viewHeight = self.contentView.bounds.size.height;
    if (self.rotateAngle == 0 || self.rotateAngle == 180) {
        scale = viewHeight / viewWidth;
    } else {
        scale = viewWidth / viewHeight;
    }

    [UIView animateWithDuration:0.3f
                     animations:^{
                       self.contentView.transform = CGAffineTransformRotate(self.contentView.transform, (angle2Rad(rotateAngle)));
                       self.contentView.transform = CGAffineTransformScale(self.contentView.transform, scale, scale);
                     }];
}

- (void)btnReMakeQuadClick:(UIButton *)sender {
    Quadrilateral *defaultQuad = [Quadrilateral defaultQuad:self.currentOriginImage];
    if (!sender.selected) { // 整图
        CGSize imageSize = self.currentOriginImage.size;
        CGRect imageFrame = CGRectMake(self.quadView.frame.origin.x, self.quadView.frame.origin.y, self.quadViewWidthConstraint.constant, self.quadViewHeightConstraint.constant);
        CGAffineTransform scaleTransform = [self scaleTransform:imageSize aspectFillInSize:imageFrame.size];
        Quadrilateral *transformedQuad = [defaultQuad applyTransforms:@[ [NSValue valueWithCGAffineTransform:scaleTransform] ]];
        [self.quadView drawQuadrilateral:transformedQuad animated:false];
    } else { // 吸附
        [self displayQuad:YES];
    }
    sender.selected = !sender.selected;
}

#pragma mark - set&get
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}

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

- (QuadrilateralView *)quadView {
    if (!_quadView) {
        _quadView = [[QuadrilateralView alloc] init];
        _quadView.editable = true;
        _quadView.fillColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.4];
        _quadView.strokeColor = [UIColor redColor];
        _quadView.alpha = 1;
        _quadView.translatesAutoresizingMaskIntoConstraints = false;
    }
    return _quadView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = [UIColor blackColor];
        [_bottomView addSubview:self.btnLeftRotate];
        [_bottomView addSubview:self.btnRightRotate];
        [_bottomView addSubview:self.btnReMakeQuad];

        float distance = (self.view.frame.size.width - 80 * 3) / 4.0;

        [_btnReMakeQuad mas_makeConstraints:^(MASConstraintMaker *make) {
          make.height.equalTo(@(56));
          make.width.equalTo(@(80));
          make.right.equalTo(self.bottomView).offset(-distance);
          make.top.equalTo(self.bottomView);
        }];

        [_btnRightRotate mas_makeConstraints:^(MASConstraintMaker *make) {
          make.right.equalTo(self.btnReMakeQuad.mas_left).offset(-distance);
          make.top.height.equalTo(self.btnReMakeQuad);
          make.width.equalTo(@(75));
        }];

        [_btnLeftRotate mas_makeConstraints:^(MASConstraintMaker *make) {
          make.right.equalTo(self.btnRightRotate.mas_left).offset(-distance);
          make.top.height.equalTo(self.btnReMakeQuad);
          make.width.equalTo(@(75));
        }];
    }

    return _bottomView;
}

- (UIButton *)btnLeftRotate {
    if (!_btnLeftRotate) {
        _btnLeftRotate = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnLeftRotate.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btnLeftRotate setTitle:@"左旋转" forState:UIControlStateNormal];
        [_btnLeftRotate addTarget:self action:@selector(btnLeftRotateClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnLeftRotate.userInteractionEnabled = YES;
        _btnLeftRotate.alpha = 1;
    }
    return _btnLeftRotate;
}

- (UIButton *)btnRightRotate {
    if (!_btnRightRotate) {
        _btnRightRotate = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnRightRotate.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btnRightRotate setTitle:@"右旋转" forState:UIControlStateNormal];
        [_btnRightRotate addTarget:self action:@selector(btnRightRotateClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnRightRotate.userInteractionEnabled = YES;
        _btnRightRotate.alpha = 1;
    }
    return _btnRightRotate;
}

- (UIButton *)btnReMakeQuad {
    if (!_btnReMakeQuad) {
        _btnReMakeQuad = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnReMakeQuad.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btnReMakeQuad setTitle:@"全图" forState:UIControlStateNormal];
        [_btnReMakeQuad setTitle:@"吸附" forState:UIControlStateSelected];
        [_btnReMakeQuad addTarget:self action:@selector(btnReMakeQuadClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnReMakeQuad.userInteractionEnabled = YES;
        _btnReMakeQuad.alpha = 1;
    }
    return _btnReMakeQuad;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[UIButton class]]) {
        return NO;
    }
    self.btnReMakeQuad.selected = YES;
    return YES;
}

@end
