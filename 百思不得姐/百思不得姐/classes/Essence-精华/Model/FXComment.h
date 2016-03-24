//
//  FXComment.h
//  百思不得姐
//
//  Created by fanxi on 16/3/19.
//  Copyright © 2016年 fanxi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FXUser;

@interface FXComment : NSObject

/** id */
@property (nonatomic, copy) NSString *ID;

@property (nonatomic,assign) NSInteger voicetime;   //音频时长

@property (nonatomic,copy) NSString *content;  //评论内容

@property (nonatomic,assign) NSInteger like_count;  //被点赞的数量

@property (nonatomic,strong)  FXUser  *user;   //user模型







@end
