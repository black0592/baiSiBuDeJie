//
//  FXTextField.m
//  百思不得姐
//
//  Created by fanxi on 16/3/15.
//  Copyright © 2016年 fanxi. All rights reserved.
//

#import "FXTextField.h"

@implementation FXTextField

static NSString * const FXPlacerholderColorKeyPath = @"_placeholderLabel.textColor";

- (void)awakeFromNib
{
    //    UILabel *placeholderLabel = [self valueForKeyPath:@"_placeholderLabel"];
    //    placeholderLabel.textColor = [UIColor redColor];
    
    //    // 修改占位文字颜色
    //    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    // 设置光标颜色和文字颜色一致
    self.tintColor = self.textColor;
    
    // 不成为第一响应者
    [self resignFirstResponder];
}

/**
 * 当前文本框聚焦时就会调用
 */
- (BOOL)becomeFirstResponder
{
    // 修改占位文字颜色
    [self setValue:self.textColor forKeyPath:FXPlacerholderColorKeyPath];
    return [super becomeFirstResponder];
}

/**
 * 当前文本框失去焦点时就会调用
 */
- (BOOL)resignFirstResponder
{
    // 修改占位文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:FXPlacerholderColorKeyPath];
    return [super resignFirstResponder];
}

@end
