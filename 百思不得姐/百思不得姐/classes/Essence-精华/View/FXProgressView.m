//
//  FXProgressView.m
//  百思不得姐
//
//  Created by fanxi on 16/3/17.
//  Copyright © 2016年 fanxi. All rights reserved.
//

#import "FXProgressView.h"

@implementation FXProgressView


- (void)awakeFromNib
{
    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{

    [super setProgress:progress animated:animated];
    
    NSString *text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

@end
