//
//  UIView+Extension.h
//  百思不得姐
//
//  Created by fanxi on 16/3/11.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic,assign) CGSize size;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

- (BOOL)isShowingOnKeyWindow;
@end
