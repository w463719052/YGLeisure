//
//  YGCustomerInformationCell.h
//  我的轮子
//
//  Created by zccl2 on 16/9/5.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGCustomerInformationCell : UITableViewCell

@property (nonatomic,strong) UILabel *nameLbl;/**< 姓名*/
@property (nonatomic,strong) UILabel *mobileLbl;/**< 手机号码*/
@property (nonatomic,strong) UILabel *corporateNameLbl;/**< 公司名称*/
@property (nonatomic,strong) UILabel *addressLbl;/**< 地址*/

- (void)setContentViewInfo;

+ (CGFloat)cellHeigt;

@end
