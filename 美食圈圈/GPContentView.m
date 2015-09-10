//
//  GPContentView.m
//  美食圈圈
//
//  Created by qianfeng on 15-6-30.
//  Copyright (c) 2015年 qq. All rights reserved.
//

#import "GPContentView.h"
#import "GPSubjectCell.h"
#import "GPFooterRefresh.h"
#import "GPTopRefreshView.h"
@interface GPContentView ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,weak)GPFooterRefresh * footRefresh;
@property(nonatomic,weak)GPTopRefreshView * topRefreshView;
@end

@implementation GPContentView

-(GPTopRefreshView *)topRefreshView
{
    if (_topRefreshView == nil) {
        GPTopRefreshView * tmpTopView = [GPTopRefreshView topRefreshView];
        _topRefreshView = tmpTopView;
        [self.tableView addSubview:_topRefreshView];
    }
    return _topRefreshView;
}
- (GPFooterRefresh *)footRefresh
{
    if (_footRefresh == nil) {
        GPFooterRefresh * footerRefresh = [GPFooterRefresh footerRefresh];
        _footRefresh = footerRefresh; //如果用弱指针直接创建对象,对象会释放
        [self.tableView addSubview:_footRefresh];
    }
    return _footRefresh;
}


- (void)setSubjects:(NSArray *)subjects
{
    _subjects = subjects;
    [self.tableView reloadData];
}

+ (id)contentView
{
   return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]lastObject];
}
+(id)contentViewWithBlock:(void(^)(GPContentView * contentView,NSIndexPath * indexPath,GPSubject * subject))didSelectRowAtIndexPathBlock andInstallView:(UIView *)view
{
    GPContentView * contentView = [self contentView];
    contentView.didSelectRowAtIndexPathBlock = didSelectRowAtIndexPathBlock;
    [view addSubview:contentView];
    
    return contentView;
}
+(id)contentViewWithBlock:(void(^)(GPContentView * contentView,NSIndexPath * indexPath,GPSubject * subject))didSelectRowAtIndexPathBlock andInstallView:(UIView *)view andModels:(NSArray *)models
{
    GPContentView * contentView = [self contentViewWithBlock:didSelectRowAtIndexPathBlock andInstallView:view];
    contentView.subjects = models;
    
    return contentView;
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.subjects.count;
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    GPSubjectCell * subCell = [GPSubjectCell subjectCellWithTableView:tableView];
    subCell.sub = self.subjects[indexPath.row];
    
    return subCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%tu",indexPath.row);
    //点击了哪一行
    //self.subjects[indexPath.row]
    //self
    
    if(self.didSelectRowAtIndexPathBlock)
    {
        self.didSelectRowAtIndexPathBlock(self,indexPath,self.subjects[indexPath.row]);
    }
}
#pragma mark UIScrollViewDelegate 代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.footRefresh;

    //上部拖拽
  //  if(scrollView.contentOffset.y < 0){
//        CGFloat topRefreshViewHeight = -self.topRefreshView.frame.size.height;
//        // NSLog(@"height = %f",topRefreshViewHeight);
//        
//        if (scrollView.contentOffset.y <= 0 && scrollView.contentOffset.y > topRefreshViewHeight) {
//            [self.topRefreshView setStatus:GPTopRefreshViewDrag];
//        }else if (scrollView.contentOffset.y < topRefreshViewHeight){
//            [self.topRefreshView setStatus:GPTopRefreshViewEndDrag];
//        }
  //  }
    
    //下部拖拽
  //  NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
//    CGFloat maxY = scrollView.contentSize.height - scrollView.frame.size.height;
//    
//  //   if(scrollView.contentOffset.y > maxY){
//        //最大偏移量
//        
//        NSLog(@"maxY = %f",maxY);
//        CGFloat footerHeight = self.footRefresh.frame.size.height;
//        
//        if(scrollView.contentOffset.y >= maxY && scrollView.contentOffset.y < maxY + footerHeight)
//        {
//            [self.footRefresh setStatus:GPFooterRefreshStatusDraging];
//        }else if (scrollView.contentOffset.y > maxY + footerHeight){
//            [self.footRefresh setStatus:GPFooterRefreshStatusEndDring];
//        }
   // }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate//停止拉时执行
{
//    //上部刷新
//  //  if (scrollView.contentOffset.y < 0) {
//        
//        if(self.topRefreshView.status == GPTopRefreshViewEndDrag){
//            [self.topRefreshView setStatus:GPTopRefreshViewLoading];
//            scrollView.contentInset = UIEdgeInsetsMake(self.topRefreshView.frame.size.height, 0, 0, 0);
//            //多线程
//            dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC *2);
//            dispatch_after(time, dispatch_get_main_queue(), ^{
//                //恢复contentSize的值
//                scrollView.contentInset = UIEdgeInsetsMake(0,0,0, 0);
//                //删除footerView
//                [self.topRefreshView removeFromSuperview];
//               // self.footRefresh = nil;
//                [self.footRefresh removeFromSuperview];
//             //   [self.footRefresh removeFromSuperview];
//                //加载数据
//                NSIndexSet * indexSet = [[NSIndexSet indexSet]initWithIndexesInRange:NSMakeRange(0, self.subjects.count)];
//                [self.subjects insertObjects:self.subjects atIndexes:indexSet];
//                // [self.subjects addObjectsFromArray:self.subjects];
//                
//                [self.tableView reloadData];
//                
//                
//                
//                
//            });
//        }
// //   }
//    CGFloat maxY = scrollView.contentSize.height - scrollView.frame.size.height;
//  //  if (scrollView.contentOffset.y > maxY){
        //底部刷新
        if (self.footRefresh.status == GPFooterRefreshStatusEndDring) {
            [self.footRefresh setStatus:GPFooterRefreshStatusLoading];
            scrollView.contentInset = UIEdgeInsetsMake(0, 0, self.footRefresh.frame.size.height, 0);
            
            dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC *2);
            dispatch_after(time, dispatch_get_main_queue(), ^{
                //恢复contentSize的值
                scrollView.contentInset = UIEdgeInsetsMake(0,0,0, 0);
                //删除footerView
                [self.footRefresh removeFromSuperview];
                
                //加载数据
                [self.subjects addObjectsFromArray:self.subjects];
                
                [self.tableView reloadData];
                
            });
            
        }
  //  }
    
}

@end
