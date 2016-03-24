//
//  FXTopicVideoView.m
//  百思不得姐
//
//  Created by fanxi on 16/3/18.
//  Copyright © 2016年 fanxi. All rights reserved.
//

#import "FXTopicVideoView.h"
#import "fxtopic.h"
#import <UIImageView+WebCache.h>
#import "FXShowPictureController.h"


@interface FXTopicVideoView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;

@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;

@end



@implementation FXTopicVideoView

+ (instancetype)videoView
{

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];

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
    
  
    // 时长
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    self.videotimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];



}

@end
