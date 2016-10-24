//
//  YGSetPropertyView.m
//  我的轮子
//
//  Created by zccl2 on 16/10/10.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import "YGSetPropertyView.h"
#import "YGTool.h"

static NSInteger const Intrale = 6;
static NSInteger const setButtonWidth = 25;
static NSInteger const LblHeight = 25;
static NSInteger const LblWidth = 40;
static NSInteger const TextFont = 13;

#define VERSION_IS_IOS8 ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)

@implementation YGSetPropertyView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, LblHeight)];
        [self addSubview:_topView];
        
//        _setButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _setButton.frame = CGRectMake(Intrale, Intrale/2, setButtonWidth, setButtonWidth);
//        _setButton.backgroundColor = [UIColor lightGrayColor];
//        [_topView addSubview:_setButton];
        
        _deleteButton = [YGMyButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.frame = CGRectMake(self.frame.size.width-2*Intrale-3*setButtonWidth, Intrale/2, setButtonWidth, setButtonWidth);
        _deleteButton.backgroundColor = [UIColor lightGrayColor];
        [_deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_deleteButton setTitle:@"删" forState:UIControlStateNormal];
        [_topView addSubview:_deleteButton];
        
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmButton.frame = CGRectMake(self.frame.size.width-Intrale-2*setButtonWidth, Intrale/2, 2*setButtonWidth, setButtonWidth);
        _confirmButton.backgroundColor = [UIColor orangeColor];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmButton setTitle:@"确认" forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:TextFont+1];
        [_topView addSubview:_confirmButton];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, setButtonWidth+Intrale, self.frame.size.width, 1)];
        line.backgroundColor = RGBCOLOR(233, 233, 233);
        [_topView addSubview:line];
    }
    return self;
}

- (CGFloat)addContentVieWithTag:(NSInteger)tag {
    self.tag = tag;
    for(UIView *view in [self subviews])
    {
        if (view != _topView) {
            [view removeFromSuperview];
        }
    }
    if (tag == 5) {
       return [self addPlainTextField];
    } else if (tag == 1) {
       return [self addLineMessageField];
    } else if (tag == 2) {
       return [self addHoleMessageField];
    } else if (tag == 3) {
       return [self addToothField];
    } else if (tag == 4) {
       return [self addVoltageField];
    }
    return LblHeight+20;
}


