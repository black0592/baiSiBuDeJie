//
//  FXTabBarController.m
//  百思不得姐
//
//  Created by fanxi on 16/3/11.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXTabBarController.h"
#import "FXEssenceViewController.h"
#import "FXNewViewController.h"
#import "FXFriendTrendsViewController.h"
#import "FXMeViewController.h"
#import "FXTabBar.h"
#import "FXNavigationController.h"

@interface FXTabBarController ()

@end

@implementation FXTabBarController

- (void)viewDidLoad
{
    UITabBarItem *item = [UITabBarItem appearance];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    
    NSMutableDictionary *selectAttrs = [NSMutableDictionary dictionary];
    selectAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    selectAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectAttrs forState:UIControlStateSelected];
    
    
    
    
    [self setUpChildVc:[[FXEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" highImage:@"tabBar_essence_click_icon"];
  
     [self setUpChildVc:[[FXNewViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" highImage:@"tabBar_new_click_icon"];
    
     [self setUpChildVc:[[FXFriendTrendsViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" highImage:@"tabBar_friendTrends_click_icon"];
    
     [self setUpChildVc:[[FXMeViewController alloc] initWithStyle:UITableViewStyleGrouped] title:@"我" image:@"tabBar_me_icon" highImage:@"tabBar_me_click_icon"];
    
    // 更换tabBar
    [self setValue:[[FXTabBar alloc] init] forKeyPath:@"tabBar"];


}

- (void)setUpChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image highImage:(NSString *)highImage
{
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:highImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
  FXNavigationController *nav = [[FXNavigationController alloc] initWithRootViewController:vc];
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
    
    [self addChildViewController:nav];
    
    

}

@end
