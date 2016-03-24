//
//  FXRecommendViewController.m
//  百思不得姐
//
//  Created by fanxi on 16/3/12.
//  Copyright © 2016年 fanxi. All rights reserved.
//

#import "FXRecommendViewController.h"
#import "FXRecommendCategoryCell.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import "FXRecommendCategory.h"
#import "FXRecommendUserCell.h"
#import "FXRecommendUser.h"

@interface FXRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;  //左边的类别数据
@property (nonatomic,strong) NSArray *users;     //右边用户的数据


@property (nonatomic,strong) NSArray *categories;   //左边的tableView
@property (weak, nonatomic) IBOutlet UITableView *userTableView;  //右边的用户表格


@end

@implementation FXRecommendViewController

static NSString *const FXCategoryId = @"category";   //cell标识
static NSString *const FXUserId = @"user";


- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self setupTableView];
    

    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
  
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        
        // 服务器返回的JSON数据
        self.categories = [FXRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.categoryTableView reloadData];
    
       [self.categoryTableView reloadData];
     
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
    
   
}

- (void)setupTableView
{
   
    self.title = @"推荐关注";
     self.view.backgroundColor = FXGlobalBg;
    // 注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([FXRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:FXCategoryId];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([FXRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:FXUserId];
    
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.userTableView.backgroundColor = FXGlobalBg;
    
    



}


#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) { // 左边的类别表格
        
        
        FXLog(@"11---%zd",self.categories.count);
        return self.categories.count;
        
    } else { // 右边的用户表格
       
        
          FXLog(@"22---%zd",self.users.count);
         return self.users.count;
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) { // 左边的类别表格
        FXRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:FXCategoryId];
        cell.category = self.categories[indexPath.row];
        return cell;
    } else { // 右边的用户表格
        FXRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:FXUserId];
        cell.user = self.users[indexPath.row];
        return cell;
    }
}


#pragma mark tableView代理方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FXRecommendCategory *c = self.categories[indexPath.row];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(c.id);
  
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.users = [FXRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.userTableView reloadData];
        
//        FXLog(@"%@",responseObject[@"list"]);
     
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];


}
@end