- (CGFloat)addPlainTextField {
    _plainTextField = [[UITextField alloc] initWithFrame:CGRectMake(Intrale, CGRectGetMaxY(_deleteButton.frame)+2*Intrale, self.frame.size.width-2*Intrale, LblHeight)];
    _plainTextField.borderStyle = UITextBorderStyleRoundedRect;
    _plainTextField.placeholder = @"请输入文字";
    [self addSubview:_plainTextField];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, LblHeight, LblHeight);
    button.backgroundColor = [UIColor lightGrayColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"加" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(plainTextFieldRightButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    _plainTextField.rightView = button;
    _plainTextField.rightViewMode = UITextFieldViewModeAlways;
    return CGRectGetMaxY(_plainTextField.frame)+Intrale;
}

- (void)plainTextFieldRightButtonPress:(UIButton *)send {
    if (CGRectGetMaxY(self.frame)<ScreenHeight-64-70) {
        return;
    }
    if (!send.selected) {
        send.selected = YES;
        if (!_textOptionsView) {
            _textOptionsView = [[YGSetPropertyTextOptionsView alloc] initWithFrame:CGRectMake(ScreenWidth-80-Intrale, ScreenHeight-CGRectGetMaxY(_plainTextField.frame)-2*Intrale-390, 80, 390)];
            __weak typeof(self) vc = self;
            _textOptionsView.cellPress = ^(NSString *text){
                vc.plainTextField.text = [vc.plainTextField.text stringByAppendingString:text];
                if (vc.fieldButtonPress) {
                    vc.fieldButtonPress();
                }
            };
        }
        [self.window addSubview:_textOptionsView];
    } else {
        send.selected = NO;
        [_textOptionsView removeFromSuperview];
    }
}

- (CGFloat)addLineMessageField {
    [self addLeftLbl];
    _identificationField = [[UITextField alloc] initWithFrame:CGRectMake(LblWidth+2*Intrale, 2*Intrale+setButtonWidth, (self.frame.size.width-LblWidth-3*Intrale)/2, LblHeight)];
    _identificationField.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:_identificationField];
    
    _valueField1 = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(_identificationField.frame), CGRectGetMaxY(_identificationField.frame)+Intrale, (self.frame.size.width-2*LblWidth-5*Intrale)/3, LblHeight)];
    _valueField1.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:_valueField1];
    _valueField1.rightView = [self setFieldRightView];
    _valueField1.rightViewMode = UITextFieldViewModeAlways;
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0, 0, CGRectGetWidth(_valueField1.frame), CGRectGetHeight(_valueField1.frame));
    button1.tag = 1;
    [button1 addTarget:self action:@selector(pushPickerViewWith:) forControlEvents:UIControlEventTouchUpInside];
    [_valueField1 addSubview:button1];
    
    _valueField2 = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_valueField1.frame)+Intrale, CGRectGetMaxY(_identificationField.frame)+Intrale, (self.frame.size.width-2*LblWidth-5*Intrale)/3, LblHeight)];
    _valueField2.borderStyle = UITextBorderStyleRoundedRect;
    _valueField2.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:_valueField2];
    
    _valueField3 = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_valueField2.frame)+Intrale, CGRectGetMaxY(_identificationField.frame)+Intrale, (self.frame.size.width-2*LblWidth-5*Intrale)/3, LblHeight)];
    _valueField3.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:_valueField3];
    _valueField3.rightView = [self setFieldRightView];
    _valueField3.rightViewMode = UITextFieldViewModeAlways;
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(0, 0, CGRectGetWidth(_valueField3.frame), CGRectGetHeight(_valueField3.frame));
    button3.tag = 2;
    [button3 addTarget:self action:@selector(pushPickerViewWith:) forControlEvents:UIControlEventTouchUpInside];
    [_valueField3 addSubview:button3];
    
    _customField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(_identificationField.frame), CGRectGetMaxY(_valueField1.frame)+Intrale, self.frame.size.width-LblWidth-3*Intrale, LblHeight)];
    _customField.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:_customField];
    return CGRectGetMaxY(_customField.frame)+Intrale;
}

- (void)addLeftLbl {
    NSArray *array = @[@"标识",@"值",@"自定义"];
    for (int i=0; i<array.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(Intrale, 2*Intrale+setButtonWidth+i*(LblHeight+Intrale), LblWidth, LblHeight)];
        label.font = [UIFont systemFontOfSize:TextFont];
        label.text = array[i];
        label.adjustsFontSizeToFitWidth = YES;
        [self addSubview:label];
    }
}

- (CGFloat)addHoleMessageField {
    [self addHoleLeftLbl];
    _holeIdentificationField = [[UITextField alloc] initWithFrame:CGRectMake(LblWidth+2*Intrale, 2*Intrale+setButtonWidth, (self.frame.size.width-LblWidth-3*Intrale)/2, LblHeight)];
    _holeIdentificationField.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:_holeIdentificationField];
    
    _holeStyleField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_holeIdentificationField.frame)+2*Intrale+LblWidth, 2*Intrale+setButtonWidth,(self.frame.size.width-CGRectGetWidth(_holeIdentificationField.frame)-2*LblWidth-5*Intrale), LblHeight)];
    _holeStyleField.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:_holeStyleField];
    _holeStyleField.rightView = [self setFieldRightView];
    _holeStyleField.rightViewMode = UITextFieldViewModeAlways;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, CGRectGetWidth(_holeStyleField.frame), CGRectGetHeight(_holeStyleField.frame));
    button.tag = 3;
    [button addTarget:self action:@selector(pushPickerViewWith:) forControlEvents:UIControlEventTouchUpInside];
    [_holeStyleField addSubview:button];
    
    _holeNumberField = [[UITextField alloc] initWithFrame:CGRectMake(LblWidth+2*Intrale, CGRectGetMaxY(_holeIdentificationField.frame)+Intrale, (self.frame.size.width-LblWidth-3*Intrale)/3, LblHeight)];
    _holeNumberField.borderStyle = UITextBorderStyleRoundedRect;
    _holeNumberField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:_holeNumberField];
    
    _holeDiameterField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_holeIdentificationField.frame)+2*Intrale+LblWidth, CGRectGetMaxY(_holeIdentificationField.frame)+Intrale,(self.frame.size.width-CGRectGetWidth(_holeIdentificationField.frame)-2*LblWidth-5*Intrale), LblHeight)];
    _holeDiameterField.borderStyle = UITextBorderStyleRoundedRect;
    _holeDiameterField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:_holeDiameterField];
    [self addFieldRightLbl:_holeDiameterField];
    
    _customField = [[UITextField alloc] initWithFrame:CGRectMake(LblWidth+2*Intrale, CGRectGetMaxY(_holeDiameterField.frame)+Intrale, self.frame.size.width-LblWidth-3*Intrale, LblHeight)];
    _customField.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:_customField];
    return CGRectGetMaxY(_customField.frame)+Intrale;
}

