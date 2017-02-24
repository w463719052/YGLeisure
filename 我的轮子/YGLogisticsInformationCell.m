//
//  YGLogisticsInformationCell.m
//  qpy
//
//  Created by zccl2 on 16/7/5.
//  Copyright © 2016年 dcf. All rights reserved.
//

#import "YGLogisticsInformationCell.h"
#import "YGHeader.h"

@interface YGLogisticsInformationCell ()
{
    UIImageView *_commodityImageView;/**< 商品图片*/
    UILabel *_stateLbl;/**< 状态Lbl*/
    UILabel *_expressCompleLbl;/**< 承运公司*/
    UILabel *_doconLbl;/**< 运单编号*/
    UILabel *_telePhoneLbl;/**< 官方电话*/
}
@end

static NSInteger const intrale = 15;
static NSInteger const imageWidth = 70;

@implementation YGLogisticsInformationCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addContentView];
    }
    return self;
}

- (void)addContentView {
    _commodityImageView = [[UIImageView alloc] initWithFrame:CGRectMake(intrale, intrale, imageWidth, imageWidth)];
    _commodityImageView.layer.cornerRadius = 5;
    _commodityImageView.layer.masksToBounds = YES;
    [self addSubview:_commodityImageView];
    [self addTitleLabelWithTop:intrale text:@"物流状态："];
    [self addTitleLabelWithTop:intrale+(imageWidth/4) text:@"承运公司："];
    [self addTitleLabelWithTop:intrale+2*(imageWidth/4) text:@"运单编号："];
    [self addTitleLabelWithTop:intrale+3*(imageWidth/4) text:@"官方电话："];
    
    _stateLbl = [[UILabel alloc] init];
    _expressCompleLbl = [[UILabel alloc] init];
    _doconLbl = [[UILabel alloc] init];
    _telePhoneLbl = [[UILabel alloc] init];
    [self addTitleLabelWithLabel:_stateLbl top:intrale textColor:[UIColor greenColor]];
    [self addTitleLabelWithLabel:_expressCompleLbl top:intrale+(imageWidth/4) textColor:[UIColor darkGrayColor]];
    [self addTitleLabelWithLabel:_doconLbl top:intrale+2*(imageWidth/4) textColor:[UIColor darkGrayColor]];
    [self addTitleLabelWithLabel:_telePhoneLbl top:intrale+3*(imageWidth/4) textColor:[UIColor blueColor]];
}

- (void)addTitleLabelWithTop:(NSInteger)top text:(NSString *)text{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_commodityImageView.frame)+intrale, top, imageWidth-5, imageWidth/4)];
    label.textColor = [UIColor darkGrayColor];
    label.font = [UIFont systemFontOfSize:12];
    label.text = text;
    [self addSubview:label];
}

- (void)addTitleLabelWithLabel:(UILabel *)label top:(NSInteger)top textColor:(UIColor *)color{
    label.frame = CGRectMake(CGRectGetMaxX(_commodityImageView.frame)+intrale+imageWidth-5, top, ScreenWidth-CGRectGetMaxX(_commodityImageView.frame)+2*intrale+imageWidth+10, imageWidth/4);
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:12];
    [self addSubview:label];
}

- (void)setContentViewInfo:(YGLogisticsInformationInfo *)info {
    _commodityImageView.image = [UIImage imageNamed:@"macbook_pro"];
    _stateLbl.text = info.string1;
    _expressCompleLbl.text = info.string2;
    _doconLbl.text = info.string3;
    _telePhoneLbl.text = info.string4;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
