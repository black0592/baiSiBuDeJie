//
//  FXRecommendTagsViewController.m
//  百思不得姐
//
//  Created by fanxi on 16/3/14.
//  Copyright © 2016年 fanxi. All rights reserved.
//

#import "FXRecommendTagsViewController.h"
#import <SVProgressHUD.h>
#import "FXRecommendTagCell.h"
#import "FXRecommendTag.h"
#import <AFNetworking.h>
#import <MJExtension.h>

@interface FXRecommendTagsViewController ()

@property (nonatomic,strong) NSArray *recommendTags;

@end

@implementation FXRecommendTagsViewController
static NSString *const FXTagsId = @"tag";

- (void)viewDidLoad
{
    
    [self setupTableView];
    
    [self loadData];
    

}

- (void)setupTableView
{
   self.view.backgroundColor = FXGlobalBg;
   self.title = @"推荐标签";
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FXRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:FXTagsId];
    
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
  


}

- (void)loadData
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
  
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.recommendTags = [FXRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
      
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败!"];
    }];



}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.recommendTags.count;
    
    FXLog(@"%zd",self.recommendTags.count);

}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FXRecommendTagCell *cell = [self.tableView dequeueReusableCellWithIdentifier:FXTagsId];
    
    
    cell.recommendTag = self.recommendTags[indexPath.row];
    
    return cell;


}
@end
