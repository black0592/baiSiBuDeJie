
#import <UIKit/UIKit.h>

/** 精华-顶部标题的高度 */
UIKIT_EXTERN CGFloat const FXTitilesViewH;
/** 精华-顶部标题的Y */
UIKIT_EXTERN CGFloat const FXTitilesViewY;

/** 精华-cell-间距 */
UIKIT_EXTERN CGFloat const FXTopicCellMargin;
/** 精华-cell-文字内容的Y值 */
UIKIT_EXTERN CGFloat const FXTopicCellTextY;
/** 精华-cell-底部工具条的高度 */
UIKIT_EXTERN CGFloat const FXTopicCellBottomBarH;

//图片显示最大高度
UIKIT_EXTERN CGFloat const  FXTopicCellPictureMaxH;

/** 精华-cell-图片帖子一旦超过最大高度,就是用Break */
UIKIT_EXTERN CGFloat const  FXTopicCellPictureBreakH;

typedef enum {
    FXTopicTypeAll = 1,
    FXTopicTypePicture = 10,
    FXTopicTypeWord = 29,
    FXTopicTypeVoice = 31,
    FXTopicTypeVideo = 41
} FXTopicType;


/** XMGUser模型-性别属性值 */
UIKIT_EXTERN NSString * const FXUserSexMale;
UIKIT_EXTERN NSString * const FXUserSexFemale;

/** 精华-cell-最热评论标题的高度 */
UIKIT_EXTERN CGFloat const FXTopicCellTopCmtTitleH;

/** tabBar被选中的通知名字 */
NSString * const FXTabBarDidSelectNotification;