- (void)addHoleLeftLbl {
    NSArray *array = @[@"孔标识",@"样式",@"孔数",@"直径",@"自定义"];
    int row = 0;
    int column = 0;
    for (int i=0; i<array.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(Intrale+((self.frame.size.width-LblWidth-3*Intrale)/2+LblWidth+2*Intrale)*column, 2*Intrale+setButtonWidth+row*(LblHeight+Intrale), LblWidth, LblHeight)];
        label.font = [UIFont systemFontOfSize:TextFont];
        label.text = array[i];
        label.adjustsFontSizeToFitWidth = YES;
        [self addSubview:label];
        if (column == 1) {
            row++;
            column = 0;
        } else {
            column ++;
        }
    }
}

- (CGFloat)addToothField {
    [self addToothLeftLbl];
    _toothIdentificationField = [[UITextField alloc] initWithFrame:CGRectMake(LblWidth+2*Intrale, 2*Intrale+setButtonWidth, (self.frame.size.width-LblWidth-3*Intrale)/2, LblHeight)];
    _toothIdentificationField.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:_toothIdentificationField];
    
    _toothNumberField = [[UITextField alloc] initWithFrame:CGRectMake(LblWidth+2*Intrale, CGRectGetMaxY(_toothIdentificationField.frame)+Intrale, (self.frame.size.width-LblWidth-3*Intrale)/3, LblHeight)];
    _toothNumberField.borderStyle = UITextBorderStyleRoundedRect;
    _toothNumberField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:_toothNumberField];
    
    _toothDiameterField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_toothIdentificationField.frame)+2*Intrale+LblWidth, CGRectGetMaxY(_toothIdentificationField.frame)+Intrale, (self.frame.size.width-LblWidth-3*Intrale)/3, LblHeight)];
    _toothDiameterField.borderStyle = UITextBorderStyleRoundedRect;
    _toothDiameterField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:_toothDiameterField];
    [self addFieldRightLbl:_toothDiameterField];
    
    _toothThickField = [[UITextField alloc] initWithFrame:CGRectMake(LblWidth+2*Intrale, CGRectGetMaxY(_toothNumberField.frame)+Intrale, (self.frame.size.width-LblWidth-3*Intrale)/3, LblHeight)];
    _toothThickField.borderStyle = UITextBorderStyleRoundedRect;
    _toothThickField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:_toothThickField];
    [self addFieldRightLbl:_toothThickField];
    
    _toothStyleField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_toothIdentificationField.frame)+2*Intrale+LblWidth, CGRectGetMaxY(_toothNumberField.frame)+Intrale, (self.frame.size.width-LblWidth-3*Intrale)/3, LblHeight)];
    _toothStyleField.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:_toothStyleField];
    _toothStyleField.rightView = [self setFieldRightView];
    _toothStyleField.rightViewMode = UITextFieldViewModeAlways;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, CGRectGetWidth(_toothStyleField.frame), CGRectGetHeight(_toothStyleField.frame));
    button.tag = 4;
    [button addTarget:self action:@selector(pushPickerViewWith:) forControlEvents:UIControlEventTouchUpInside];
    [_toothStyleField addSubview:button];
    
    _customField = [[UITextField alloc] initWithFrame:CGRectMake(LblWidth+2*Intrale, CGRectGetMaxY(_toothStyleField.frame)+Intrale, self.frame.size.width-LblWidth-3*Intrale, LblHeight)];
    _customField.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:_customField];
    return CGRectGetMaxY(_customField.frame)+Intrale;
}

