//
//  FXNewViewController.m
//  百思不得姐
//
//  Created by fanxi on 16/3/11.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXNewViewController.h"

@interface FXNewViewController ()

@end

@implementation FXNewViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = FXGlobalBg;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    

}

- (void)tagClick
{
    
    FXLogFunc;
    
    
}



@end
