//
//  ViewController.m
//  我的轮子
//
//  Created by zccl2 on 16/7/8.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import "ViewController.h"
#import "YGLogisticsInformationVC.h"
#import "YGHeader.h"
#import "YGPersonalProfileVC.h"
#import "YGSoundRecordingVC.h"
#import "YGDingDangVC.h"
#import "YGPiceModifyVC.h"
#import "YGDrawingVC.h"

@interface ViewController ()
{
    NSArray *_buttonArray;
}
@end

static NSInteger const INTERVAL = 5;
static NSInteger const BUTTONHEIGTH = 40;

#define BUTTONWIDTH (ScreenWidth-6*INTERVAL)/5

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _buttonArray = @[@"物流详情",@"个人简介",@"录音",@"订单详情页",@"图片拼接",@"画图"];
    for (int i = 0; i<_buttonArray.count; i++) {
        int column = i%5;
        int line = i/5;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        button.frame  = CGRectMake(INTERVAL+(BUTTONWIDTH+INTERVAL)*column, 20+INTERVAL+(BUTTONHEIGTH+INTERVAL)*line, BUTTONWIDTH, BUTTONHEIGTH);
        button.layer.cornerRadius = 5;
        button.backgroundColor = [UIColor blackColor];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        [button setTitle:_buttonArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    // Do any additional setup after loading the view, typically from a nib.
}

-  (void)buttonPress:(UIButton *)send {
    if (send.tag == 0) {
        YGLogisticsInformationVC *myVC = [[YGLogisticsInformationVC alloc] init];
        UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:myVC];
        [self presentViewController:naVC animated:YES completion:nil];
    } else if(send.tag == 1) {
        YGPersonalProfileVC *myVC = [[YGPersonalProfileVC alloc] init];
        UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:myVC];
        [self presentViewController:naVC animated:YES completion:nil];
    } else if(send.tag == 2) {
        YGSoundRecordingVC *myVC = [[YGSoundRecordingVC alloc] init];
        UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:myVC];
        [self presentViewController:naVC animated:YES completion:nil];
    } else if (send.tag == 3) {
        YGDingDangVC *myVC = [[YGDingDangVC alloc] init];
        UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:myVC];
        [self presentViewController:naVC animated:YES completion:nil];
    } else if (send.tag == 4) {
        YGPiceModifyVC *myVC = [[YGPiceModifyVC alloc] init];
        UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:myVC];
        [self presentViewController:naVC animated:YES completion:nil];
    } else if (send.tag == 5) {
        YGDrawingVC *myVC = [[YGDrawingVC alloc] init];
        UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:myVC];
        [self presentViewController:naVC animated:YES completion:nil];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
