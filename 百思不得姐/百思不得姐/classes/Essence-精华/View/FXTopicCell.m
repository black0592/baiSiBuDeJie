//
//  FXTopicCell.m
//  百思不得姐
//
//  Created by fanxi on 16/3/16.
//  Copyright © 2016年 fanxi. All rights reserved.
//

#import "FXTopicCell.h"
#import "FXTopic.h"
#import <UIImageView+WebCache.h>
#import "FXTopicPictureView.h"
#import "FXTopicVoiceView.h"
#import "FXTopicVideoView.h"
#import "FXComment.h"
#import "fxtopic.h"
#import "FXUser.h"

@interface FXTopicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;  //头像

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;   //昵称

@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;  //时间


@property (weak, nonatomic) IBOutlet UIButton *ding;  //顶

@property (weak, nonatomic) IBOutlet UIButton *cai;   //踩

@property (weak, nonatomic) IBOutlet UIButton *share;  //分享

@property (weak, nonatomic) IBOutlet UIButton *comment;  //评论


@property (weak, nonatomic) IBOutlet UIImageView *sinaVView;  //新浪加v

@property (weak, nonatomic) IBOutlet UILabel *text_label;   //帖子内容

@property (weak,nonatomic) FXTopicPictureView *pictureView;   //中间的pictureView
@property (weak,nonatomic) FXTopicVoiceView *voiceView;       //中间的voiceView
@property (weak,nonatomic) FXTopicVideoView *videoView;       //中间的videoView

@property (weak, nonatomic) IBOutlet UIView *topCmtView;  //评论那个view

@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;




@end

@implementation FXTopicCell

+ (instancetype)cell
{

     return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
    

}

- (FXTopicPictureView *)pictureView
{
    if (!_pictureView) {
        FXTopicPictureView *pictureView = [FXTopicPictureView pictureView];
        [self addSubview:pictureView];
        self.pictureView = pictureView;
    }
   
    return _pictureView;

}

- (FXTopicVoiceView *)voiceView
{
    if (!_voiceView) {
       FXTopicVoiceView *voiceView = [FXTopicVoiceView voiceView];
        [self addSubview:voiceView];
        self.voiceView = voiceView;
    }
    
    return _voiceView;
    
}

- (FXTopicVideoView *)videoView
{
    if (!_videoView) {
        FXTopicVideoView *videoView = [FXTopicVideoView videoView];
        [self addSubview:videoView];
        self.videoView = videoView;
    }
    
    return _videoView;


}

- (void)awakeFromNib
{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (void)setTopic:(FXTopic *)topic
{
    _topic = topic;
    
    // 新浪加V
    self.sinaVView.hidden = !topic.isSina_v;
    
    // 设置头像
//    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    [self.profileImageView setHeader:topic.profile_image];
    
    // 设置名字
    self.nameLabel.text = topic.name;
    
    // 设置帖子的创建时间
    self.createTimeLabel.text = topic.create_time;
    
    // 设置按钮文字
    [self setupButtonTitle:self.ding count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.cai count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.share count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.comment count:topic.comment placeholder:@"评论"];
    
    // 设置帖子的文字内容
    self.text_label.text = topic.text;
    
    
    //设置中间的图片
    
    if (self.topic.type == FXTopicTypePicture) {
        self.pictureView.hidden = NO;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
        
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureF;
    } else if (self.topic.type == FXTopicTypeVoice) {
        self.voiceView.hidden = NO;
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        
        
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceF;
     
    }  else if (self.topic.type == FXTopicTypeVideo) {
        self.videoView.hidden = NO;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        
        
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoF;
    
    }  else {
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    
    
    }
    
    //处理热们评论
    FXComment *cmt = topic.top_cmt;
    if (cmt) {
        self.topCmtView.hidden = NO;
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@", cmt.user.username, cmt.content];
    } else {
        self.topCmtView.hidden = YES;
    }
    
}

/**
 * 设置底部按钮文字
 */
- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
    
    
    
}

- (void)setFrame:(CGRect)frame
{
//    frame.origin.x = FXTopicCellMargin;
//    frame.size.width -= 2 * FXTopicCellMargin;
    frame.size.height -= FXTopicCellMargin;
    frame.origin.y += FXTopicCellMargin;
    
    [super setFrame:frame];
}
- (IBAction)more

{
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"收藏",@"举报", nil];
    [sheet showInView:self.window];
    
}


@end
