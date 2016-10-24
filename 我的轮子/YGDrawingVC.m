//
//  YGDrawingVC.m
//  我的轮子
//
//  Created by zccl2 on 16/9/23.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

//http://121.40.41.225:6050/ass/camera/#g=1&p=图片标注

#import "YGDrawingVC.h"
#import "YGDrawingView.h"
#import "MBProgressHUD+NSString.h"

@interface YGDrawingVC ()
{
    YGDrawingView *_drawingView;
}
@end

@implementation YGDrawingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarWithBackButton:YES];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 100, 35);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [rightBtn setTitle:@"生成标注图" forState:UIControlStateNormal];
    rightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.title = @"图片标注";
    _drawingView =[[YGDrawingView alloc] init];
    [self.view addSubview:_drawingView];
    
}

- (void)buttonPress:(UIButton *)send {
    
}

- (void)rightBtnClick {
    UIGraphicsBeginImageContextWithOptions(_drawingView.imageView.frame.size, YES, [UIScreen mainScreen].scale);
    [_drawingView.imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();/**<生成图片*/
    UIGraphicsEndImageContext();
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:_drawingView.pictureImageView.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image = image;
    imageView.layer.masksToBounds = YES;
    UIGraphicsBeginImageContextWithOptions(imageView.frame.size, YES, [UIScreen mainScreen].scale);
    [imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();/**<生成图片*/
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(newImage, nil, nil, nil);
    
    [MBProgressHUD myShowTextOnly:@"保存成功" toView:self.view];
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
