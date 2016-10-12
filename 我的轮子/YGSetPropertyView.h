//
//  YGSetPropertyView.h
//  我的轮子
//
//  Created by zccl2 on 16/10/10.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGMyButton.h"
#import "YGDrawingLineView.h"
#import "YGSetPropertyInfo.h"

#define TypeArray @[@"长度L",@"高度h",@"宽度b",@"厚度t",@"中距a",@"弧长⌒",@"直径φ",@"盘径φ",@"牙径M"]
#define UnitArray @[@"mm",@"cm",@"m"]

@interface YGSetPropertyView : UIView <UIPickerViewDelegate,UIPickerViewDataSource,UIActionSheetDelegate>

@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) UIButton *setButton;
@property (nonatomic,strong) YGMyButton *deleteButton;
@property (nonatomic,strong) UIButton *confirmButton;

@property (nonatomic,strong) UITextField *identificationField;
@property (nonatomic,strong) UITextField *valueField1;
@property (nonatomic,strong) UITextField *valueField2;
@property (nonatomic,strong) UITextField *valueField3;
@property (nonatomic,strong) UITextField *customField;

@property (nonatomic,strong) UITextField *plainTextField;
@property (nonatomic,strong) UITextField *holeIdentificationField;
@property (nonatomic,strong) UITextField *holeStyleField;
@property (nonatomic,strong) UITextField *holeNumberField;
@property (nonatomic,strong) UITextField *holeDiameterField;

@property (nonatomic,strong) UITextField *toothIdentificationField;
@property (nonatomic,strong) UITextField *toothNumberField;
@property (nonatomic,strong) UITextField *toothDiameterField;
@property (nonatomic,strong) UITextField *toothThickField;
@property (nonatomic,strong) UITextField *toothStyleField;

@property (nonatomic,strong) UITextField *voltageField;
@property (nonatomic,strong) UITextField *currentField;
@property (nonatomic,strong) UITextField *powerField;


@property (nonatomic,copy) NSString *chooseStr;

@property (nonatomic,strong) YGDrawingLineView *lineView;

@property (nonatomic, copy) void (^fieldButtonPress)();

- (CGFloat)addContentVieWithTag:(NSInteger)tag;
- (void)setFieldInitialTextWithInfo:(YGSetPropertyInfo *)info;

@end
