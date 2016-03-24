//
//  FXTopicViewController.m
//  百思不得姐
//
//  Created by fanxi on 16/3/16.
//  Copyright © 2016年 fanxi. All rights reserved.
//

#import "FXTopicViewController.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "FXTopic.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "FXTopicCell.h"
#import "FXCommentViewController.h"
#import "FXNewViewController.h"

@interface FXTopicViewController ()

@property (nonatomic,strong) NSMutableArray *topics;  //帖子数目

@property (nonatomic,assign) NSInteger page;  //当前页面

/** 当加载下一页数据时需要这个参数 */
@property (nonatomic, copy) NSString *maxtime;
/** 上一次的请求参数 */
@property (nonatomic, strong) NSDictionary *params;

@property (nonatomic,assign) NSInteger lastSelectedIndex;   //上次选中的索引

@end

@implementation FXTopicViewController

- (NSMutableArray *)topics
{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初始化表格
    [self setupTableView];
    
    // 添加刷新控件
    [self setupRefresh];
    
    
}

static NSString * const FXTopicCellId = @"topic";
- (void)setupTableView
{
    // 设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = FXTitilesViewY + FXTitilesViewH;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    // 设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FXTopicCell class]) bundle:nil] forCellReuseIdentifier:FXTopicCellId];
    
     [FXNoteCenter addObserver:self selector:@selector(tabBarSelect) name:FXTabBarDidSelectNotification object:nil];
}

- (void)tabBarSelect
{
    //如果连续选中两次,直接刷新
    if (self.lastSelectedIndex == self.tabBarController.selectedIndex && self.view.isShowingOnKeyWindow)
        
    {
        [self.tableView.mj_header beginRefreshing];
    }
    
    self.lastSelectedIndex = self.tabBarController.selectedIndex;
}

- (void)setupRefresh
{
   
 
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
   
    // 自动改变透明度
   
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

/*  
 * 加载最新topic
 */
- (void)loadNewTopics
{
    [self.tableView.mj_footer endRefreshing];
  
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//         if (self.params != params) return;
        
        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        self.topics = [FXTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
//        FXLog(@"%@",self.topics);
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
        self.page = 0;  //清空页码
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.params != params) return;
        
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
    }];

}

// 先下拉刷新, 再上拉刷新第5页数据

// 下拉刷新成功回来: 只有一页数据, page == 0
// 上啦刷新成功回来: 最前面那页 + 第5页数据

/**
 * 加载更多的帖子数据
 */
- (void)loadMoreTopics
{
    [self.tableView.mj_header endRefreshing];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    NSInteger page = self.page + 1;
    params[@"page"] = @(page);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != params) return ;
        
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        NSArray *newTopics = [FXTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
       
        [self.topics addObjectsFromArray:newTopics];
        
      
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
        
        // 设置页码
        self.page = page;
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.params != params) return;
        
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    


}

#pragma mark - a参数
- (NSString *)a
{
    return [self.parentViewController isKindOfClass:[FXNewViewController class]] ? @"newlist" : @"list";
}



#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FXTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:FXTopicCellId];
    
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}


#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出帖子模型
    FXTopic *topic = self.topics[indexPath.row];
    

    return topic.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    FXCommentViewController *comment = [[FXCommentViewController alloc] init];
    comment.topic = self.topics[indexPath.row];
    
    [self.navigationController pushViewController:comment animated:YES];


}

@end
