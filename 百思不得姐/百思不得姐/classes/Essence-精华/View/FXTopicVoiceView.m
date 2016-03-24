//
//  FXTopicVoiceView.m
//  百思不得姐
//
//  Created by fanxi on 16/3/18.
//  Copyright © 2016年 fanxi. All rights reserved.
//

#import "FXTopicVoiceView.h"
#import <UIImageView+WebCache.h>
#import "FXTopic.h"
#import "FXShowPictureController.h"

@interface FXTopicVoiceView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;

@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;

@end

@implementation FXTopicVoiceView



+ (instancetype)voiceView
{

    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];

}
- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

- (void)showPicture
{
    
    FXShowPictureController *showPicture = [[FXShowPictureController alloc] init];
    
    showPicture.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
    
    
    
}
- (void)setTopic:(FXTopic *)topic
{

    _topic = topic;
  
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    
    NSInteger minute = topic.voicetime/60;
    NSInteger second = topic.voicetime%60;
    
    self.voicetimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];

}

@end
