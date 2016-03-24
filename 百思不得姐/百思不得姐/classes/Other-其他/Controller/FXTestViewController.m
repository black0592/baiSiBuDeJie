//
//  FXTestViewController.m
//  百思不得姐
//
//  Created by fanxi on 16/3/11.
//  Copyright © 2016年 fanxi. All rights reserved.
//

#import "FXTestViewController.h"

@interface FXTestViewController ()

@end

@implementation FXTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"测试";
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor yellowColor];
    
    [self.navigationController pushViewController:vc animated:YES];
  

}


@end
