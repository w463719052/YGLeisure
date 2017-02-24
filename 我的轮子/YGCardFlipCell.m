//
//  YGCardFlipCell.m
//  我的轮子
//
//  Created by zccl2 on 16/11/25.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import "YGCardFlipCell.h"
#import "YGHeader.h"

static NSInteger const Intrale = 20;

@implementation YGCardFlipCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addContentView];
    }
    return self;
}

- (void)addContentView {
    _myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(Intrale, Intrale, ScreenWidth-2*Intrale, (ScreenWidth-2*Intrale)*1.2)];
    _myImageView.layer.cornerRadius = 6;
    _myImageView.layer.masksToBounds = YES;
    _myImageView.layer.shadowOpacity = 3;
    [self addSubview:_myImageView];
    _myImageView.image = [UIImage imageNamed:@"image1"];
}

//- (void)setContentViewInfo:(<#info#> *)info {
//    
//}

+ (CGFloat)cellHeigt {
    return (ScreenWidth-2*Intrale)*1.2+2*Intrale;
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
