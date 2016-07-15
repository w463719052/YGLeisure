//
//  YGLiveVC.m
//  我的轮子
//
//  Created by zccl2 on 16/7/15.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import "YGLiveVC.h"

@interface YGLiveVC ()

@end

@implementation YGLiveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarWithBackButton:YES];
    self.edgesForExtendedLayout = UIRectEdgeLeft | UIRectEdgeRight;
    self.title = @"Live";
    self.view.backgroundColor = [UIColor whiteColor];
    [self addContentView];
    // Do any additional setup after loading the view.
}

- (void)addContentView {
    
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
