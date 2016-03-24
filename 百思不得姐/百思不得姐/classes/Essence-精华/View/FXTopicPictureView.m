//
//  FXTopicPictureView.m
//  百思不得姐
//
//  Created by fanxi on 16/3/17.
//  Copyright © 2016年 fanxi. All rights reserved.
//

#import "FXTopicPictureView.h"
#import "FXTopic.h"
#import <UIImageView+WebCache.h>
#import "FXShowPictureController.h"
#import "FXProgressView.h"

@interface FXTopicPictureView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;  //图片


@property (weak, nonatomic) IBOutlet UIImageView *gifView;   //gif标识

@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;  //查看大图按钮

@property (weak, nonatomic) IBOutlet FXProgressView *progressView;

@end

@implementation FXTopicPictureView

+ (instancetype)pictureView
{

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:0] lastObject];


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
    

    
    [self.progressView setProgress:self.topic.pictureProgress animated:YES];
    
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        topic.pictureProgress = receivedSize/expectedSize *1.0;
        [self.progressView setProgress:topic.pictureProgress animated:NO];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        
    }];
    
    
    
    //判断是否为gif
    
    NSString *extension = topic.large_image.pathExtension;
    
    self.gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];

    //判断是否显示点击查看全图
    if (topic.isBigPicture) {
        self.seeBigButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }  else {
        self.seeBigButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
    
    }
    


}


@end
