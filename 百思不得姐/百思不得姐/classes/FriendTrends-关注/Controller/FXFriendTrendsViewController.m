//
//  FXFriendTrendsViewController.m
//  百思不得姐
//
//  Created by fanxi on 16/3/11.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXFriendTrendsViewController.h"
#import "FXTestViewController.h"
#import "FXRecommendViewController.h"
#import "FXLoginRegisterViewController.h"

@interface FXFriendTrendsViewController ()

@end

@implementation FXFriendTrendsViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // 设置导航栏标题
    self.navigationItem.title = @"我的关注";
    
    self.view.backgroundColor = FXGlobalBg;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
    
    
}

- (void)friendsClick
{
    FXRecommendViewController *vc = [[FXRecommendViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}


- (IBAction)loginRegister
{
    FXLoginRegisterViewController *login = [[FXLoginRegisterViewController alloc] init];
    
    [self presentViewController:login animated:YES completion:nil];
    
    
}


@end
