//
//  FXEssenceViewController.m
//  百思不得姐
//
//  Created by fanxi on 16/3/11.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXEssenceViewController.h"
#import "FXRecommendTagsViewController.h"
#import "FXTopicViewController.h"


@interface FXEssenceViewController () <UIScrollViewDelegate>

@property (nonatomic,weak) UIView *indicatorView;      //底部红色指示器
@property (nonatomic,weak) UIButton *selectedButton;   //当前选中的按钮

@property (nonatomic,weak) UIView *titlesView;         //顶部的所有标签
@property (nonatomic,weak) UIScrollView *contentView;        //底部所有的内容

@end

@implementation FXEssenceViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNav]; //初始化导航栏
    
    [self setupChildVcs];     //初始化子控制器
    
    [self setupTitlesView];   //初始化顶部的标题栏
    
    [self setupContentView];  //设置底部的scrollView
    
}


- (void)setupChildVcs
{
    FXTopicViewController *all = [[ FXTopicViewController alloc] init];
    all.title = @"全部";
    all.type = FXTopicTypeAll;
    [self addChildViewController:all];
    
     FXTopicViewController *video = [[ FXTopicViewController alloc] init];
    video.title = @"视频";
    video.type = FXTopicTypeVideo;
    [self addChildViewController:video];
    
     FXTopicViewController *voice = [[ FXTopicViewController alloc] init];
    voice.title = @"声音";
    voice.type = FXTopicTypeVoice;
    [self addChildViewController:voice];
    
     FXTopicViewController *picture = [[ FXTopicViewController alloc] init];
     picture.title = @"图片";
    picture.type = FXTopicTypePicture;
    [self addChildViewController:picture];
    
     FXTopicViewController *word = [[ FXTopicViewController alloc] init];
     word.title = @"段子";
     word.type = FXTopicTypeWord;
    [self addChildViewController:word];

}



- (void)setupTitlesView
{
    //标题栏整体
    
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titlesView.width = self.view.width;
    titlesView.height = 35;
    titlesView.y = 64;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    //底部红色指示器
    
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titlesView.height- indicatorView.height;
   
    self.indicatorView = indicatorView;
    
    
    //内部子标签
    
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];

    CGFloat width = titlesView.width/titles.count;
    CGFloat height = titlesView.height;
    
    for (NSInteger i=0; i<titles.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.height = height;
        button.width = width;
        button.x = i*width;
        button.tag = i;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
            
        }
        
    }
    
      [titlesView addSubview:indicatorView];

}

- (void)buttonClick:(UIButton *)button
{
  //修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    
//    [button.titleLabel sizeToFit];
    self.indicatorView.width = button.titleLabel.width;
    self.indicatorView.centerX = button.centerX;
    
    
//    //滚动
//    
//    CGPoint offSet = self.contentView.contentOffset;
//    offSet.x = button.tag * self.contentView.width;
//    
//    [self.contentView setContentOffset:offSet animated:YES];
    
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
    
    

}


- (void)setupContentView
{
    self.automaticallyAdjustsScrollViewInsets = NO;  //不要自动调整Inset
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    //添加第一个控制器的view
    
    [self scrollViewDidEndScrollingAnimation:contentView];


}




- (void)setupNav
{
    
    self.view.backgroundColor = FXGlobalBg;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    
}

- (void)tagClick
{
    [UIView animateWithDuration:0.3 animations:^{
        FXRecommendTagsViewController *tags = [[FXRecommendTagsViewController alloc] init];
        [self.navigationController pushViewController:(UIViewController *)tags animated:YES];
    }];
    

}

#pragma mark   --  <scrollViewDelegate>

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{

  //当前索引
    NSInteger index = scrollView.contentOffset.x/scrollView.width;
    
  //去处自控制器
    UITableViewController *vc = self.childViewControllers[index];

    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;  //默认为20
    vc.view.height = scrollView.height;  //   设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    
    //设置内边距
    
    CGFloat top = CGRectGetMaxY(self.titlesView.frame);
   
    CGFloat bot = self.tabBarController.tabBar.height;
    
    vc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bot, 0);
    
    //设置滚动条的内边距
    
    vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset;
    
    [scrollView addSubview:vc.view];
    
    


}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
  
    NSInteger index = scrollView.contentOffset.x/scrollView.width;
    
     // 点击按钮
    [self buttonClick:self.titlesView.subviews[index]];

}



@end
