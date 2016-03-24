//
//  FXLoginRegisterViewController.m
//  百思不得姐
//
//  Created by fanxi on 16/3/14.
//  Copyright © 2016年 fanxi. All rights reserved.
//

#import "FXLoginRegisterViewController.h"

@interface FXLoginRegisterViewController ()

@end

@implementation FXLoginRegisterViewController
- (IBAction)close {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = FXGlobalBg;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{


    return UIStatusBarStyleLightContent;

}

@end
