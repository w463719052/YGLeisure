//
//  YGBaseViewController.m
//  CloudShop-qpyun
//
//  Created by zccl2 on 16/3/11.
//  Copyright © 2016年 Wyg. All rights reserved.
//

#import "YGBaseViewController.h"
#import "YGHeader.h"

@interface YGBaseViewController ()

@end

@implementation YGBaseViewController

#pragma mark 设置NavigationBar样式
- (void)setNavigationBarWithBackButton:(BOOL)isBackButton {
    /**< 导航条标题*/
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                              NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
    /**< 导航条背景颜色*/
    self.navigationController.navigationBar.barTintColor = RGBCOLOR(37, 37, 37);
    /**< 如果有返回按钮*/
    if (isBackButton) {
        [self setBackButton];
    }
    self.edgesForExtendedLayout = UIRectEdgeLeft | UIRectEdgeRight;
    self.view.backgroundColor = [UIColor whiteColor];
}
#pragma mark 设置返回按钮
- (void)setBackButton {
    /**< 导航条按钮*/
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]
                                   initWithImage:[UIImage imageNamed:@"fanhui"]
                                   style:UIBarButtonItemStyleDone
                                   target:self
                                   action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftButton;
    /**< 导航条按钮颜色*/
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}
#pragma mark 返回上层
- (void)back {
    /**< 判断WebVC的navigationController里有多少viewController，如果1个则是pre*/
    if (self.navigationController.viewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}





@end
