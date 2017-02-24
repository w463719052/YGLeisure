//
//  YGPrintingSetingView.m
//  我的轮子
//
//  Created by zccl2 on 17/2/23.
//  Copyright © 2017年 com.zccl. All rights reserved.
//

#import "YGPrintingSetingView.h"
#import "YGTool.h"

static const NSInteger Intrale = 10;
static const NSInteger LblWidth = 70;
static const NSInteger FieldHeight = 35;

@implementation YGPrintingSetingView

static id _instance;

+ (instancetype)buildInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

-(instancetype)init {
    if (self=[super init]) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-64);
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-4*Intrale, (ScreenWidth-4*Intrale)*0.5)];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 5;
        [self addSubview:_backView];
        NSArray *lblArray = @[@"标签宽度",@"标签高度",@"列数",@"打印次数"];
        for (int i=0; i<lblArray.count; i++) {
            UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(2*Intrale, 2*Intrale+(FieldHeight+Intrale)*i, LblWidth, FieldHeight)];
            lbl.text = lblArray[i];
            [_backView addSubview:lbl];
            
            UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lbl.frame)+Intrale, CGRectGetMinY(lbl.frame), CGRectGetWidth(_backView.frame)-5*Intrale-LblWidth, FieldHeight)];
            field.borderStyle = UITextBorderStyleRoundedRect;
            field.keyboardType = UIKeyboardTypeNumberPad;
            [_backView addSubview:field];
            switch (i) {
                case 0:
                    _widthField = field;
                    _widthField.text = @"80";
                    break;
                case 1:
                    _heightField = field;
                    _heightField.text = @"30";
                    break;
                case 2:
                    _columnField = field;
                    _columnField.text = @"1";
                    break;
                case 3:
                    _numberField = field;
                    _numberField.text = @"1";
                    break;
                default:
                    break;
            }
        }
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(2*Intrale, 2.5*Intrale+(FieldHeight+Intrale)*lblArray.count, CGRectGetWidth(_backView.frame)-4*Intrale, FieldHeight+Intrale/2);
        button.backgroundColor = [UIColor blueColor];
        button.layer.cornerRadius = 5;
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(removeFromSuperview) forControlEvents:UIControlEventTouchUpInside];
        [_backView addSubview:button];
        CGRect frame = _backView.frame;
        frame.size.height = CGRectGetMaxY(button.frame)+1.5*Intrale;
        _backView.frame = frame;
        _backView.center = self.center;
    }
    return self;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

@end
