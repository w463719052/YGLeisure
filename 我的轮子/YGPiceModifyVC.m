//
//  YGPiceModifyVC.m
//  我的轮子
//
//  Created by zccl2 on 16/9/9.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import "YGPiceModifyVC.h"
#import "YGHeader.h"
#import "YGMosaicImageView.h"
#import "YGMosaicImageInfo.h"

static NSInteger const BackViewSpace = 30;


@interface YGPiceModifyVC ()
{
    YGMosaicImageView *_imageView;
}

@end

@implementation YGPiceModifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarWithBackButton:YES];
    self.title = @"图片拼接";
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 40, 40);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    rightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(BackViewSpace, BackViewSpace, ScreenWidth-2*BackViewSpace, (ScreenWidth-2*BackViewSpace-20)/0.6+20)];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 8;
    backView.layer.masksToBounds = YES;
    [self.view addSubview:backView];
    
    YGMosaicImageInfo *info = [[YGMosaicImageInfo alloc] init];
    info.logoImage = @"云店铺图标";/**<店铺图标*/
    info.storeName = @"博世电机厦门旗舰店";/**<店铺名称*/
    info.mobile = @"13575440119";/**<电话号码*/
    info.photo = @"phone";/**<照片*/
    info.accessoriesName = @"操纵杆中继 1106617300002 欧曼奇兵";/**<配件名称*/
    info.twoCode = @"http://90005171.qpyun.cn/weidian/Product/Detail?id=2683678";/**<二维码*/
    
    _imageView = [[YGMosaicImageView alloc] initWithFrame:CGRectMake(10, 10, CGRectGetWidth(backView.frame)-20, 0)];
    [_imageView setContentViewWithInfo:info];
    [backView addSubview:_imageView];
    
    // Do any additional setup after loading the view.
}

- (void)rightBtnClick {
    [_imageView savePhoto];
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
