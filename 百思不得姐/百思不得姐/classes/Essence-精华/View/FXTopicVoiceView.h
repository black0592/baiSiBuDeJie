//
//  FXTopicVoiceView.h
//  百思不得姐
//
//  Created by fanxi on 16/3/18.
//  Copyright © 2016年 fanxi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FXTopic;

@interface FXTopicVoiceView : UIView

@property (nonatomic,strong)  FXTopic  *topic;

+ (instancetype)voiceView;

@end
