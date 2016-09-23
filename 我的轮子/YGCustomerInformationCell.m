//
//  YGCustomerInformationCell.m
//  我的轮子
//
//  Created by zccl2 on 16/9/5.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import "YGCustomerInformationCell.h"
#import "YGHeader.h"

static NSInteger const Intrale = 10;
static NSInteger const LblHeight = 30;

@implementation YGCustomerInformationCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addContentView];
    }
    return self;
}

- (void)addContentView {
    _nameLbl = [[UILabel alloc] init];
    _mobileLbl = [[UILabel alloc] init];
    _corporateNameLbl = [[UILabel alloc] init];
    
    [self addLbl:_nameLbl x:0];
    [self addLbl:_mobileLbl x:ScreenWidth/3];
    [self addLbl:_corporateNameLbl x:2*ScreenWidth/3];
    
    UIView *layer = [[UIView alloc] initWithFrame:CGRectMake(3*Intrale, LblHeight,ScreenWidth-6*Intrale , 1)];
    layer.backgroundColor = RGBCOLOR(233, 233, 233);
    [self addSubview:layer];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(Intrale, LblHeight+Intrale, Intrale, Intrale)];
    imageView.image = [UIImage imageNamed:@"macbook_pro"];
    [self addSubview:imageView];
    
    _addressLbl = [[UILabel alloc] initWithFrame:CGRectMake(3*Intrale, LblHeight, ScreenWidth-3*Intrale, LblHeight)];
    _addressLbl.font = [UIFont systemFontOfSize:12];
    _addressLbl.textColor = [UIColor darkGrayColor];
    [self addSubview:_addressLbl];
}

- (void)addLbl:(UILabel *)lbl x:(CGFloat)x {
    lbl.frame = CGRectMake(x, 0, ScreenWidth/3, LblHeight);
    lbl.font = [UIFont systemFontOfSize:12];
    lbl.textColor = [UIColor darkGrayColor];
    lbl.textAlignment = NSTextAlignmentCenter;
    [self addSubview:lbl];
}

- (void)setContentViewInfo {
    _nameLbl.text = @"蔡先生";
    _mobileLbl.text = @"18865542467";
    _corporateNameLbl.text = @"福建腾飞汽配";
    _addressLbl.text = @"厦门市软件园思明区观日路52号203单元";
}

+ (CGFloat)cellHeigt {
    return 2*LblHeight;
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
