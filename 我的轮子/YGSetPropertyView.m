//
//  YGSetPropertyView.m
//  我的轮子
//
//  Created by zccl2 on 16/10/10.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import "YGSetPropertyView.h"

static NSInteger const Intrale = 6;
static NSInteger const setButtonWidth = 25;
static NSInteger const LblHeight = 25;
static NSInteger const LblWidth = 50;
static NSInteger const TextFont = 14;

@implementation YGSetPropertyView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addContentView];
    }
    return self;
}

- (void)addContentView {
    UIButton *setButton = [UIButton buttonWithType:UIButtonTypeCustom];
    setButton.frame = CGRectMake(Intrale, Intrale/2, setButtonWidth, setButtonWidth);
    setButton.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:setButton];
    
    _deleteButton = [YGMyButton buttonWithType:UIButtonTypeCustom];
    _deleteButton.frame = CGRectMake(self.frame.size.width-2*Intrale-3*setButtonWidth, Intrale/2, setButtonWidth, setButtonWidth);
    _deleteButton.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_deleteButton];
    
    _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmButton.frame = CGRectMake(self.frame.size.width-Intrale-2*setButtonWidth, Intrale/2, 2*setButtonWidth, setButtonWidth);
    _confirmButton.backgroundColor = [UIColor orangeColor];
    [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    _confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:TextFont+1];
    [self addSubview:_confirmButton];
    
    [self addLeftLbl];
    
    _identificationField = [[UITextField alloc] initWithFrame:CGRectMake(LblWidth+2*Intrale, Intrale+setButtonWidth, (self.frame.size.width-LblWidth-3*Intrale)/2, LblHeight)];
    _identificationField.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:_identificationField];
    
    _valueField1 = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(_identificationField.frame), CGRectGetMaxY(_identificationField.frame)+Intrale, (self.frame.size.width-2*LblWidth-5*Intrale)/3, LblHeight)];
    _valueField1.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:_valueField1];
    
    _valueField2 = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_valueField1.frame)+Intrale, CGRectGetMaxY(_identificationField.frame)+Intrale, (self.frame.size.width-2*LblWidth-5*Intrale)/3, LblHeight)];
    _valueField2.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:_valueField2];
    
    _valueField3 = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_valueField2.frame)+Intrale, CGRectGetMaxY(_identificationField.frame)+Intrale, (self.frame.size.width-2*LblWidth-5*Intrale)/3, LblHeight)];
    _valueField3.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:_valueField3];
    
    _customField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(_identificationField.frame), CGRectGetMaxY(_valueField1.frame)+Intrale, self.frame.size.width-LblWidth-3*Intrale, LblHeight)];
    _customField.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:_customField];
}

- (void)addLeftLbl {
    NSArray *array = @[@"标识",@"值",@"自定义"];
    for (int i=0; i<array.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(Intrale, Intrale+setButtonWidth+i*(LblHeight+Intrale), LblWidth, LblHeight)];
        label.font = [UIFont systemFontOfSize:TextFont];
        label.text = array[i];
        [self addSubview:label];
    }
}

- (void)setFieldInitialTextWithInfo:(YGSetPropertyInfo *)info {
        _identificationField.text = info.identification?:@"";
        _valueField1.text = info.type?:@"长度L";
        _valueField2.text = info.number?:@"1";
        _valueField3.text = info.unit?:@"mm";
        _customField.text = info.custom?:@"";
}

- (void)pushPickerViewWith:(UIButton *)send {
    if (send.tag == 1) {
        _chooseStr = TypeArray[0];
        UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width-20, 180)];
        pickerView.showsSelectionIndicator = YES;
        pickerView.delegate = self;
        pickerView.dataSource = self;
        [self buildActionSheetWithView:pickerView tag:send.tag];
    } else if (send.tag == 2) {
        _chooseStr = TypeArray[0];
        UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width-20, 180)];
        pickerView.showsSelectionIndicator = YES;
        pickerView.delegate = self;
        pickerView.dataSource = self;
        [self buildActionSheetWithView:pickerView tag:send.tag];
    }
}

- (void)buildActionSheetWithView:(UIView *)view tag:(NSInteger)tag{
    if(VERSION_IS_IOS8)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n"  message:nil  preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"  style:UIAlertActionStyleCancel  handler:^(UIAlertAction *action) {
        }];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"选择"  style:UIAlertActionStyleDefault  handler:^(UIAlertAction *action) {
            if (tag == 8) {
//                _chooseField.text = _chooseDic[@"name"];
//                _chooseField.tag = [_chooseDic[@"index"] integerValue];
            } else if (tag == 6 || tag == 7) {
                [self setDateFormat];
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
        if (actionSheet.tag == 6 || actionSheet.tag == 7) {
            [self setDateFormat];
        } else if (actionSheet.tag == 8) {
            _chooseField.text = _chooseDic[@"name"];
            _chooseField.tag = [_chooseDic[@"index"] integerValue];
        }
    }
}

- (void)setDateFormat {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];//设置输出的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    _chooseField.text = [dateFormatter stringFromDate:_datePicker.date];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return DocumentStatusArray.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return DocumentStatusArray[row][@"name"];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _chooseDic = DocumentStatusArray[row];
}

@end
