//
//  YGBaseMapView.h
//  我的轮子
//
//  Created by zccl2 on 16/7/15.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGBaseMapView : UIView

@property (nonatomic,strong) UILabel *nameLbl;
@property (nonatomic,strong) UILabel *addressLbl;
@property (nonatomic,strong)UIImageView *headPortraitView;

- (void)setConteentViewImage:(NSString *)imageUrl name:(NSString *)name address:(NSString *)address;

- (void)setContentViewFrame;

- (void)setNewContentViewFrame;

@end
