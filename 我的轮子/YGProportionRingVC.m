//
//  YGProportionRingVC.m
//  我的轮子
//
//  Created by XuQibin on 2018/5/9.
//  Copyright © 2018年 com.zccl. All rights reserved.
//

#import "YGProportionRingVC.h"
#import "YGProportionRingView.h"

@interface YGProportionRingVC ()

@end

@implementation YGProportionRingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarWithBackButton:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel
    YGProportionRingView *proportionRingView = [[YGProportionRingView alloc] initWithFrame:CGRectMake(50, 100, ScreenWidth-100, ScreenWidth-100)];
    proportionRingView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:proportionRingView];
    proportionRingView.progress = 0.5;
    // Do any additional setup after loading the view.
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
