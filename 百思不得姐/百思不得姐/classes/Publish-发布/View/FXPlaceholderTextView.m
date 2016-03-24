//
//  FXPlaceholderTextView.m
//  百思不得姐
//
//  Created by fanxi on 16/3/22.
//  Copyright © 2016年 fanxi. All rights reserved.
//

#import "FXPlaceholderTextView.h"

@interface FXPlaceholderTextView ()

/** 占位文字label */
@property (nonatomic, weak) UILabel *placeholderLabel;
@end

@implementation FXPlaceholderTextView


- (UILabel *)placeholderLabel
{
    if (!_placeholderLabel) {
        // 添加一个用来显示占位文字的label
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.x = 4;
        placeholderLabel.y = 7;
        [self addSubview:placeholderLabel];
        _placeholderLabel = placeholderLabel;
    }
    return _placeholderLabel;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
       
        self.alwaysBounceVertical = YES;
        self.font = [UIFont systemFontOfSize:15];
        self.placeholderColor = [UIColor grayColor];
        
        [FXNoteCenter addObserver:self selector:@selector(textDidChange) name:UITextFieldTextDidChangeNotification object:nil];
    }

    return self;
}

- (void)dealloc
{
    [FXNoteCenter removeObserver:self];
}

- (void)textDidChange
{
    // 只要有文字, 就隐藏占位文字label
    self.placeholderLabel.hidden = self.hasText;


}


/**
 * 更新占位文字的尺寸
 */
- (void)updatePlaceholderLabelSize
{
    CGSize maxSize = CGSizeMake(FXScreenW - 2 * self.placeholderLabel.x, MAXFLOAT);
    self.placeholderLabel.size = [self.placeholder boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.font} context:nil].size;
//    self.placeholderLabel.backgroundColor = [UIColor redColor];
}


#pragma mark - 重写setter
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    self.placeholderLabel.textColor = placeholderColor;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    self.placeholderLabel.text = placeholder;
    
    [self updatePlaceholderLabelSize];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    
    [self updatePlaceholderLabelSize];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self textDidChange];
}



@end
