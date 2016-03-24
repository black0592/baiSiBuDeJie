//
//  FXTopicPictureView.h
//  百思不得姐
//
//  Created by fanxi on 16/3/17.
//  Copyright © 2016年 fanxi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FXTopic;

@interface FXTopicPictureView : UIView

@property (nonatomic,strong)  FXTopic  *topic;

+ (instancetype)pictureView;

@end
