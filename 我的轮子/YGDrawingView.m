//
//  YGDrawingView.m
//  我的轮子
//
//  Created by zccl2 on 16/9/23.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import "YGDrawingView.h"
#import "YGHeader.h"
#import "YGDrawingLineView.h"
#import "YGDrawingArrowView.h"

static NSInteger const Intrale = 10;
static NSInteger const ButtonWidth = 30;
//static NSInteger const SetPropertyViewHeight = 165;

@interface YGDrawingView () {
   CGFloat _setPropertyViewHeight;
    
}
@end

@implementation YGDrawingView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

-(instancetype)init{
    if (self=[super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:1];
        self.userInteractionEnabled = YES;
        [self addContentView];
    }
    return self;
}

/**< 键盘出现和改变时调用此方法*/
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    CGRect end=[[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect frame = _setPropertyView.frame;
    frame.origin.y = ScreenHeight-64-_setPropertyViewHeight-end.size.height;
    _setPropertyView.frame = frame;
    _imageView.transform = CGAffineTransformMake(_setPropertyView.lineView.transform.d, _setPropertyView.lineView.transform.c, -_setPropertyView.lineView.transform.c, _setPropertyView.lineView.transform.d, 0, 0 - (((CGRectGetMidX(_setPropertyView.lineView.frame)-ScreenWidth/2)*(_setPropertyView.lineView.transform.c))+((CGRectGetMidY(_setPropertyView.lineView.frame)-ScreenWidth/2)*(_setPropertyView.lineView.transform.d)))-(_imageView.center.y-CGRectGetMinY(_setPropertyView.frame)+20));
}
/**< 键盘隐藏时调用此方法*/
- (void)keyboardWillHide:(NSNotification *)aNotification {
    CGRect frame = _setPropertyView.frame;
    frame.origin.y = ScreenHeight-64-_setPropertyViewHeight;
    _setPropertyView.frame = frame;
}

- (void)addContentView {
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, ScreenWidth, ScreenWidth)];
    _imageView.userInteractionEnabled = YES;
    _imageView.image = [UIImage imageNamed:@"u11548"];
    _imageView.layer.masksToBounds = YES;
    [self addSubview:_imageView];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-64-ButtonWidth-Intrale, ScreenWidth, ButtonWidth+Intrale)];
    backView.backgroundColor = RGBCOLOR(243, 243, 243);
    [self addSubview:backView];
    
    NSArray *array = @[@"箭",@"线",@"孔",@"齿",@"电",@"二",@"LG"];
    for (int i=0; i<array.count; i++) {
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.tag = i;
        addButton.backgroundColor = [UIColor whiteColor];
        addButton.frame = CGRectMake(Intrale/2+i*(ButtonWidth+Intrale/2), Intrale/2, ButtonWidth, ButtonWidth);
        [addButton setTitle:array[i] forState:UIControlStateNormal];
        [addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addLine:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:addButton];
    }
    
    if (!_setPropertyView) {
        _setPropertyView = [[YGSetPropertyView alloc] initWithFrame:CGRectMake(0, ScreenHeight-64-_setPropertyViewHeight, ScreenWidth, _setPropertyViewHeight)];
        _setPropertyView.hidden = YES;
        [_setPropertyView.deleteButton addTarget:self action:@selector
         (deleteButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        [_setPropertyView.confirmButton addTarget:self action:@selector(setPropertyViewHide) forControlEvents:UIControlEventTouchUpInside];
        _setPropertyView.identificationField.delegate = self;
        _setPropertyView.valueField1.delegate = self;
        _setPropertyView.valueField2.delegate = self;
        _setPropertyView.valueField3.delegate = self;
        _setPropertyView.customField.delegate = self;
        __weak typeof(self) vc = self;
        _setPropertyView.fieldButtonPress = ^(){
            [vc textFieldDidChange:nil];
        };
        [self addSubview:_setPropertyView];
    }
}

- (void)addLine:(UIButton *)send {
    if (send.tag == 0 || send.tag == 2 || send.tag == 3 || send.tag == 4) {
        YGDrawingArrowView *arrowView = [[YGDrawingArrowView alloc] init];
        [_imageView addSubview:arrowView];
        _setPropertyViewHeight = [_setPropertyView addContentVieWithTag:send.tag];
        _setPropertyView.frame = CGRectMake(0, ScreenHeight-64-_setPropertyViewHeight, ScreenWidth, _setPropertyViewHeight);
        _setPropertyView.deleteButton.buttonInfo = arrowView;
        _setPropertyView.hidden = NO;
    } else if (send.tag == 1) {
        YGDrawingLineView *lineView = [[YGDrawingLineView alloc] init];
        [_imageView addSubview:lineView];
        [lineView addField];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPress:)];
        [lineView addGestureRecognizer:tap];
        _setPropertyViewHeight = [_setPropertyView addContentVieWithTag:send.tag];
        _setPropertyView.frame = CGRectMake(0, ScreenHeight-64-_setPropertyViewHeight, ScreenWidth, _setPropertyViewHeight);
        [_setPropertyView addContentVieWithTag:send.tag];
        [_setPropertyView setFieldInitialTextWithInfo:nil];
        _setPropertyView.deleteButton.buttonInfo = lineView;
        _setPropertyView.lineView = lineView;
        _setPropertyView.hidden = NO;
    } else if (send.tag == 5) {
        if (!_twoBarCodeView) {
            _twoBarCodeView = [[YGTwoBarCodeView alloc] initWithX:Intrale y:ScreenWidth-70-Intrale width:70 string:@"哈哈哈哈哈哈哈哈哈哈哈"];
            [_imageView addSubview:_twoBarCodeView];
        }
    } else if (send.tag == 6) {
        if (!_companyLogoView) {
            _companyLogoView = [[YGCompanyLogoView alloc] initWithFrame:CGRectMake(Intrale, ScreenWidth-70-Intrale, 70, 70) logo:@"logo"];
            [_imageView addSubview:_companyLogoView];
        }
    }
}

- (void)tapPress:(UITapGestureRecognizer *)send {
    YGDrawingLineView *view = (YGDrawingLineView *)send.view;
    [_setPropertyView setFieldInitialTextWithInfo:view.info];
    _setPropertyView.deleteButton.buttonInfo = view;
    _setPropertyView.lineView = view;
    _setPropertyView.hidden = NO;
}

- (void)setPropertyViewHide {
    _imageView.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
    [self endEditing:YES];
    _setPropertyView.hidden = YES;
}

- (void)deleteButtonPress:(YGMyButton *)send {
    [self setPropertyViewHide];
    YGDrawingLineView *view = (YGDrawingLineView *)send.buttonInfo;
    [view deleteView];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
}


- (void)textFieldDidChange:(NSNotification *)note
{
    YGSetPropertyInfo *info = [[YGSetPropertyInfo alloc] init];
    info.identification = _setPropertyView.identificationField.text;
    info.type = _setPropertyView.valueField1.text;
    info.number = _setPropertyView.valueField2.text;
    info.unit = _setPropertyView.valueField3.text;
    info.custom = _setPropertyView.customField.text;
    [_setPropertyView.lineView setField1TextWithInfo:info];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    _imageView.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
    [self endEditing:YES];
    return YES;
}


@end
