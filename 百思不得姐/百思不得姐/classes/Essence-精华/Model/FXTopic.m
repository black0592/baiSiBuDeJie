//
//  FXTopic.m
//  百思不得姐
//
//  Created by fanxi on 16/3/16.
//  Copyright © 2016年 fanxi. All rights reserved.
//

#import "FXTopic.h"
#import <MJExtension.h>
#import "FXComment.h"
#import "FXUser.h"


@implementation FXTopic

{
    CGFloat _cellHeight;
    CGRect _pictureF;
}

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2",
             @"ID" : @"id"
             };
}

+ (NSDictionary *)mj_objectClassInArray
{

    return @{  @"top_cmt" : @"FXComment"
             
               };


}

- (NSString *)create_time
{
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 帖子的创建时间
    NSDate *create = [fmt dateFromString:_create_time];
    
    if (create.isThisYear) { // 今年
        if (create.isToday) { // 今天
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            
            if (cmps.hour >= 1) { // 时间差距 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > 时间差距 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > 时间差距
                return @"刚刚";
            }
        } else if (create.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        } else { // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    } else { // 非今年
        return _create_time;
    }
}

- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        CGSize maxSize = CGSizeMake(FXScreenW-4*FXTopicCellMargin, MAXFLOAT);
        
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
        
        _cellHeight = FXTopicCellTextY + textH + FXTopicCellMargin;
        
        //根据cell类型计算cell高度
        
        if (self.type == FXTopicTypePicture) {
            CGFloat pictureW = maxSize.width;
            
            CGFloat pictureH = pictureW * self.height / self.width;
            
            if (pictureH >= FXTopicCellPictureMaxH) {
                pictureH = FXTopicCellPictureBreakH;
                
                self.bigPicture = YES; //大图
            }
            
            CGFloat pictureX = FXTopicCellMargin;
            CGFloat pictureY = FXTopicCellTextY + textH + FXTopicCellMargin;
            
            _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            
         
            _cellHeight += pictureH + FXTopicCellMargin;
           
        }  else if (self.type == FXTopicTypeVoice) { // 声音帖子
            
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = voiceW * self.height/self.width;
            
            CGFloat voiceX = FXTopicCellMargin;
            CGFloat voiceY = FXTopicCellTextY + textH + FXTopicCellMargin;
            
            _voiceF = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            
            _cellHeight += voiceH + FXTopicCellMargin;
            
        }  else if (self.type == FXTopicTypeVideo) {
        
            CGFloat videoW = maxSize.width;
            CGFloat videoH = videoW *self.height/self.width;
            
            CGFloat videoX = FXTopicCellMargin;
            CGFloat videoY = FXTopicCellTextY + textH + FXTopicCellMargin;
            
            _videoF = CGRectMake(videoX, videoY, videoW, videoH);
            
            _cellHeight += videoH + FXTopicCellMargin;
        
        
        }
        
        // 如果有最热评论
      
        if (self.top_cmt) {
            NSString *content = [NSString stringWithFormat:@"%@ : %@", self.top_cmt.user.username,self.top_cmt.content];
            CGFloat contentH = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
            _cellHeight += FXTopicCellTopCmtTitleH + contentH + FXTopicCellMargin;
        }
        
        
        
        // 底部工具条的高度
        _cellHeight += FXTopicCellBottomBarH + FXTopicCellMargin;
    }
    return _cellHeight;

}


@end
