//
//  GPSubjectCell.h
//  美食圈圈
//
//  Created by qianfeng on 15-6-30.
//  Copyright (c) 2015年 qq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPSubject.h"
@interface GPSubjectCell : UITableViewCell
@property(nonatomic,strong)GPSubject * sub;
+ (id)subjectCell;
+ (id)subjectCellWithTableView:(UITableView *)tableView;
@end
