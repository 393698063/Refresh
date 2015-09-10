//
//  GPCircleController.m
//  美食圈圈
//
//  Created by qianfeng on 15-6-30.
//  Copyright (c) 2015年 qq. All rights reserved.
//

#import "GPCircleController.h"
#import "GPSubject.h"
#import "GPAds.h"
#import "GPSubjectCell.h"
#import "GPContentView.h"
@interface GPCircleController ()
/**
 *  用户存储plist文件数组
 */
@property(nonatomic,strong)NSArray * plist;
@property(nonatomic,strong)NSArray * subjects;
@property(nonatomic,strong)NSArray * adses;
@end

@implementation GPCircleController
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
- (NSArray *)plist
{
    if (_plist == nil) {
        NSString * path = [[NSBundle mainBundle]pathForResource:@"quanquan" ofType:@"plist"];
        _plist = [NSArray arrayWithContentsOfFile:path];
    }
    return _plist;
}
- (NSArray *)subjects
{
    if (_subjects == nil) {
        NSArray * tmp = self.plist[1];
      
        NSMutableArray * objs = [[NSMutableArray alloc]init];
        for (NSDictionary * dict in tmp) {
            GPSubject * sub = [GPSubject subjectWithDict:dict];
            [objs addObject:sub];
        }
        _subjects = objs;
    }
    return _subjects;
}
- (NSArray *)adses
{
    if (_adses == nil) {
        NSArray * tmp = self.plist[0];
        NSMutableArray * objs = [[NSMutableArray alloc]init];
        for (NSDictionary * dict in tmp) {
            GPAds * ads = [GPAds adsWithDict:dict];
            [objs addObject:ads];
        }
        _adses = objs;
    }
    return _adses;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 //   NSLog(@"%@",self.subjects);
//    NSLog(@"%@",self.adses);
    [GPContentView contentViewWithBlock:^(GPContentView *contentView, NSIndexPath *indexPath, GPSubject *subject)
     {
        // NSLog(@"点击了 %ld 行 ,对应的模型数据是 %@",indexPath.row,subject);
     }
                         andInstallView:self.view
                              andModels:self.subjects];
    
    
//    NSString * __weak string = [[NSString alloc]initWithFormat:@"ddd"];
//    NSLog(@"string = %@",string);
}


//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 100.0f;
//}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
