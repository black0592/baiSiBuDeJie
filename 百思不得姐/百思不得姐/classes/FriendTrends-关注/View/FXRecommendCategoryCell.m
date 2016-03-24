//
//  FXRecommendCategoryCell.m
//  百思不得姐
//
//  Created by fanxi on 16/3/12.
//  Copyright © 2016年 fanxi. All rights reserved.
//

#import "FXRecommendCategoryCell.h"
#import "FXRecommendCategory.h"

@interface FXRecommendCategoryCell ()

@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;


@end

@implementation FXRecommendCategoryCell

- (void)awakeFromNib {
    
    self.backgroundColor = FXRGBColor(244, 244, 244);
    self.selectedIndicator.backgroundColor = FXRGBColor(219, 21, 26);
 
}

- (void)setCategory:(FXRecommendCategory *)category
{

    _category = category;
    self.textLabel.text = category.name;
   

}

- (void)layoutSubviews  //调整label的位置
{
    self.textLabel.y = 2;
    self.textLabel.x = 2;
    
//    FXLog(@"11%@",NSStringFromCGRect(self.textLabel.frame));
    self.textLabel.height = self.contentView.height - 2*self.textLabel.y;
    self.textLabel.frame = CGRectMake(10, 2, 300, 44);
    
//     FXLog(@"22%@",NSStringFromCGRect(self.textLabel.frame));

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated  //调整高亮状态下label的字体颜色 和 指示器显示与隐藏
{
    [super setSelected:selected animated:animated];
    
    self.selectedIndicator.hidden = !self.selected;
    
    
    self.textLabel.textColor = selected?self.selectedIndicator.backgroundColor:FXRGBColor(78, 78, 78);
   
}

@end
