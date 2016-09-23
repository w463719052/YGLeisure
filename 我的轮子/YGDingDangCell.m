//
//  YGDingDangCell.m
//  我的轮子
//
//  Created by zccl2 on 16/9/2.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import "YGDingDangCell.h"
#import "YGHeader.h"

static NSInteger const Intreal = 10;
static NSInteger const BackViewHeight = 160;
static NSInteger const LogoWidth = 45;
static NSInteger const CircularWidth = 8;

@implementation YGDingDangCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = RGBCOLOR(37, 37, 37);
        [self addContentView];
    }
    return self;
}

- (void)addContentView {
    _backView = [[UIView alloc] initWithFrame:CGRectMake(Intreal, Intreal, ScreenWidth-2*Intreal, BackViewHeight)];
    _backView.backgroundColor = [UIColor whiteColor];
    _backView.layer.cornerRadius = 8;
    _backView.layer.masksToBounds = YES;
    [self addSubview:_backView];
    
    _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2*Intreal, 2*Intreal, LogoWidth, LogoWidth)];
    _logoImageView.layer.cornerRadius = LogoWidth/2;
    _logoImageView.layer.masksToBounds = YES;
    _logoImageView.image = [UIImage imageNamed:@"macbook_pro"];
    [_backView addSubview:_logoImageView];
    
    _stataLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_logoImageView.frame)+Intreal, 2*Intreal, ScreenWidth-6*Intreal-LogoWidth, LogoWidth/2)];
    _stataLbl.textColor = [UIColor orangeColor];
    _stataLbl.font = [UIFont systemFontOfSize:15];
    _stataLbl.text = @"等待接单";
    [_backView addSubview:_stataLbl];
    
    _stataLbl1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_logoImageView.frame)+Intreal, CGRectGetMaxY(_stataLbl.frame), ScreenWidth-6*Intreal-LogoWidth, LogoWidth/2)];
    _stataLbl1.textColor = [UIColor darkGrayColor];
    _stataLbl1.font = [UIFont systemFontOfSize:13];
    _stataLbl1.text = @"等待商家接单";
    [_backView addSubview:_stataLbl1];
    
    UIView *backView1 = [[UIView alloc] initWithFrame:CGRectMake(0, BackViewHeight/2, ScreenWidth-2*Intreal, BackViewHeight/2)];
    backView1.backgroundColor = RGBCOLOR(243, 243, 243);
    [_backView addSubview:backView1];
    
    _lbl1 = [[UILabel alloc] init];
    _lbl2 = [[UILabel alloc] init];
    _lbl3 = [[UILabel alloc] init];
    [self addLbl:_lbl1 x:0];
    [self addLbl:_lbl2 x:ScreenWidth/3];
    [self addLbl:_lbl3 x:2*ScreenWidth/3];
    _lbl1.text = @"已经支付";
    _lbl2.text = @"等待接单";
    _lbl3.text = @"等待送达";
    
    UIView *layer = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth/6, BackViewHeight/2+9*Intreal/2+CircularWidth/2-0.5, 2*ScreenWidth/3, 1)];
    layer.backgroundColor = [UIColor grayColor];
    [_backView addSubview:layer];
    
    _view1 = [[UIView alloc] init];
    _view2 = [[UIView alloc] init];
    _view3 = [[UIView alloc] init];
    [self addView:_view1 x:ScreenWidth/6-CircularWidth/2];
    [self addView:_view2 x:ScreenWidth/2-CircularWidth/2];
    [self addView:_view3 x:5*ScreenWidth/6-CircularWidth/2];
    _view2.backgroundColor = [UIColor blueColor];
    
}

- (void)addLbl:(UILabel *)lbl x:(CGFloat)x{
    lbl.frame = CGRectMake(x, BackViewHeight/2+3*Intreal/2, ScreenWidth/3, 2*Intreal);
    lbl.font = [UIFont systemFontOfSize:12];
    lbl.textColor = [UIColor grayColor];
    lbl.textAlignment = NSTextAlignmentCenter;
    [_backView addSubview:lbl];
}

- (void)addView:(UIView *)view x:(CGFloat)x {
    view.frame =  CGRectMake(x, BackViewHeight/2+9*Intreal/2, CircularWidth, CircularWidth);
    view.backgroundColor = [UIColor grayColor];
    view.layer.cornerRadius = CircularWidth/2;
    [_backView addSubview:view];
}

+ (CGFloat)cellHeigt {
    return BackViewHeight + 2*Intreal;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
