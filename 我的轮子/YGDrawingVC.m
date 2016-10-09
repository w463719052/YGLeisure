//
//  YGDrawingVC.m
//  我的轮子
//
//  Created by zccl2 on 16/9/23.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import "YGDrawingVC.h"
#import "YGDrawingView.h"

@interface YGDrawingVC ()

@end

@implementation YGDrawingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarWithBackButton:YES];
    self.title = @"图片标注";
    YGDrawingView *drawingView =[[YGDrawingView alloc] init];
    [self.view addSubview:drawingView];
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
