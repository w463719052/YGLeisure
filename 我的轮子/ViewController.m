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
#import "YGDingDangVC.h"
#import "YGPiceModifyVC.h"
#import "YGDrawingVC.h"
#import "YGCardFlipVCViewController.h"
#import "YGNewMainVC.h"
#import "YGNewBluetoothPrintingVC.h"
#import "BLKWrite.h"
#import "AppDelegate.h"
#import "YGAppointmentVC.h"
#import "YGSVGAnalysisVC.h"

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
    _buttonArray = @[@"物流详情",@"个人简介",@"订单详情页",@"图片拼接",@"图片标注",@"卡牌翻页",@"图片轮播",@"条码打印",@"silk转MP3",@"SVG解析显示"];
    for (int i = 0; i<_buttonArray.count; i++) {
        int column = i%5;
        int line = i/5;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        button.frame  = CGRectMake(INTERVAL+(BUTTONWIDTH+INTERVAL)*column, StatusBarHeight+INTERVAL+(BUTTONHEIGTH+INTERVAL)*line, BUTTONWIDTH, BUTTONHEIGTH);
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
    }else if (send.tag == 2) {
        YGDingDangVC *myVC = [[YGDingDangVC alloc] init];
        UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:myVC];
        [self presentViewController:naVC animated:YES completion:nil];
    } else if (send.tag == 3) {
        YGPiceModifyVC *myVC = [[YGPiceModifyVC alloc] init];
        UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:myVC];
        [self presentViewController:naVC animated:YES completion:nil];
    } else if (send.tag == 4) {
        YGDrawingVC *myVC = [[YGDrawingVC alloc] init];
        UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:myVC];
        [self presentViewController:naVC animated:YES completion:nil];
    } else if (send.tag == 5) {
        YGCardFlipVCViewController *myVC = [[YGCardFlipVCViewController alloc] init];
        UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:myVC];
        [self presentViewController:naVC animated:YES completion:nil];
    } else if (send.tag == 6) {
        YGNewMainVC *myVC = [[YGNewMainVC alloc] init];
        UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:myVC];
        [self presentViewController:naVC animated:YES completion:nil];
    } else if (send.tag == 7) {
        [[BLKWrite Instance] setBWiFiMode:NO];
        //        AppDelegate *dele = [UIApplication sharedApplication].delegate;
        //        [self.navigationController pushViewController:dele.mConnBLE animated:YES];
        YGNewBluetoothPrintingVC *myVC = [YGNewBluetoothPrintingVC sharedInstance];
        UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:myVC];
        [self presentViewController:naVC animated:YES completion:nil];
    } else if (send.tag == 8) {
        YGAppointmentVC *myVC = [[YGAppointmentVC alloc] init];
        UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:myVC];
        [self presentViewController:naVC animated:YES completion:nil];
    } else if (send.tag == 9) {
        YGSVGAnalysisVC *myVC = [[YGSVGAnalysisVC alloc] init];
        UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:myVC];
        [self presentViewController:naVC animated:YES completion:nil];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
