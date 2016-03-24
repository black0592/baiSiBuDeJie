//
//  FXNavigationController.m
//  百思不得姐
//
//  Created by fanxi on 16/3/11.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXNavigationController.h"

@interface FXNavigationController ()

@end

@implementation FXNavigationController

+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    [bar setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20]}];
    
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSAttachmentAttributeName] = [UIFont systemFontOfSize:17];
    itemAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    
    NSMutableDictionary *itemDisabledAttrs = [NSMutableDictionary dictionary];
    itemDisabledAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:itemDisabledAttrs forState:UIControlStateDisabled];

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
           
    }
    return self;
}

/**
 * 可以在这个方法中拦截所有push进来的控制器
 */

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
   
    
    if (self.childViewControllers.count > 0) {   // 如果push进来的不是第一个控制器
        
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        button.size = CGSizeMake(70, 30);
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -45, 0, 0);
        
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
        
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
 [super pushViewController:viewController animated:animated];
}

- (void)pop
{
    [self popViewControllerAnimated:YES];

}

@end
