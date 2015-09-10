//
//  GPAds.h
//  美食圈圈
//
//  Created by qianfeng on 15-6-30.
//  Copyright (c) 2015年 qq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPAds : NSObject
/**
 *  广告名称
 */
@property(nonatomic,copy) NSString * name;
/**
 *  广告图片名字
 */
@property(nonatomic,copy) NSString * icon;

+ (id)adsWithDict:(NSDictionary *)dict;
- (id)initWithDict:(NSDictionary *)dict;
@end
