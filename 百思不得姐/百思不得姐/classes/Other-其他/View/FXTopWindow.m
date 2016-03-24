//
//  FXTopWindow.m
//  百思不得姐
//
//  Created by fanxi on 16/3/20.
//  Copyright © 2016年 fanxi. All rights reserved.
//

#import "FXTopWindow.h"
#import "FXShowPictureController.h"
@implementation FXTopWindow

static UIWindow *window_;

+ (void)initialize
{
    window_ = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, FXScreenW, 20)];
    
    window_.windowLevel = UIWindowLevelAlert;
   
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)];
    [window_ addGestureRecognizer:tap];
    
    



}


+ (void)show
{

    window_.hidden = NO;


}

+ (void)windowClick
{


    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    
    [self searchScrollViewInView:window];
}

+ (void)searchScrollViewInView:(UIView *)superview
{

    for (UIScrollView *subView in superview.subviews) {
        if ([subView isKindOfClass:[UIScrollView class]] && subView.isShowingOnKeyWindow) {
            CGPoint offset = subView.contentOffset;
            offset.y = - subView.contentInset.top;
            [subView setContentOffset:offset animated:YES];
        }
        
        [self searchScrollViewInView:subView];
    }
    


}

@end
