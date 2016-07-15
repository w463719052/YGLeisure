//
//  YGTextView.m
//  qpy
//
//  Created by zccl2 on 16/7/6.
//  Copyright © 2016年 dcf. All rights reserved.
//

#import "YGTextView.h"
#import <CoreText/CoreText.h>

@interface YGTextView ()
{
    CTFrameRef _frame;
    NSMutableAttributedString *_attString;
    NSString *_telePhone;
    NSInteger _index;
}
@end

@implementation YGTextView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint location = [self systemPointFromScreenPoint:[touch locationInView:self]];
    if ([self touchLinkInViewAtPoint:location]) {
        UIWebView*callWebview =[[UIWebView alloc] init];
        NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",_telePhone]];
        [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
        //记得添加到view上
        [self addSubview:callWebview];
    }
}

-(CGPoint)systemPointFromScreenPoint:(CGPoint)origin
{
    return CGPointMake(origin.x, self.bounds.size.height - origin.y);
}

// 检测点击位置是否在链接上
- (BOOL)touchLinkInViewAtPoint:(CGPoint)point {
    CTFrameRef textFrame = _frame;
    CFArrayRef lines = CTFrameGetLines(textFrame);
    if (!lines) return NO;
    CFIndex count = CFArrayGetCount(lines);
    // 获得每一行的 origin 坐标
    CGPoint origins[count];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0,0), origins);
    // 翻转坐标系
    CGAffineTransform transform =  CGAffineTransformMakeTranslation(0, self.bounds.size.height);
    transform = CGAffineTransformScale(transform, 1.f, -1.f);
    for (int i = 0; i < count; i++) {
        CGPoint linePoint = origins[i];
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        // 获得每一行的 CGRect 信息
        CGRect flippedRect = [self getLineBounds:line point:linePoint];
        CGRect rect = CGRectApplyAffineTransform(flippedRect, transform);
        if (CGRectContainsPoint(rect, point)) {
            // 将点击的坐标转换成相对于当前行的坐标
            CGPoint relativePoint = CGPointMake(point.x-CGRectGetMinX(rect),
                                                point.y-CGRectGetMinY(rect));
            // 获得当前点击坐标对应的字符串偏移
            CFIndex idx = CTLineGetStringIndexForPosition(line, relativePoint);
            if (NSLocationInRange(idx,NSMakeRange(_index, _telePhone.length))) {
                return YES;
                break;
            }
        }
    }
    return NO;
}

- (CGRect)getLineBounds:(CTLineRef)line point:(CGPoint)point {
    CGFloat ascent = 0.0f;
    CGFloat descent = 0.0f;
    CGFloat leading = 0.0f;
    CGFloat width = (CGFloat)CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    CGFloat height = ascent + descent;
    return CGRectMake(point.x, point.y - descent, width, height);
}

- (BOOL)judgeTelePhoneWithString:(NSString *)string {
    unichar c;
    for (int i=0; i<string.length; i++) {
        c=[string characterAtIndex:i];
        if (isdigit(c)) {
            for (int j = i+1; j<string.length; j++) {
                c = [string characterAtIndex:j];
                if (!isdigit(c)) {
                    NSString *telePhone = [string substringWithRange:NSMakeRange(i, j-i)];
                    NSString *str=@"^((((0\\d{2,3})(-)?)?(\\d{7,8})(-(\\d{3,}))?)|(1[8,3,5,7][0-9]{9}))$";
                    NSPredicate *pre=[NSPredicate predicateWithFormat:@"self matches%@",str];
                    BOOL siMatch=[pre evaluateWithObject:telePhone];
                    if (siMatch) {
                        _index = i;
                        _telePhone = telePhone;
                        return YES;
                    }
                }
            }
        }
    }
    return NO;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self myDraw];
}

- (void)setAttributedStringWithString:(NSString *)str {
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:str];
    [attString addAttribute:NSForegroundColorAttributeName value:_color range:NSMakeRange(0,attString.length)];
    [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0,attString.length)];
    if ([self judgeTelePhoneWithString:str]) {
        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(_index,_telePhone.length)];
        [attString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(_index,_telePhone.length)];
    }
    _attString = attString;
    [self setNeedsDisplay];
}

- (CGSize)adaptiveDimension {
    [self myDraw];
    return _optimumSize;
}

- (void)myDraw {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    CTFramesetterRef framesetter =
    CTFramesetterCreateWithAttributedString((CFAttributedStringRef)_attString);
    if (_frame) {
        CFRelease(_frame);
        _frame = NULL;
    }
    _frame = CTFramesetterCreateFrame(framesetter,
                                      CFRangeMake(0, 0), path, NULL);
    CFRange range;
    CGSize constraint = CGSizeMake(self.frame.size.width, MAXFLOAT);
    CGSize sizeAfterRender = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, _attString.length), nil, constraint, &range);
    _optimumSize = sizeAfterRender;
    CTFrameDraw(_frame, context);
    CFRelease(path);
    CFRelease(framesetter);
}

@end
