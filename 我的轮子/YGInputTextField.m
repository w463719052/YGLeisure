//
//  YGInputTextField.m
//  我的轮子
//
//  Created by zccl2 on 16/10/17.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import "YGInputTextField.h"
#import "YGTool.h"

static NSInteger const Intrale = 10;
static NSInteger const Width = 200;
static NSInteger const Height = 35;

@implementation YGInputTextField

- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake(Intrale, Intrale, Width, Height);
        self.userInteractionEnabled = YES;
        _textView = [[UITextView alloc] initWithFrame:self.bounds];
        _textView.layer.borderWidth = 1;
        _textView.layer.borderColor = [UIColor redColor].CGColor;
        _textView.layer.cornerRadius = 3;
        _textView.backgroundColor = [UIColor clearColor];
        _textView.userInteractionEnabled = NO;
        _textView.font = [UIFont systemFontOfSize:18];
        _textView.textColor = [UIColor redColor];
        _textView.layoutManager.allowsNonContiguousLayout = NO;
        _textView.layer.shadowOpacity = 1.0;
        _textView.layer.shadowRadius = 1.0;
        _textView.layer.shadowColor = [UIColor blackColor].CGColor;
        _textView.layer.shadowOffset = CGSizeMake(0, 0.8);
        [self addSubview:_textView];
    }
    return self;
}

- (void)setTextFieldMessageWithInfo:(YGSetPropertyInfo *)info {
    _info = info;
    if (self.tag == 5) {
        _textView.text = info.plainText;
    } else if (self.tag == 2) {
        NSString *identification = @"";
        if (![YGTool isBlankString:info.holeIdentification]) {
            identification = [NSString stringWithFormat:@"%@:",info.holeIdentification];
        }
        NSString *type = @"";
        if (![YGTool isBlankString:info.holeStyle]) {
            if ([info.holeStyle isEqualToString:@"通孔"]) {
                type = @"-Φ";
            } else if ([info.holeStyle isEqualToString:@"牙孔"]) {
                type = @"-M";
            }
        }
        NSString *diameter = @"";
        if (![YGTool isBlankString:info.holeDiameter]) {
            diameter = [NSString stringWithFormat:@"%@mm",info.holeDiameter];
        }
        NSString *custom = @"";
        if (![YGTool isBlankString:info.custom]) {
            custom = [NSString stringWithFormat:@",%@",info.custom];
        }
        _textView.text = [NSString stringWithFormat:@"%@%@%@%@%@",identification,info.holeNumber,type,diameter,custom];
    } else if (self.tag == 3) {
        NSString *identification = @"";
        if (![YGTool isBlankString:info.toothIdentification]) {
            identification = [NSString stringWithFormat:@"%@:",info.toothIdentification];
        }
        NSString *diameter = @"";
        if (![YGTool isBlankString:info.toothDiameter]) {
            diameter = [NSString stringWithFormat:@"c-D%@mm",info.toothDiameter];
        }
        NSString *thick = @"";
        if (![YGTool isBlankString:info.toothThick]) {
            thick = [NSString stringWithFormat:@",t%@mm",info.toothThick];
        }
        NSString *type = @"";
        if (![YGTool isBlankString:info.toothStyle]) {
            type = [NSString stringWithFormat:@",%@",info.toothStyle];
        }
        
        NSString *custom = @"";
        if (![YGTool isBlankString:info.custom]) {
            custom = [NSString stringWithFormat:@",%@",info.custom];
        }
        _textView.text = [NSString stringWithFormat:@"%@%@%@%@%@%@",identification,info.toothNumber,diameter,thick,type,custom];
    } else if (self.tag == 4) {
        NSString *voltage = @"";
        if (![YGTool isBlankString:info.voltage]) {
            voltage = [NSString stringWithFormat:@"%@V",info.voltage];
        }
        NSString *current = @"";
        if (![YGTool isBlankString:info.current]) {
            current = [NSString stringWithFormat:@"-%@A",info.current];
        }
        NSString *power = @"";
        if (![YGTool isBlankString:info.power]) {
            power = [NSString stringWithFormat:@"-%@W",info.power];
        }
        NSString *custom = @"";
        if (![YGTool isBlankString:info.custom]) {
            custom = [NSString stringWithFormat:@",%@",info.custom];
        }
        _textView.text = [NSString stringWithFormat:@"%@%@%@%@",voltage,current,power,custom];
    }
    [_textView scrollRangeToVisible:NSMakeRange(_textView.text.length, 1)];
}

- (void)setViewBorderHide {
    _isSetProperty = NO;
    _textView.layer.borderColor = [UIColor clearColor].CGColor;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _textView.layer.borderColor = [UIColor redColor].CGColor;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    //当前的point
    CGPoint currentP = [touch locationInView:self.superview];
    CGPoint previousP = [touch previousLocationInView:self.superview];
    CGPoint point = [touch locationInView:self];
    if ((CGRectGetWidth(self.frame)-point.x<30)&&(CGRectGetHeight(self.frame)-point.y<30)) {
        CGRect frame = self.frame;
        frame.size.width += currentP.x-previousP.x;
        frame.size.height += currentP.y-previousP.y;
        self.frame = frame;
        _textView.frame = self.bounds;
    } else {
        self.transform = CGAffineTransformTranslate(self.transform, currentP.x-previousP.x, currentP.y-previousP.y);
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!_isSetProperty) {
        _textView.layer.borderColor = [UIColor clearColor].CGColor;
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!_isSetProperty) {
        _textView.layer.borderColor = [UIColor clearColor].CGColor;
    }
}

@end
