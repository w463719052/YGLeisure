//
//  YGSuspensionPhoneFrameVC.m
//  我的轮子
//
//  Created by zccl2 on 16/7/8.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import "YGSuspensionPhoneFrameVC.h"
#import "YGHeader.h"

@interface YGSuspensionPhoneFrameVC ()
{
    NSArray *_imageArray;
}
@end

static NSInteger const INTERVAL = 50;

@implementation YGSuspensionPhoneFrameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarWithBackButton:YES];
    self.edgesForExtendedLayout = UIRectEdgeLeft | UIRectEdgeRight;
    self.title = @"图片浏览";
    self.view.backgroundColor = [UIColor whiteColor];
    [self addContentView];
}

- (void)addContentView {
    _imageArray = @[];
    for (int i = 0; i<2; i++) {
        
    }
    CALayer *sublayer2=[CALayer layer]; //初始化层
    sublayer2.frame=CGRectMake(INTERVAL+5, INTERVAL+5, ScreenWidth-2*INTERVAL, (ScreenWidth-2*INTERVAL)*1.3);//设定层的大小
    sublayer2.backgroundColor=[UIColor blackColor].CGColor;//设定层的背景色
    sublayer2.cornerRadius=10.0;//设定层的圆角效果
    sublayer2.shadowColor=[UIColor blackColor].CGColor; //设定边框的颜色
    sublayer2.shadowOffset=CGSizeMake(5, 5); //阴影的位置
    sublayer2.shadowRadius=5.0;//阴影的圆角
    sublayer2.shadowColor=[UIColor blackColor].CGColor; //阴影的颜色
    sublayer2.shadowOpacity=0.5;//阴影的透明度
    [self.view.layer addSublayer:sublayer2];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(INTERVAL+5, INTERVAL+5, ScreenWidth-2*INTERVAL, (ScreenWidth-2*INTERVAL)*1.3)];
    imageView2.backgroundColor = [UIColor blackColor];
    imageView2.layer.cornerRadius=10;
//    imageView2.layer.shadowColor=[UIColor grayColor].CGColor;
//    imageView2.layer.shadowOffset=CGSizeMake(10, 10);
//    imageView2.layer.shadowOpacity=0.5;
//    imageView2.layer.shadowRadius=5;
    imageView2.contentMode = UIViewContentModeScaleAspectFill;
    imageView2.image = [UIImage imageNamed:@"image1"];
    imageView2.layer.masksToBounds = YES;
    [self.view addSubview:imageView2];
    
//    CALayer*imageLayer=[CALayer layer];
//    imageLayer.frame=sublayer.bounds;
//    imageLayer.cornerRadius=10.0;
//    imageLayer.contents=(id)[UIImage imageNamed:@"image1"].CGImage;
//    imageLayer.masksToBounds=YES;
//    [sublayer addSublayer:imageLayer];
    CALayer *sublayer=[CALayer layer]; //初始化层
    sublayer.frame=CGRectMake(INTERVAL, INTERVAL, ScreenWidth-2*INTERVAL, (ScreenWidth-2*INTERVAL)*1.3);//设定层的大小
    sublayer.backgroundColor=[UIColor blackColor].CGColor;//设定层的背景色
    sublayer.cornerRadius=10.0;//设定层的圆角效果
    sublayer.shadowColor=[UIColor blackColor].CGColor; //设定边框的颜色
    sublayer.shadowOffset=CGSizeMake(15, 15); //阴影的位置
    sublayer.shadowRadius=5.0;//阴影的圆角
    sublayer.shadowColor=[UIColor blackColor].CGColor; //阴影的颜色
    sublayer.shadowOpacity=0.5;//阴影的透明度
    [self.view.layer addSublayer:sublayer];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(INTERVAL, INTERVAL, ScreenWidth-2*INTERVAL, (ScreenWidth-2*INTERVAL)*1.3)];
    imageView.backgroundColor = [UIColor blackColor];
    imageView.layer.cornerRadius=10;
//    imageView.layer.shadowColor=[UIColor grayColor].CGColor;
//    imageView.layer.shadowOffset=CGSizeMake(10, 10);
//    imageView.layer.shadowOpacity=0.5;
//    imageView.layer.shadowRadius=5;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image = [UIImage imageNamed:@"image2"];
    imageView.layer.masksToBounds = YES;
    [self.view addSubview:imageView];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(INTERVAL-5, INTERVAL-5, ScreenWidth-2*INTERVAL, (ScreenWidth-2*INTERVAL)*1.3)];
    imageView1.backgroundColor = [UIColor blackColor];
    imageView1.layer.cornerRadius=10;
//    imageView1.layer.shadowColor=[UIColor grayColor].CGColor;
//    imageView1.layer.shadowOffset=CGSizeMake(10, 10);
//    imageView1.layer.shadowOpacity=0.5;
//    imageView1.layer.shadowRadius=5;
    imageView1.contentMode = UIViewContentModeScaleAspectFill;
    imageView1.image = [UIImage imageNamed:@"image3"];
    imageView1.layer.masksToBounds = YES;
    [self.view addSubview:imageView1];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
