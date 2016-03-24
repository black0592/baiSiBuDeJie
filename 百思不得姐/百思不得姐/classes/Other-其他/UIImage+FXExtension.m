//
//  UIImage+FXExtension.m
//  百思不得姐
//
//  Created by fanxi on 16/3/21.
//  Copyright © 2016年 fanxi. All rights reserved.
//

#import "UIImage+FXExtension.h"

@implementation UIImage (FXExtension)

- (UIImage *)circleImage
{
   
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    CGContextRef ctx =  UIGraphicsGetCurrentContext();
    
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    CGContextClip(ctx);
    
    [self drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();


    return image;
}




@end
