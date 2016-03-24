//
//  UIImageView+FXExtension.m
//  百思不得姐
//
//  Created by fanxi on 16/3/21.
//  Copyright © 2016年 fanxi. All rights reserved.
//

#import "UIImageView+FXExtension.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (FXExtension)

- (void)setHeader:(NSString *)url
{
    UIImage *placeholderImage = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.image = image ? [image circleImage] : placeholderImage;
    }];
 



}

@end
