//
//  GPFooterRefresh.h
//  美食圈圈
//
//  Created by qianfeng on 15-7-1.
//  Copyright (c) 2015年 qq. All rights reserved.
//

#import <UIKit/UIKit.h>
enum FooterRefreshStatus
{
    GPFooterRefreshStatusDraging,//拖拽读取更多
    GPFooterRefreshStatusEndDring,//松开读取更多
    GPFooterRefreshStatusLoading    //正在读取
};
typedef enum FooterRefreshStatus FooterRefreshStatus;

@interface GPFooterRefresh : UIView

@property(nonatomic,assign) FooterRefreshStatus status;

+ (id)footerRefresh;
@end
