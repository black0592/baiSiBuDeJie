//
//  FXPostWordViewController.m
//  百思不得姐
//
//  Created by fanxi on 16/3/22.
//  Copyright © 2016年 fanxi. All rights reserved.
//

#import "FXPostWordViewController.h"
#import "FXPlaceholderTextView.h"

@interface FXPostWordViewController ()

@property (nonatomic,weak) FXPlaceholderTextView *textView;

@end

@implementation FXPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTextView];
}

- (void)setupTextView
{
    FXPlaceholderTextView *textView = [[FXPlaceholderTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    [self.view addSubview:textView];
    self.textView = textView;
   
}

- (void)setupNav
{
    self.title = @"发表文字";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    self.navigationItem.rightBarButtonItem.enabled = NO; // 默认不能点击
    // 强制刷新
    [self.navigationController.navigationBar layoutIfNeeded];
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)post
{
    FXLogFunc;
}



@end
