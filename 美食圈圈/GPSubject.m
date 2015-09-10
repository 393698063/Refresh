//
//  GPSubject.m
//  美食圈圈
//
//  Created by qianfeng on 15-6-30.
//  Copyright (c) 2015年 qq. All rights reserved.
//

#import "GPSubject.h"

@implementation GPSubject
+ (id)subjectWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        //进行模型数据的封装
//        self.title = dict[@"title"];
//        self.cardNumber = dict[@"cardNumber"];
//        self.note = dict[@"note"];
//        self.icon = dict[@"icon"];
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}
- (NSString *)description
{
    return [NSString stringWithFormat:@"标题:%@数量%@标题%@图片%@",_title,_cardNumber,_note,_icon];
}


@end
