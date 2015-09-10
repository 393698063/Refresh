//
//  GPFooterRefresh.m
//  美食圈圈
//
//  Created by qianfeng on 15-7-1.
//  Copyright (c) 2015年 qq. All rights reserved.
//

#import "GPFooterRefresh.h"

@interface GPFooterRefresh ()
/**
 *  提示加载更多
 */
@property(nonatomic,weak)UIButton * alertBtn;

@property(nonatomic, weak) UIView * loadingView;
@property(nonatomic,weak) UITableView * tableView;

@end

@implementation GPFooterRefresh
- (UIView *)loadingView
{
    if (_loadingView == nil) {
        UIView * loadView = [[UIView alloc]init];
        loadView.frame = self.bounds;
        [self addSubview:loadView];
        self.loadingView = loadView;
        
         UIActivityIndicatorView * activetyView = [[UIActivityIndicatorView alloc]init];
        [activetyView startAnimating];
        activetyView.frame = CGRectMake(30, 20, 20, 20);
        activetyView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [self.loadingView addSubview:activetyView];
        
        UILabel * label = [[UILabel alloc]init];
        label.text = @"正在读取...";
        [_loadingView addSubview:label];
        label.frame = CGRectMake(70, 20, 200, 20);
        
    }
    return _loadingView;

}
- (UIButton *)alertBtn
{
    if (_alertBtn == nil) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
        [btn setTitle:@"拖拽读取更多" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        //设置标识图片距离文字间距50
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 50);
        //与父视图完去重合
        btn.frame = self.bounds;
        btn.userInteractionEnabled = NO;
        btn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        _alertBtn = btn;
        _alertBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_alertBtn];
    }
    return _alertBtn;
}
+ (id)footerRefresh
{
    return [[self alloc]init];
}

- (void)setStatus:(FooterRefreshStatus)status
{
    _status = status;
    switch (status) {
        case GPFooterRefreshStatusDraging:
        {
            [self.alertBtn setTitle:@"拖拽读取更多" forState:UIControlStateNormal];
            [UIView animateWithDuration:0.2 animations:^{
                self.alertBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
            }];
            NSLog(@"拖拽读取更多");
            break;
        }
        case GPFooterRefreshStatusEndDring:
        {
            NSLog(@"松开读取更多");
            [self.alertBtn setTitle:@"松开读取更多" forState:UIControlStateNormal];
            [UIView animateWithDuration:0.2 animations:^{
                self.alertBtn.imageView.transform = CGAffineTransformIdentity;
            }];
            break;
        }
        case GPFooterRefreshStatusLoading:
            self.loadingView;
            self.alertBtn.hidden = YES;
            NSLog(@"正在读取");
            break;
        default:
            break;
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [self.superview removeObserver:self forKeyPath:@"contentOffset"];
    _tableView = (UITableView *)newSuperview;
    CGFloat selfX = 0;
    CGFloat selfY = _tableView.contentSize.height;
    CGFloat selfW = _tableView.frame.size.width;
    CGFloat selfH = 60;
    self.frame = CGRectMake(selfX, selfY, selfW, selfH);
    self.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:255];
    [_tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    CGFloat maxY = _tableView.contentSize.height - _tableView.frame.size.height;
    NSLog(@"maxY = %f",maxY);
    CGFloat footerHeight = self.frame.size.height;
    
    if(_tableView.contentOffset.y >= maxY && _tableView.contentOffset.y < maxY + footerHeight)
    {
        [self setStatus:GPFooterRefreshStatusDraging];
    }else if (_tableView.contentOffset.y > maxY + footerHeight){
        [self setStatus:GPFooterRefreshStatusEndDring];
    }

    if(_tableView.decelerating && !_tableView.dragging)
    {
        if (self.status == GPFooterRefreshStatusEndDring) {
            [self setStatus:GPFooterRefreshStatusLoading];
            _tableView.contentInset = UIEdgeInsetsMake(0, 0, self.frame.size.height, 0);
            
            dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC *2);
            dispatch_after(time, dispatch_get_main_queue(), ^{
                //恢复contentSize的值
                _tableView.contentInset = UIEdgeInsetsMake(0,0,0, 0);
                //删除footerView
                [self removeFromSuperview];
                
                //加载数据
               // [_tableView.subjects addObjectsFromArray:self.subjects];
                
                [_tableView reloadData];
                
            });
            
        }
    }

}
@end
