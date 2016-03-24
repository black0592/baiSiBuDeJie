//
//  FXTopicViewController.h
//  百思不得姐
//
//  Created by fanxi on 16/3/16.
//  Copyright © 2016年 fanxi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FXTopicViewController : UITableViewController

/** 帖子类型(交给子类去实现) */
@property (nonatomic, assign) FXTopicType type;

@end
