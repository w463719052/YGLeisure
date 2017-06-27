//
//  YGNewMainVC.m
//  我的轮子
//
//  Created by zccl2 on 16/12/5.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import "YGNewMainVC.h"
#import "YGRollingAdView.h"
#import "YGHeader.h"

@interface YGNewMainVC ()
{
    YGRollingAdView *_topView;
    UICollectionView *collectionView;
}
@end

@implementation YGNewMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarWithBackButton:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    YGRollingAdInfo *info1 = [YGRollingAdInfo new];
    info1.image = [UIImage imageNamed:@"banner1"];
    info1.linkurl = @"https://www.apple.com";
    YGRollingAdInfo *info2 = [YGRollingAdInfo new];
    info2.image = [UIImage imageNamed:@"banner2"];
    YGRollingAdInfo *info3 = [YGRollingAdInfo new];
    info3.image = [UIImage imageNamed:@"banner3"];
    NSArray *array = @[info1,info2,info3];
    if (!_topView) {
        _topView = [[YGRollingAdView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth/3)];
        _topView.rollPictureArray = array;
        _topView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_topView];
    }
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_topView startTimer];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_topView stopTimer];
}

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
