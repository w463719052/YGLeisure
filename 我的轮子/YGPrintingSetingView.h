//
//  YGPrintingSetingView.h
//  我的轮子
//
//  Created by zccl2 on 17/2/23.
//  Copyright © 2017年 com.zccl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGPrintingSetingView : UIView

@property (nonatomic,strong) UIView *backView;/**< 弹窗*/

@property (nonatomic,strong) UITextField *widthField;/**< 宽*/
@property (nonatomic,strong) UITextField *heightField;/**< 高*/
@property (nonatomic,strong) UITextField *columnField;/**< 列*/
@property (nonatomic,strong) UITextField *numberField;/**< 打印次数*/

+ (instancetype)buildInstance;

@end
