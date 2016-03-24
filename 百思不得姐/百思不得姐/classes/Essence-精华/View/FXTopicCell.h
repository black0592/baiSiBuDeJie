//
//  FXTopicCell.h
//  百思不得姐
//
//  Created by fanxi on 16/3/16.
//  Copyright © 2016年 fanxi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FXTopic;

@interface FXTopicCell : UITableViewCell

@property (nonatomic,strong)  FXTopic  *topic;


+ (instancetype)cell;

@end
