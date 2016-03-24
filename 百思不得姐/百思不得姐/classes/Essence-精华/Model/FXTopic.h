//
//  FXTopic.h
//  百思不得姐
//
//  Created by fanxi on 16/3/16.
//  Copyright © 2016年 fanxi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FXComment;

@interface FXTopic : NSObject

/** id */
@property (nonatomic, copy) NSString *ID;

@property (nonatomic,copy) NSString *name;    //名称

@property (nonatomic,copy) NSString *profile_image;  //头像

@property (nonatomic,copy) NSString *create_time;    //发帖时间

@property (nonatomic,copy) NSString *text;  //文字内容

@property (nonatomic,assign) NSInteger ding;  //顶的数量

@property (nonatomic,assign) NSInteger cai;   //踩得数量

@property (nonatomic,assign) NSInteger repost;  //转发数

@property (nonatomic,assign) NSInteger comment;  //评论数


@property (nonatomic,assign,getter=isSina_v) BOOL sina_v;  //新浪加v


@property (nonatomic,assign) CGFloat width;   //图片宽度

@property (nonatomic,assign) CGFloat height;  //图片高度

@property (nonatomic,assign) NSInteger voicetime;  //音频时长
@property (nonatomic,assign) NSInteger playcount;  //播放次数

/** 最热评论(期望这个数组中存放的是FXComment模型) */
@property (nonatomic, strong) FXComment *top_cmt;



/** 帖子的类型 */
@property (nonatomic, assign) FXTopicType type;


@property (nonatomic,copy) NSString *small_image;
@property (nonatomic,copy) NSString *middle_image;
@property (nonatomic,copy) NSString *large_image;

/** 图片是否太大 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;

/** 图片的下载进度 */
@property (nonatomic, assign) CGFloat pictureProgress;


/* 
 *  额外属性
 *
 */

/** cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;
/** 图片控件的frame */
@property (nonatomic, assign, readonly) CGRect pictureF;
/** voice控件的frame */
@property (nonatomic, assign, readonly) CGRect voiceF;

/** video控件的frame */
@property (nonatomic, assign, readonly) CGRect videoF;
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;












@end
