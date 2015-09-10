//
//  GPContentView.h
//  美食圈圈
//
//  Created by qianfeng on 15-6-30.
//  Copyright (c) 2015年 qq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPSubject.h"

@interface GPContentView : UIView


@property (nonatomic,copy)void(^didSelectRowAtIndexPathBlock)(GPContentView * contentView,NSIndexPath * indexPath,GPSubject * subject);
@property(nonatomic,strong) NSMutableArray * subjects;

+ (id)contentView;
+ (id)contentViewWithBlock:(void(^)(GPContentView * contentView,NSIndexPath * indexPath,GPSubject * subject))didSelectRowAtIndexPathBlock andInstallView:(UIView *)view;

+ (id)contentViewWithBlock:(void(^)(GPContentView * contentView,NSIndexPath * indexPath,GPSubject * subject))didSelectRowAtIndexPathBlock andInstallView:(UIView *)view andModels:(NSArray *)models;

@end
