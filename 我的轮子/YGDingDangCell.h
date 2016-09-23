//
//  YGDingDangCell.h
//  我的轮子
//
//  Created by zccl2 on 16/9/2.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGDingDangCell : UITableViewCell

@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UIImageView *logoImageView;
@property (nonatomic,strong) UILabel *stataLbl;
@property (nonatomic,strong) UILabel *stataLbl1;
@property (nonatomic,strong) UILabel *lbl1;
@property (nonatomic,strong) UILabel *lbl2;
@property (nonatomic,strong) UILabel *lbl3;
@property (nonatomic,strong) UIView *view1;
@property (nonatomic,strong) UIView *view2;
@property (nonatomic,strong) UIView *view3;

+ (CGFloat)cellHeigt;

@end
