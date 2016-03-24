//
//  FXRecommendUserCell.m
//  百思不得姐
//
//  Created by fanxi on 16/3/13.
//  Copyright © 2016年 fanxi. All rights reserved.
//

#import "FXRecommendUserCell.h"
#import "FXRecommendUser.h"
#import <UIImageView+WebCache.h>

@interface FXRecommendUserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;   //头像

@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation FXRecommendUserCell

- (void)setUser:(FXRecommendUser *)user
{
    _user = user;
    
 
    self.screenNameLabel.text = user.screen_name;
    self.fansCountLabel.text = [NSString stringWithFormat:@"%zd人关注",user.fans_count];
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];

    FXLog(@"%@ - %@ - %@",self.textLabel.text,  self.detailTextLabel.text,self.imageView.image);


}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
