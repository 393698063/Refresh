//
//  GPAds.m
//  美食圈圈
//
//  Created by qianfeng on 15-6-30.
//  Copyright (c) 2015年 qq. All rights reserved.
//

#import "GPAds.h"

@implementation GPAds
+ (id)adsWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        //封装模型
//        self.name = dict[@"name"];
//        self.icon = dict[@"icon"];
         [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"name = %@ icon = %@",_name,_icon];
}

@end
