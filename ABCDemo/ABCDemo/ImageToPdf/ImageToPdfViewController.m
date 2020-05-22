//
//  ImageToPdfViewController.m
//  ABCDemo
//
//  Created by bingo on 2020/5/22.
//  Copyright © 2020 杭州笔声智能科技有限公司. All rights reserved.
//

#import "ImageToPdfViewController.h"
#import <ABCPDFKit/ABCPDFKit.h>
#import <QuickLook/QuickLook.h>
#import <ABCCommonKit/ABCFileManager.h>

@interface ImageToPdfViewController () <QLPreviewControllerDataSource, QLPreviewControllerDelegate> {
    QLPreviewController *mQLPreviewController;
}

@property (nonatomic, strong) UIButton *btnBack;
@property (nonatomic, strong) NSString *pdfPath;

@property (nonatomic, strong) UILabel *barTitle;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;

@end

@implementation ImageToPdfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"example_image" ofType:@"jpg"];

    [self setupUI];
    self.pdfPath = [ABCPDF genneraPdfWithImages:@[ filePath, filePath ] pageWidth:1024 pageHeight:1024 padding:0];
}

- (void)setupUI {
    UIView *actionBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kResourceNaviBarHeight)];
    actionBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:actionBar];
    [actionBar mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.view).offset(0);
      make.left.equalTo(self.view);
      make.right.equalTo(self.view);
      make.height.equalTo(@(kResourceNaviBarHeight));
    }];

    [actionBar addSubview:self.btnBack];
    [_btnBack mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(actionBar).offset(kResourceStatusBarHeight);
      make.left.equalTo(actionBar);
      make.bottom.equalTo(actionBar);
      make.width.equalTo(@(48));
    }];

    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = [UIColor grayColor];
    [actionBar addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(actionBar);
      make.right.equalTo(actionBar);
      make.height.equalTo(@(1));
      make.bottom.equalTo(actionBar);
    }];

    mQLPreviewController = [[QLPreviewController alloc] init];
    mQLPreviewController.view.frame = self.view.bounds;
    mQLPreviewController.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mQLPreviewController.view];
    mQLPreviewController.dataSource = self;
    mQLPreviewController.delegate = self;
    [mQLPreviewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self.view);
      make.right.equalTo(self.view);
      make.top.equalTo(lineView.mas_bottom);
      make.bottom.equalTo(self.view);
    }];
}

#pragma mark -QLPreviewControllerDataSource
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller {
    return 1;
}

- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
    NSURL *fromPDFURL = [NSURL fileURLWithPath:[ABCFileManager absolutePath:self.pdfPath]];
    return fromPDFURL;
}

- (BOOL)previewController:(QLPreviewController *)controller shouldOpenURL:(NSURL *)url forPreviewItem:(id<QLPreviewItem>)item {
    return NO;
}

- (UIView *_Nullable)previewController:(QLPreviewController *)controller transitionViewForPreviewItem:(id<QLPreviewItem>)item {
    return nil;
}

- (UIImage *)previewController:(QLPreviewController *)controller transitionImageForPreviewItem:(id<QLPreviewItem>)item contentRect:(CGRect *)contentRect {
    return nil;
}

- (void)btnBackClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIButton *)btnBack {
    if (!_btnBack) {
        _btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnBack.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btnBack setTitleColor:[UIColor blackColor]];
        [_btnBack setTitle:@"返回" forState:UIControlStateNormal];
        [_btnBack addTarget:self action:@selector(btnBackClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnBack.userInteractionEnabled = YES;
        _btnBack.alpha = 1;
    }
    return _btnBack;
}

@end
