//
//  FXTabBar.m
//  百思不得姐
//
//  Created by fanxi on 16/3/11.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXTabBar.h"
#import "FXPublishViewController.h"

@interface FXTabBar ()

@property (nonatomic,weak) UIButton *publishButton;

@end

@implementation FXTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置tabbar的背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        
        UIButton *publishButton = [[UIButton alloc] init];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        publishButton.size = publishButton.currentBackgroundImage.size;
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:publishButton];
        self.publishButton = publishButton;
        
        
        
    }
    return self;
}

- (void)publishClick
{
    FXPublishViewController *publish = [[FXPublishViewController alloc] init];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publish animated:YES completion:nil];


}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    BOOL added = NO;  //默认没有添加target
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    
    // 设置发布按钮的frame
    self.publishButton.center = CGPointMake(width * 0.5, height * 0.5);
    
    // 设置其他UITabBarButton的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 5;
    CGFloat buttonH = height;
    NSInteger index = 0;
    for (UIControl *button in self.subviews) {
        if (![button isKindOfClass:[UIControl class]] || button == self.publishButton) continue;
        
        // 计算按钮的x值
        CGFloat buttonX = buttonW * ((index > 1)?(index + 1):index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 增加索引
        index++;
        
        if (added == NO) {
            [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

//tab按钮被选 发出通知
- (void)buttonClick
{

    [FXNoteCenter postNotificationName:FXTabBarDidSelectNotification object:nil userInfo:nil];

}

@end
