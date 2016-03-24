//
//  FXShowPictureController.m
//  百思不得姐
//
//  Created by fanxi on 16/3/17.
//  Copyright © 2016年 fanxi. All rights reserved.
//

#import "FXShowPictureController.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>

@interface FXShowPictureController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic,weak) UIImageView *imageView;


@end

@implementation FXShowPictureController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    
    //图片尺寸
    CGFloat pictureW = FXScreenW;
    CGFloat pictureH = pictureW * self.topic.height/self.topic.width;
    
    if (pictureH > FXScreenH) {  //图片超过屏幕
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    }  else {
    
        imageView.size = CGSizeMake(pictureW, pictureH);
        imageView.centerY = FXScreenH * 0.5;
    }
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image]];
    


}


- (IBAction)back
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save
{
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    //将图片写入相册
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{

    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }  else {
    
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }


}

@end
