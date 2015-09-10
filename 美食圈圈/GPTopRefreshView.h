//
//  GPTopRefreshView.h
//  美食圈圈
//
//  Created by qianfeng on 15-7-1.
//  Copyright (c) 2015年 qq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    GPTopRefreshViewDrag,
    GPTopRefreshViewEndDrag,
    GPTopRefreshViewLoading
} GPTopRefreshViewStatus;

@interface GPTopRefreshView : UIView

@property(nonatomic,assign)GPTopRefreshViewStatus status;
//@property(nonatomic,)
+ (id)topRefreshView;
@end