- (void)addToothLeftLbl {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(Intrale, 2*Intrale+setButtonWidth, LblWidth, LblHeight)];
    label.font = [UIFont systemFontOfSize:TextFont];
    label.text = @"齿标识";
    [self addSubview:label];
    label.adjustsFontSizeToFitWidth = YES;
    NSArray *array = @[@"齿数",@"齿径",@"齿厚",@"齿样式",@"自定义"];
    int row = 0;
    int column = 0;
    for (int i=0; i<array.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(Intrale+((self.frame.size.width-LblWidth-3*Intrale)/2+LblWidth+2*Intrale)*column, 3*Intrale+setButtonWidth+LblHeight+row*(LblHeight+Intrale), LblWidth, LblHeight)];
        label.font = [UIFont systemFontOfSize:TextFont];
        label.text = array[i];
        [self addSubview:label];
        label.adjustsFontSizeToFitWidth = YES;
        if (column == 1) {
            row++;
            column = 0;
        } else {
            column ++;
        }
    }
}

- (CGFloat)addVoltageField {
    [self addVoltageLeftLbl];
    _voltageField = [[UITextField alloc] initWithFrame:CGRectMake(LblWidth+2*Intrale, 2*Intrale+setButtonWidth, (self.frame.size.width-LblWidth-3*Intrale)/3, LblHeight)];
    _voltageField.borderStyle = UITextBorderStyleRoundedRect;
    _voltageField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:_voltageField];
    
    _currentField = [[UITextField alloc] initWithFrame:CGRectMake((self.frame.size.width-LblWidth-3*Intrale)/2+3*Intrale+2*LblWidth, 2*Intrale+setButtonWidth,(self.frame.size.width-(self.frame.size.width-LblWidth-3*Intrale)/2-2*LblWidth-5*Intrale), LblHeight)];
    _currentField.borderStyle = UITextBorderStyleRoundedRect;
    _currentField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:_currentField];
    
    _powerField = [[UITextField alloc] initWithFrame:CGRectMake(LblWidth+2*Intrale, CGRectGetMaxY(_currentField.frame)+Intrale, (self.frame.size.width-LblWidth-3*Intrale)/3, LblHeight)];
    _powerField.borderStyle = UITextBorderStyleRoundedRect;
    _powerField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:_powerField];
    
    _customField = [[UITextField alloc] initWithFrame:CGRectMake(LblWidth+2*Intrale, CGRectGetMaxY(_powerField.frame)+Intrale, self.frame.size.width-LblWidth-3*Intrale, LblHeight)];
    _customField.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:_customField];
    return CGRectGetMaxY(_customField.frame)+Intrale;
}

- (void)addVoltageLeftLbl {
    NSArray *array = @[@"电压[V]",@"电流[A]",@"功率[W]"];
    int row = 0;
    int column = 0;
    for (int i=0; i<array.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(Intrale+((self.frame.size.width-LblWidth-3*Intrale)/2+LblWidth+2*Intrale)*column, 2*Intrale+setButtonWidth+row*(LblHeight+Intrale), LblWidth, LblHeight)];
        label.font = [UIFont systemFontOfSize:TextFont];
        label.text = array[i];
        [self addSubview:label];
        label.adjustsFontSizeToFitWidth = YES;
        if (column == 1) {
            row++;
            column = 0;
        } else {
            column ++;
        }
    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(Intrale, 2*Intrale+setButtonWidth+2*(LblHeight+Intrale), LblWidth, LblHeight)];
    label.font = [UIFont systemFontOfSize:TextFont];
    label.text = @"自定义";
    [self addSubview:label];
    label.adjustsFontSizeToFitWidth = YES;
}

- (UIView *)setFieldRightView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, LblHeight)];
    view.userInteractionEnabled = NO;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 10)];
    imageView.image = [UIImage imageNamed:@"下拉箭头"];
    imageView.center = view.center;
    [view addSubview:imageView];
    return view;
}

- (void)addFieldRightLbl:(UITextField *)field {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, LblHeight)];
    label.font = [UIFont systemFontOfSize:TextFont];
    label.text = @"mm";
    field.rightView = label;
    field.rightViewMode = UITextFieldViewModeAlways;
}

