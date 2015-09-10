//
//  GPSubject.h
//  美食圈圈
//
//  Created by qianfeng on 15-6-30.
//  Copyright (c) 2015年 qq. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * 话题模型,用于存储话题视图需要显示的数据
 */


@interface GPSubject : NSObject
/**
 *  用于存储话题标题内容
 */
@property(nonatomic,copy) NSString * title;
/**
 *  用于存储跟帖人数
 */
@property(nonatomic,copy) NSString * cardNumber;
@property(nonatomic,copy) NSString * note;
@property(nonatomic,copy) NSString * icon;
/**
 *返回一个GPsubject对象
 *
 *
 *
 *
 */
+ (id)subjectWithDict:(NSDictionary *)dict;
- (id)initWithDict:(NSDictionary *)dict;
@end
