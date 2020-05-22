//
//  ImagePreviewViewController.m
//  ABCDemo
//
//  Created by bingo on 2019/6/3.
//  Copyright © 2019 杭州笔声智能科技有限公司. All rights reserved.
//

#import "ImagePreviewViewController.h"

@interface ImagePreviewViewController ()

@property(nonatomic, strong) UIImageView *imageView;

@property(nonatomic, strong) UIImageView *imageView2;


@end

@implementation ImagePreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.image = self.image;
    [self.view addSubview:_imageView];
    
    _imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-100,self.view.bounds.size.height-100,100,100)];
    _imageView2.contentMode = UIViewContentModeScaleAspectFit;
    _imageView2.image = self.quadImage;
    [self.view addSubview:_imageView2];
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