- (void)setFieldInitialTextWithInfo:(YGSetPropertyInfo *)info {
    _identificationField.text = info.identification?:@"";
    _valueField1.text = info.type?:@"长度L";
    _valueField2.text = info.number?:@"";
    _valueField3.text = info.unit?:@"mm";
    _customField.text = info.custom?:@"";
    
    _plainTextField.text = info.plainText;
    
    _holeIdentificationField.text = info.holeIdentification;
    _holeStyleField.text = info.holeStyle?:HoleStyleArray[0];
    _holeNumberField.text = info.holeNumber?:@"";
    _holeDiameterField.text = info.holeDiameter?:@"";
    
    _toothIdentificationField.text = info.toothIdentification?:@"";
    _toothNumberField.text = info.toothNumber?:@"";
    _toothDiameterField.text = info.toothDiameter?:@"";
    _toothThickField.text = info.toothThick?:@"";
    _toothStyleField.text = info.toothStyle?:@"";
    
    _voltageField.text = info.voltage;
    _currentField.text = info.current;
    _powerField.text = info.power;
}

- (void)pushPickerViewWith:(UIButton *)send {
    if (send.tag == 1) {
        _chooseStr = TypeArray[0];
    } else if (send.tag == 2) {
        _chooseStr = UnitArray[0];
    } else if (send.tag == 3) {
        _chooseStr = HoleStyleArray[0];
    } else if (send.tag == 4) {
        _chooseStr = ToothStyleArray[0];
    }
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width-20, 180)];
    pickerView.showsSelectionIndicator = YES;
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.tag = send.tag;
    [self buildActionSheetWithView:pickerView tag:send.tag];
}

- (void)buildActionSheetWithView:(UIView *)view tag:(NSInteger)tag{
    if(VERSION_IS_IOS8)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n"  message:nil  preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"  style:UIAlertActionStyleCancel  handler:^(UIAlertAction *action) {
        }];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"选择"  style:UIAlertActionStyleDefault  handler:^(UIAlertAction *action) {
            if (tag == 1) {
                _valueField1.text = _chooseStr;
            } else if (tag == 2) {
                _valueField3.text = _chooseStr;
            } else if (tag == 3) {
                _holeStyleField.text = _chooseStr;
            } else if (tag == 4) {
                _toothStyleField.text = _chooseStr;
            }
            if (_fieldButtonPress) {
                _fieldButtonPress();
            }
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:otherAction];
        [alertController.view addSubview:view];
        [[self viewController] presentViewController:alertController animated:YES completion:nil];
    }else
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"选择", nil];
        actionSheet.tag = tag;
        [actionSheet addSubview:view];
        [actionSheet showInView:self];
    }
    
}

/**< 获取当前的vc*/
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        if (actionSheet.tag == 1) {
            _valueField1.text = _chooseStr;
        } else if (actionSheet.tag == 2) {
            _valueField3.text = _chooseStr;
        } else if (actionSheet.tag == 3) {
            _holeStyleField.text = _chooseStr;
        } else if (actionSheet.tag == 4) {
            _toothStyleField.text = _chooseStr;
        }
        if (_fieldButtonPress) {
            _fieldButtonPress();
        }
    }
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView.tag == 1) {
        return TypeArray.count;
    } else if (pickerView.tag == 2) {
        return UnitArray.count;
    } else if (pickerView.tag == 3) {
        return HoleStyleArray.count;
    } else if (pickerView.tag == 4) {
        return ToothStyleArray.count;
    }
    return 0;
}


-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView.tag == 1) {
        return TypeArray[row];
    } else if (pickerView.tag == 2) {
        return UnitArray[row];
    } else if (pickerView.tag == 3) {
        return HoleStyleArray[row];
    } else if (pickerView.tag == 4) {
        return ToothStyleArray[row];
    }
    return @"";
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView.tag == 1) {
        _chooseStr = TypeArray[row];
    } else if (pickerView.tag == 2) {
        _chooseStr = UnitArray[row];
    } else if (pickerView.tag == 3) {
        _chooseStr = HoleStyleArray[row];
    } else if (pickerView.tag == 4) {
        _chooseStr = ToothStyleArray[row];
    }
}

@end
