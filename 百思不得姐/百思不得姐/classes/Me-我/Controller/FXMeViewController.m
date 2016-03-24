//
//  FXMeViewController.m
//  百思不得姐
//
//  Created by fanxi on 16/3/11.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXMeViewController.h"
#import "FXMeCell.h"
#import "FXMeFooter.h"

@interface FXMeViewController ()

@end

@implementation FXMeViewController

static NSString *FXMeCellId = @"me";

- (void)moonClick
{
    FXLogFunc;
}

- (void)settingClick
{
    FXLogFunc;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
  
    [self setupNav];
    
    [self setupTableView];
    
}

- (void)setupNav
{

    // 设置导航栏标题
    self.navigationItem.title = @"我的";
    
    UIBarButtonItem *moon = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    UIBarButtonItem *setting = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    
    self.navigationItem.rightBarButtonItems = @[setting,moon];


}

- (void)setupTableView
{

   self.view.backgroundColor = FXGlobalBg;
    
   self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   
    [self.tableView registerClass:[FXMeCell class] forCellReuseIdentifier:FXMeCellId];
    
    self.tableView.sectionFooterHeight = FXTopicCellMargin;
    self.tableView.sectionHeaderHeight = 0;
    
    self.tableView.contentInset = UIEdgeInsetsMake(FXTopicCellMargin - 35, 0, 0, 0);
    
    self.tableView.tableFooterView = [[FXMeFooter alloc] init];
}


#pragma mark <UITableView DataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FXMeCell *cell  = [tableView dequeueReusableCellWithIdentifier:FXMeCellId];
    
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"mine_icon_nearby"];
        cell.textLabel.text = @"登录/注册";
    } else if (indexPath.section == 1) {
    
         cell.textLabel.text = @"离线下载";
    }

    return cell;

}

@end
