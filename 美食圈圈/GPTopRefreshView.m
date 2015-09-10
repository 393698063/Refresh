//
//  GPTopRefreshView.m
//  美食圈圈
//
//  Created by qianfeng on 15-7-1.
//  Copyright (c) 2015年 qq. All rights reserved.
//

#import "GPTopRefreshView.h"

@interface GPTopRefreshView ()

@property(nonatomic,weak)UIButton * remindButton;

@property(nonatomic,weak)UIView * loadView;

@end

@implementation GPTopRefreshView

+ (id)topRefreshView
{
    return [[self alloc]init];
}

-(void)setStatus:(GPTopRefreshViewStatus)status
{
    _status = status;
    switch (status) {
        case GPTopRefreshViewDrag:
        {
            [self.remindButton setTitle:@"下拉读取更多" forState:UIControlStateNormal];
            [UIView animateWithDuration:0.2 animations:^{
                self.remindButton.imageView.transform = CGAffineTransformIdentity ;
            }];
            NSLog(@"拉");
            break;
        }
        case GPTopRefreshViewEndDrag:{
            [self.remindButton setTitle:@"松开读取更多" forState:UIControlStateNormal];
            [UIView animateWithDuration:0.2 animations:^{
                self.remindButton.imageView.transform = CGAffineTransformMakeRotation(M_PI);
            }];
            NSLog(@"停");
            break;
        }
        case GPTopRefreshViewLoading:
            self.loadView;
            self.remindButton.hidden = YES;
            NSLog(@"读");
            break;
            
        default:
            break;
    }
}
-(UIView *)loadView
{
    if (_loadView == nil) {
        UIView * view = [[UIView alloc]init];
        view.frame = self.bounds;
        _loadView = view;
        [self addSubview:_loadView];
        
        UIActivityIndicatorView * activityView = [[UIActivityIndicatorView alloc]init];
        activityView.frame = CGRectMake(70, 10, 50, 50);
        [activityView startAnimating];
        activityView.color = [UIColor blueColor];
        [_loadView addSubview:activityView];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(150, 0, 150, 60)];
        label.text = @"读取中...";
        label.font = [UIFont systemFontOfSize:13];
        [_loadView addSubview:label];
    }
    return _loadView;
}
-(UIButton *)remindButton
{
    if (_remindButton == nil) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = self.bounds;
        [button setTitle:@"下拉读取更多" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 50);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _remindButton = button;
        [self addSubview:_remindButton];
    }
    return _remindButton;
}
-(void)willMoveToSuperview:(UIView *)newSuperview
{
    UITableView * tableView = (UITableView *)newSuperview;
    CGFloat selfX = 0;
    CGFloat selfH = 60;
    CGFloat selfY = -60;
    CGFloat selfW = tableView.frame.size.width;
    self.frame =CGRectMake(selfX, selfY, selfW, selfH);
    //self.backgroundColor = [UIColor redColor];
    self.backgroundColor = [UIColor colorWithRed:237 green:237 blue:237 alpha:255];
}

@end
