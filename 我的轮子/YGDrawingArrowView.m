//
//  YGDrawingArrowView.m
//  我的轮子
//
//  Created by zccl2 on 16/10/9.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import "YGDrawingArrowView.h"
#import "YGTool.h"

static NSInteger const Intrale = 10;
static NSInteger const Width = 150;
static NSInteger const Height = 25;
static NSInteger const ImageWidth = 40;
static NSInteger const ImageHeight = 20;

@implementation YGDrawingArrowView

-(instancetype)init{
    if (self=[super init]) {
        self.frame = CGRectMake(Intrale, Intrale, Width, Height);
        [self addContentView];
    }
    return self;
}

- (void)addContentView {
    _arrow = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, ImageWidth, ImageHeight)];
    _arrow.image = [UIImage imageNamed:@"jt"];
    [self addSubview:_arrow];
    
    self.userInteractionEnabled = YES;
    [self addField];
}

- (void)addField {
    _field = [[UITextField alloc] initWithFrame:CGRectMake(ImageWidth, 0, Width-ImageWidth, ImageHeight)];
    _field.adjustsFontSizeToFitWidth = YES;
    NSMutableAttributedString *colorStr = [[NSMutableAttributedString alloc] initWithString:@"请输入标注内容"];
    [colorStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,colorStr.length)];
    _field.attributedPlaceholder = colorStr;
    _field.textColor = [UIColor redColor];
    _field.font = [UIFont systemFontOfSize:12];
    _field.userInteractionEnabled = NO;
    [self addSubview:_field];
    [_field sizeToFit];
}


- (void)setTextFieldMessageWithInfo:(YGSetPropertyInfo *)info {
    if (self.tag == 0) {
        _field.text = info.plainText;
    } else if (self.tag == 2) {
        NSString *identification = @"";
        if (![YGTool isBlankString:info.holeIdentification]) {
            identification = [NSString stringWithFormat:@"%@:",info.holeIdentification];
        }
        NSString *type = @"";
        if (![YGTool isBlankString:info.holeStyle]) {
            if ([info.holeStyle isEqualToString:@"通孔"]) {
                type = @"Φ";
            } else if ([info.holeStyle isEqualToString:@"牙孔"]) {
                type = @"M";
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
        _field.text = [NSString stringWithFormat:@"%@%@%@%@%@",identification,info.holeNumber,type,diameter,custom];
    } else if (self.tag == 3) {
        NSString *identification = @"";
        if (![YGTool isBlankString:info.toothIdentification]) {
            identification = [NSString stringWithFormat:@"%@:",info.toothIdentification];
        }
        NSString *diameter = @"";
        if (![YGTool isBlankString:info.toothDiameter]) {
            diameter = [NSString stringWithFormat:@"c-D%@",info.toothDiameter];
        }
        NSString *thick = @"";
        if (![YGTool isBlankString:info.toothThick]) {
            thick = [NSString stringWithFormat:@",t%@",info.toothThick];
        }
        NSString *type = @"";
        if (![YGTool isBlankString:info.toothStyle]) {
            type = [NSString stringWithFormat:@",%@",info.toothStyle];
        }
        
        NSString *custom = @"";
        if (![YGTool isBlankString:info.custom]) {
            custom = [NSString stringWithFormat:@",%@",info.custom];
        }
        _field.text = [NSString stringWithFormat:@"%@%@%@%@%@%@",identification,info.toothNumber,diameter,thick,type,custom];
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
        _field.text = [NSString stringWithFormat:@"%@%@%@%@",voltage,current,power,custom];
    }
    [_field sizeToFit];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!_magnifierView) {
        _magnifierView = [[YGMagnifierView alloc] init];
        _magnifierView.viewToMagnify = self.superview;
    }
    [self.window addSubview:_magnifierView];
    _magnifierView.touchPoint = CGPointMake(self.frame.origin.x+7, self.frame.origin.y+Height);
    [_magnifierView setNeedsDisplay];
    
//    self.layer.anchorPoint = CGPointMake(0, 0.5);
//    self.transform = CGAffineTransformMake(-1, 0, 0, 1, 0, 0);
//    _field.transform = CGAffineTransformMake(-1, 0, 0, 1, 0, 0);
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    //当前的point
    CGPoint currentP = [touch locationInView:self.superview];
    CGPoint previousP = [touch previousLocationInView:self.superview];
    if (self.frame.origin.x+currentP.x-previousP.x>0) {
        self.transform = CGAffineTransformTranslate(self.transform, currentP.x-previousP.x, currentP.y-previousP.y);
        _magnifierView.touchPoint = CGPointMake(self.frame.origin.x+7, self.frame.origin.y+Height);
        [_magnifierView setNeedsDisplay];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_magnifierView removeFromSuperview];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_magnifierView removeFromSuperview];
}

@end
