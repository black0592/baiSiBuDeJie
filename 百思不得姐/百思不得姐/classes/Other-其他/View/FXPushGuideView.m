//
//  FXPushGuideView.m
//  百思不得姐
//
//  Created by fanxi on 16/3/15.
//  Copyright © 2016年 fanxi. All rights reserved.
//

#import "FXPushGuideView.h"

@implementation FXPushGuideView

- (IBAction)close {
    
    [self removeFromSuperview];
}
+ (instancetype)guideView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];

}

+ (void)show
{
   NSString *key = @"CFBundleShortVersionString";
    
    //获得当前软件版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    
    //获得沙盒存储软件版本号
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    
    if (![currentVersion isEqualToString:sanboxVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        FXPushGuideView *guide = [FXPushGuideView guideView];
        guide.frame = window.bounds;
        [window addSubview:guide];
    }

    [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



@end
