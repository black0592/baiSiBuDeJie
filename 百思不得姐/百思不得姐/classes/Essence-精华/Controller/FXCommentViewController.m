//
//  FXCommentViewController.m
//  百思不得姐
//
//  Created by fanxi on 16/3/19.
//  Copyright © 2016年 fanxi. All rights reserved.
//

#import "FXCommentViewController.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import "FXTopicCell.h"
#import "fxtopic.h"
#import <MJExtension.h>
#import "FXComment.h"
#import "FXCommentCell.h"



@interface FXCommentViewController () <UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (strong,nonatomic) NSArray *hotComments;       //热门评论

@property (strong,nonatomic) NSMutableArray *latestComments; //最新评论

/** 保存帖子的top_cmt */
@property (nonatomic, strong)FXComment *saved_top_cmt;

/** 保存当前的页码 */
@property (nonatomic, assign) NSInteger page;

/** 管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;




@end

@implementation FXCommentViewController
static NSString * const FXCommentId = @"comment";

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupBasic];
    
    [self setupHeader];
    
    [self setupRefresh];
    
}


- (void)setupBasic
{

  self.title = @"评论";
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.tableView.estimatedRowHeight = 44;
    self.tableView.height = UITableViewAutomaticDimension;
    
    
    // 背景色
    self.tableView.backgroundColor = FXGlobalBg;
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FXCommentCell class]) bundle:nil] forCellReuseIdentifier:FXCommentId];

    // 去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 内边距
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, FXTopicCellMargin, 0);
    
   
}






- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 键盘显示\隐藏完毕的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 修改底部约束
    self.bottomSpace.constant = FXScreenH - frame.origin.y;
    // 动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 动画 及时刷新
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
        
    
    }];
    
}

- (void)dealloc
{

    [[NSNotificationCenter defaultCenter] removeObserver:self];

    
    // 取消所有任务
    //    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [self.manager invalidateSessionCancelingTasks:YES];
}



#pragma mark - <UITableViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}



- (void)setupHeader
{
    UIView *header = [[UIView alloc] init];

    FXTopicCell *cell = [FXTopicCell cell];
    cell.topic = self.topic;
    cell.size = CGSizeMake(FXScreenW, self.topic.cellHeight);
    
    [header addSubview:cell];
    
    header.height = cell.size.height + FXTopicCellMargin;
    
    self.tableView.tableHeaderView = header;

}

- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    self.tableView.mj_footer.hidden = YES;
    
    
}

- (void)loadMoreComments
{
    // 结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 页码
    NSInteger page = self.page + 1;
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"page"] = @(page);
    FXComment *cmt = [self.latestComments lastObject];
    params[@"lastcid"] = cmt.ID;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    }  success:^(NSURLSessionDataTask *task, id responseObject) {
        // 没有数据
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            self.tableView.mj_footer.hidden = YES;
            return;
        }
        
        // 最新评论
        NSArray *newComments = [FXComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.latestComments addObjectsFromArray:newComments];
        
        // self.latestComments = @[1, 3, 0, 9]
        // newComments = @[2, 8]
        //        [self.latestComments addObject:newComments];
        // self.latestComments = @[1, 3, 0, 9, @[2, 8]]
        
        // 页码
        self.page = page;
        
        // 刷新数据
        [self.tableView reloadData];
        
        // 控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= total) { // 全部加载完毕
            self.tableView.mj_footer.hidden = YES;
        } else {
            // 结束刷新状态
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)loadNewComments
{
   //结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            [self.tableView.mj_header endRefreshing];
            return;
        } // 说明没有评论数据
        
        self.hotComments = [FXComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        self.latestComments = [FXComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        self.page = 1;
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
        // 控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        
        FXLog(@"%zd",total);
        if (self.latestComments.count >= total) { // 全部加载完毕
            self.tableView.mj_footer.hidden = YES;
        }  else {
            self.tableView.mj_footer.hidden = NO;
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}



/**
 * 返回第section组的所有评论数组
 */

- (NSArray *)commentsInSection:(NSInteger )section
{
    if (section == 0) {
        return self.hotComments.count ? self.hotComments : self.latestComments;
    }

    return self.latestComments;
}

- (FXComment *)commentInIndexPath:(NSIndexPath *)indexPath
{

    return [self commentsInSection:indexPath.section][indexPath.row];


}



#pragma mark   ----- tableView  数据源

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    
    if (hotCount)  return 2;
    if (latestCount)  return 1;

    return 0;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;

    if (section == 0) {
        return hotCount ? hotCount : latestCount;
    }

    return latestCount;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSInteger hotCount = self.hotComments.count;
    
    if (section == 0) {
        return hotCount ? @"最热评论" : @"最新评论";
    }

     return @"最新评论";


}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    FXCommentCell *cell = [self.tableView dequeueReusableCellWithIdentifier:FXCommentId];
    cell.comment = [self commentInIndexPath:indexPath];
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 88;

}


@end
