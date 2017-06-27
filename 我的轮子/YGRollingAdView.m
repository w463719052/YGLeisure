//
//  YGRollingAdView.m
//  qpy
//
//  Created by zccl2 on 16/12/7.
//  Copyright © 2016年 dcf. All rights reserved.
//

#import "YGRollingAdView.h"
#import "UIImageView+WebCache.h"
#import "YGTool.h"

@interface YGRollingAdView ()
{
    UIImageView *_leftView;
    UIImageView *_centreView;
    UIImageView *_rightView;
}

@end


@implementation YGRollingAdView

- (void)startTimer {
    [_timer setFireDate:[NSDate distantPast]];
}
- (void)stopTimer{
    [_timer setFireDate:[NSDate distantFuture]];
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        _rollPictureArray = @[[UIImage new],[UIImage new],[UIImage new]];
        UIScrollView *mainPageTopScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        mainPageTopScrollView.delegate=self;
        mainPageTopScrollView.pagingEnabled=YES;
        mainPageTopScrollView.showsHorizontalScrollIndicator=NO;
        mainPageTopScrollView.showsVerticalScrollIndicator=NO;
        mainPageTopScrollView.bounces=NO;
        [self addSubview:mainPageTopScrollView];
        self.mainPageTopScrollView=mainPageTopScrollView;
        
        for (int i=0; i<3; i++) {
            UIImageView *rollPictureImg=[[UIImageView alloc]init];
            rollPictureImg.contentMode = UIViewContentModeScaleAspectFill;
            rollPictureImg.layer.masksToBounds = YES;
            rollPictureImg.frame=CGRectMake(frame.size.width*i, 0, frame.size.width, frame.size.height);
            rollPictureImg.userInteractionEnabled = YES;
            [self.mainPageTopScrollView addSubview:rollPictureImg];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            [rollPictureImg addGestureRecognizer:tap];
            if (i==0) {
                _leftView = rollPictureImg;
            } else if (i==1) {
                _centreView = rollPictureImg;
            } else if (i==2) {
                _rightView = rollPictureImg;
            }
        }
        self.mainPageTopScrollView.contentOffset=CGPointMake(frame.size.width, 0);
        self.mainPageTopScrollView.contentSize=CGSizeMake(frame.size.width*3, frame.size.height);
    }
    return self;
}
#pragma mark 设置轮播图数组
- (void)setRollPictureArray:(NSArray *)rollPictureArray {
    if (rollPictureArray.count>0) {
        YGRollingAdInfo *info = rollPictureArray[0];
        int time = 5;
        if ([info.times intValue]>0) {
            time = [info.times intValue];
        }
        [self.timer invalidate];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:time
                                                    target:self
                                                  selector:@selector(runtimer)
                                                  userInfo:nil
                                                   repeats:YES];
        _rollPictureArray = rollPictureArray;
        _leftView.tag = rollPictureArray.count-1;
        _centreView.tag = 0;
        _rightView.tag = 1;
        if (rollPictureArray.count == 1) {
            _rightView.tag = 0;
        }
        [self setImage];
    }
}
#pragma mark 定时器操作
-(void)runtimer{
    [self setRightScroll];
}
#pragma mark 往右方向滚动设置
- (void)setRightScroll {
    [self setRightViewTag:_leftView];
    [self setRightViewTag:_centreView];
    [self setRightViewTag:_rightView];
    [self setImage];
}
- (void)setRightViewTag:(UIImageView *)view {
    view.tag ++;
    if (view.tag == self.rollPictureArray.count) {
        view.tag = 0;
    }
}
#pragma mark 往左方向滚动设置
- (void)setLeftScroll {
    [self setLeftViewTag:_leftView];
    [self setLeftViewTag:_centreView];
    [self setLeftViewTag:_rightView];
    [self setImage];
}
- (void)setLeftViewTag:(UIImageView *)view {
    view.tag --;
    if (view.tag == -1) {
        view.tag = self.rollPictureArray.count-1;
    }
}
#pragma mark 设置3个视图对应的图片
- (void)setImage {
    YGRollingAdInfo *leftInfo = _rollPictureArray[_leftView.tag];
    YGRollingAdInfo *centreInfo = _rollPictureArray[_centreView.tag];
    YGRollingAdInfo *rightInfo = _rollPictureArray[_rightView.tag];
    if ([leftInfo isKindOfClass:[YGRollingAdInfo class]]) {
        [self setImageWithView:_leftView info:leftInfo];
    }
    if ([centreInfo isKindOfClass:[YGRollingAdInfo class]]) {
        [self setImageWithView:_centreView info:centreInfo];
    }
    if ([rightInfo isKindOfClass:[YGRollingAdInfo class]]) {
        [self setImageWithView:_rightView info:rightInfo];
    }
}
- (void)setImageWithView:(UIImageView *)view info:(YGRollingAdInfo *)info {
    if (info.image) {
        view.image = info.image;
    } else {
        [view sd_setImageWithURL:[NSURL URLWithString:info.imageurl] placeholderImage:nil];
    }
}
#pragma mark 结束滚动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat pageWidth=self.mainPageTopScrollView.frame.size.width;
    if (self.mainPageTopScrollView.contentOffset.x > pageWidth) {
        [self setRightScroll];
    } else if (self.mainPageTopScrollView.contentOffset.x < pageWidth) {
        [self setLeftScroll];
    }
    [self.mainPageTopScrollView scrollRectToVisible:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.bounds.size.height) animated:NO];
}


- (void)tapAction:(UITapGestureRecognizer *)tap
{
    YGRollingAdInfo *info = _rollPictureArray[tap.view.tag];
    if (![YGTool isBlankString:info.linkurl]) {
        //跳转到对应网页
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:info.linkurl]];
    }
}

@end
