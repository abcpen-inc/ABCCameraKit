//
//  MasterViewController.m
//  ABCDemo
//
//  Created by bingo on 2019/5/14.
//  Copyright © 2019 杭州笔声智能科技有限公司. All rights reserved.
//

#import "MasterViewController.h"
#import "CameraViewController.h"

@interface MasterViewController ()

@property NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.objects = [NSMutableArray arrayWithObjects:@"Camera",@"CutAndRotate",@"ImageFilter",@"ImageToPdf", nil];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDate *object = self.objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *className = [NSString stringWithFormat:@"%@ViewController",cell.textLabel.text];
    id cls = [[NSClassFromString(className) alloc]init];
    if (cls && [cls isKindOfClass:[UIViewController class]]) {
        UIViewController *viewCtrl = (UIViewController *)cls;
        [self.navigationController pushViewController:viewCtrl animated:YES];
    }
}


@end
