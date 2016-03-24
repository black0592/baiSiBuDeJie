//
//  FXCommentCell.m
//  百思不得姐
//
//  Created by fanxi on 16/3/20.
//  Copyright © 2016年 fanxi. All rights reserved.
//

#import "FXCommentCell.h"
#import "FXComment.h"
#import "FXUser.h"
#import <UIImageView+WebCache.h>

@interface FXCommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UIImageView *sexView;


@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *likecountLabel;

@end

@implementation FXCommentCell


- (void)setComment:(FXComment *)comment
{
    _comment = comment;
    
//    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    [self.profileImageView setHeader:comment.user.profile_image];
    
    
    self.usernameLabel.text = comment.user.username;
    self.contentLabel.text = comment.content;
    self.likecountLabel.text = [NSString stringWithFormat:@"%zd",comment.like_count];
    
  self.sexView.image = [comment.user.sex isEqualToString:FXUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
                                   
}

- (void)awakeFromNib
{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

//- (void)setFrame:(CGRect)frame
//{
//    frame.origin.x = FXTopicCellMargin;
//    frame.size.width -= 2 * FXTopicCellMargin;
//    
//    [super setFrame:frame];
//}

@end
