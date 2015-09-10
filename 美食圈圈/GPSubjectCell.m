//
//  GPSubjectCell.m
//  美食圈圈
//
//  Created by qianfeng on 15-6-30.
//  Copyright (c) 2015年 qq. All rights reserved.
//

#import "GPSubjectCell.h"

@interface GPSubjectCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;

@end


@implementation GPSubjectCell

- (void)setSub:(GPSubject *)sub
{
    _sub = sub;
    //更新空间数据
    self.iconImageView.image = [UIImage imageNamed:sub.icon];
    self.titleLabel.text = sub.title;
    self.cardNumberLabel.text = sub.cardNumber;
    self.noteLabel.text = sub.note;
}



+ (id)subjectCell
{
//    return [[[NSBundle mainBundle]loadNibNamed:@"GPSubjectCell" owner:nil options:nil]lastObject];

    UINib * nib = [UINib nibWithNibName:@"GPSubjectCell" bundle:nil];
    return [[nib instantiateWithOwner:self options:nil]lastObject];
}
+ (id)subjectCellWithTableView:(UITableView *)tableView
{
//    static NSString * Identifier = @"GPSubjectCell";
//    GPSubjectCell * cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
//    if (!cell) {
//        UINib * nib = [UINib nibWithNibName:@"GPSubjectCell" bundle:nil];
//        cell = [[nib instantiateWithOwner:self options:nil]lastObject];
//    }
 //   return cell;
    NSString * Identifier = NSStringFromClass([self class]);
   //ios6.0之后新引入的注册机制
    UINib * nib = [UINib nibWithNibName:Identifier bundle:nil];
    //注册nib文件
    [tableView registerNib:nib forCellReuseIdentifier:Identifier];
    //如果有则返回,如果没有则创建
    return [tableView dequeueReusableCellWithIdentifier:Identifier];
    
}



- (void)awakeFromNib {
    // Initialization code
}










- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
