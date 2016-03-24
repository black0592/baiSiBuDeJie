//
//  FXPublishViewController.m
//  百思不得姐
//
//  Created by fanxi on 16/3/18.
//  Copyright © 2016年 fanxi. All rights reserved.
//

#import "FXPublishViewController.h"
#import "FXVerticalButton.h"
#import <pop.h>
#import "FXPostWordViewController.h"
#import "FXNavigationController.h"

static CGFloat const FXAnimationDelay = 0.1;
static CGFloat const FXSpringFactor = 10;

@interface FXPublishViewController ()

@end

@implementation FXPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    // 让控制器的view不能被点击
    self.view.userInteractionEnabled = NO;
    
    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    
    CGFloat buttonStartX = 20;
    CGFloat buttonStartY = (FXScreenH - 2*buttonH)*0.5;
    CGFloat marginX = (FXScreenW - 2*buttonStartX - maxCols*buttonW) / (maxCols - 1);
    
    for (int i = 0; i<images.count; i++) {
        FXVerticalButton *button = [[FXVerticalButton alloc] init];
            [self.view addSubview:button];
        button.tag = i;
        //设置内容
         button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button setTitle:titles[i] forState:UIControlStateNormal];
     
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                //设置frame
        
        button.width = buttonW;
        button.height = buttonH;
        
        int row = i/maxCols;
        int col = i%maxCols;
        
      CGFloat buttonX = buttonStartX + col* (buttonW + marginX);
      CGFloat buttonY = buttonStartY + row * buttonH;
      CGFloat buttonStartY = buttonY - FXScreenH;
        
        POPSpringAnimation *anima = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        
        anima.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonStartY, buttonW, buttonH)];
        anima.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
        
        anima.springBounciness = FXSpringFactor;
        anima.springSpeed = FXSpringFactor;
        anima.beginTime = CACurrentMediaTime() + i*FXAnimationDelay;
        
        [button pop_addAnimation:anima forKey:nil];
        button.userInteractionEnabled = YES;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

        
    }
    
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
//    sloganView.y = FXScreenH *0.2;
//    sloganView.centerX = FXScreenW * 0.5;
    [self.view addSubview:sloganView];
    
    POPSpringAnimation *anima  = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    
    CGFloat centerX = FXScreenW * 0.5;
    CGFloat centerY = FXScreenH * 0.2;
    CGFloat centerBeginY = centerY - FXScreenH;
    
    anima.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBeginY)];
    anima.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerY)];
    
    anima.springBounciness = FXSpringFactor;
    anima.springSpeed = FXSpringFactor;
    anima.beginTime = CACurrentMediaTime() + images.count*FXAnimationDelay;
    [sloganView pop_addAnimation:anima forKey:nil];
    
    
    
    // 标语动画执行完毕, 恢复点击事件
    self.view.userInteractionEnabled = YES;
    
    
    
}

- (IBAction)cancel {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)buttonClick:(UIButton *)button
{
    
    if (button.tag == 2) {
        
        [self cancel];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            FXPostWordViewController *post = [[FXPostWordViewController alloc] init];
            FXNavigationController *nav = [[FXNavigationController alloc] initWithRootViewController:post];
            
            UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
            
            [root presentViewController:nav animated:YES completion:nil];
        });
        
     
        
        
    }
   



}

@end
