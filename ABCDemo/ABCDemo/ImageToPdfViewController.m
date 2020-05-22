//
//  ImageToPdfViewController.m
//  ABCDemo
//
//  Created by bingo on 2020/5/22.
//  Copyright © 2020 杭州笔声智能科技有限公司. All rights reserved.
//

#import "ImageToPdfViewController.h"
#import <ABCPDFKit/ABCPDFKit.h>

@interface ImageToPdfViewController ()

@end

@implementation ImageToPdfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [ABCPDF genneraPdfWithImages:@[] pageWidth:1024 pageHeight:1024 padding:0];
    // Do any additional setup after loading the view.
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
