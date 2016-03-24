//
//  FXMeFooter.m
//  百思不得姐
//
//  Created by fanxi on 16/3/21.
//  Copyright © 2016年 fanxi. All rights reserved.
//

#import "FXMeFooter.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "FXSquare.h"
#import "FXSquareButton.h"
#import "FXMeWebViewController.h"

@implementation FXMeFooter

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    
    //发送网络请求
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"square";
    params[@"c"] = @"topic";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *squares = [FXSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
                            
                            // 创建方块
                            [self createSquares:squares];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    

    return self;
}

- (void)createSquares:(NSArray *)squares
{
    int maxCols = 4;
    
    CGFloat buttonW = FXScreenW / maxCols;
    CGFloat buttonH = buttonW;
    
    for (int i = 0; i < squares.count; i++) {
        FXSquareButton *button = [[FXSquareButton alloc] init];
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.square = squares[i];
        [self addSubview:button];
        
        int row = i / maxCols;
        int col = i %maxCols;
        
        button.x = col * buttonW;
        button.y = row * buttonH;
        button.width = buttonW;
        button.height = buttonH;
        
    }
   
    NSInteger rows = (squares.count + maxCols - 1) / maxCols;
    
    self.height = rows * buttonH;
    
}

- (void)buttonClick:(FXSquareButton *)button
{
    if (![button.square.url hasPrefix:@"http:"])   return;
    
    FXMeWebViewController *web = [[FXMeWebViewController alloc] init];
    web.url = button.square.url;
    web.title = button.square.name;
    
    UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)tabBarVc.selectedViewController;
  
    [nav pushViewController:web animated:YES];
    FXLog(@"%@",button.square.name);

}



@end
