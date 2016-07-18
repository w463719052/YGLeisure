//
//  YGPersonalProfileVC.m
//  我的轮子
//
//  Created by zccl2 on 16/7/15.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import "YGPersonalProfileVC.h"
#import "YGHeader.h"
#import "YGBaseMapView.h"

@interface YGPersonalProfileVC ()
{
    YGBaseMapView *_baseMapView;
    CGFloat _orginY;
}
@end

@implementation YGPersonalProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarWithBackButton:YES];
    self.edgesForExtendedLayout = UIRectEdgeLeft | UIRectEdgeRight;
    self.title = @"个人简介";
    self.view.backgroundColor = [UIColor blackColor];
    if (!_baseMapView) {
        [self addContentView];
    }
    // Do any additional setup after loading the view.
}

- (void)addContentView {
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backImageView.image = [UIImage imageNamed:@"image3"];
    backImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:backImageView];
    
    _baseMapView = [[YGBaseMapView alloc] initWithFrame:CGRectMake(20, 200, ScreenWidth-40, (ScreenWidth-40)*0.7)];
    _baseMapView.layer.cornerRadius = 5;
    [_baseMapView setConteentViewImage:@"image2" name:@"枯叶 老树" address:@"山之巅 水之源 人之乐"];
    [self.view addSubview:_baseMapView];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(penDrag:)];
    [_baseMapView addGestureRecognizer:pan];
}

- (void)penDrag:(UIPanGestureRecognizer *)send {
    CGPoint point = [send translationInView:self.view];
    if (send.state == UIGestureRecognizerStateBegan) {
        _orginY = _baseMapView.frame.origin.y;
    } else {
        if (_orginY+point.y<ScreenHeight - 64 - (ScreenWidth-40)*0.7&&_orginY+point.y>0) {
            CGRect frame = _baseMapView.frame;
            frame.origin.y = _orginY+point.y;
            [UIView animateWithDuration:0.3 animations:^{
                _baseMapView.frame = frame;
            }];
            if (_orginY+point.y < (ScreenWidth-40)*0.7/2) {
                [UIView animateWithDuration:1 animations:^{
                    if (_baseMapView.frame.origin.y-15<0) {
                        _baseMapView.frame = CGRectMake(0, 0, ScreenWidth, (ScreenWidth-40)*0.7);
                        [_baseMapView setContentViewFrame];
                    } else {
                        _baseMapView.frame = CGRectMake(20, frame.origin.y, ScreenWidth-40, (ScreenWidth-40)*0.7);
                        [_baseMapView setNewContentViewFrame];
                    }
                }];
            }
        }
    }
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
