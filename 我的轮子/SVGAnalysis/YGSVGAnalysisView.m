//
//  YGSVGAnalysisView.m
//  qpy
//
//  Created by qpy2 on 2017/12/7.
//

#import "YGSVGAnalysisView.h"

static const NSInteger MarkRadius = 20;

@implementation YGSVGAnalysisView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        if (!_tableView) {
            UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, (ScreenHeight-StatusBarHeight)/2+StatusBarHeight, ScreenWidth, 40)];
            titleLbl.backgroundColor = GRAY_BGCOLOR;
            titleLbl.font = [UIFont boldSystemFontOfSize:15];
            titleLbl.textColor =  [UIColor darkGrayColor];
            titleLbl.text = @"  配件清单:";
            [self addSubview:titleLbl];
            
            _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLbl.frame), ScreenWidth, (ScreenHeight-StatusBarHeight)/2-40) style:UITableViewStyleGrouped];
            _tableView.backgroundColor = RGBCOLOR(243, 243, 243);
            _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            _tableView.showsHorizontalScrollIndicator = NO;
            _tableView.showsVerticalScrollIndicator = NO;
            _tableView.delegate = self;
            _tableView.dataSource = self;
            _tableView.bounces = NO;
            [self addSubview:_tableView];
        }
        [self setMagnifyImage];
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, StatusBarHeight, 40, 40);
        [backButton setImage:[UIImage imageNamed:@"iv_svg_arrow_Left"] forState:UIControlStateNormal];
        backButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        [self addSubview:backButton];
        [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *screenshotsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        screenshotsButton.frame = CGRectMake(ScreenWidth-80, StatusBarHeight, 40, 40);
        [screenshotsButton setImage:[UIImage imageNamed:@"iv_svg_img_edit"] forState:UIControlStateNormal];
        screenshotsButton.imageEdgeInsets = UIEdgeInsetsMake(10, 20, 10, 0);
        [self addSubview:screenshotsButton];
        
        UIButton *zoomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        zoomButton.frame = CGRectMake(ScreenWidth-40, StatusBarHeight, 40, 40);
        [zoomButton setImage:[UIImage imageNamed:@"iv_svg_zoom"] forState:UIControlStateNormal];
        [zoomButton setImage:[UIImage imageNamed:@"iv_svg_zoom_close"] forState:UIControlStateSelected];
        zoomButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        [self addSubview:zoomButton];
        [zoomButton addTarget:self action:@selector(zoomScrollView:) forControlEvents:UIControlEventTouchUpInside];
        
        if (!_promptAlertView) {
            _promptAlertView = [[YGSVGAnalysisPromptAlertView alloc] initWithFrame:CGRectMake(0, ScreenHeight-20-[YGSVGAnalysisPromptAlertView viewHeigt], ScreenWidth, [YGSVGAnalysisPromptAlertView viewHeigt])];
            _promptAlertView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
            _promptAlertView.cancleButton.hidden = NO;
            [self addSubview:_promptAlertView];
            _promptAlertView.hidden = YES;
        }
    }
    return self;
}
#pragma mark 设置svg显示缩放视图
- (void)setMagnifyImage {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, StatusBarHeight, ScreenWidth, (ScreenHeight-StatusBarHeight)/2)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.userInteractionEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.maximumZoomScale = 10;
    _scrollView.minimumZoomScale = 0.2;
    [self addSubview:_scrollView];
    _svgImage = [SVGKImage imageWithContentsOfURL:[NSURL URLWithString:@"http://epc.svw.servision.com.cn/legend/svg/a4e8708ec1f39283b411f24daed92605.svg"]];
    _svgView = [[SVGKLayeredImageView alloc] initWithSVGKImage:_svgImage];
    _svgView.frame = CGRectMake(0, 0, _svgImage.size.width, _svgImage.size.height);
    _svgView.backgroundColor = [UIColor clearColor];
    _svgView.userInteractionEnabled = YES;
    [_scrollView addSubview:_svgView];
    [_scrollView setContentSize:CGSizeMake(_svgImage.size.width, _svgImage.size.height)];
    _scrollView.contentOffset = CGPointMake((_svgImage.size.width-ScreenWidth)/2.0f, (_svgImage.size.height-(ScreenHeight-StatusBarHeight))/2.0f);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    // 添加手势
    [_svgView addGestureRecognizer:tap];
    
    NodeList *textList = [_svgImage.DOMTree getElementsByTagName:@"text"];
    [self getTextPointDicAndKeyArrayWithTextList:textList];
}
#pragma mark 获取矢量图上的文字放到字典和数组中
- (void)getTextPointDicAndKeyArrayWithTextList:(NodeList *)textList {
    _textPointDic = [NSMutableDictionary dictionaryWithCapacity:10];
    for (SVGTextElement *textElement in textList) {
        CGPoint point = CGPointMake(textElement.transform.tx, textElement.transform.ty);
        NSString *key = textElement.textContent?:@"";
        YGSVGAnalysisInfo *info = [[YGSVGAnalysisInfo alloc] init];
        if (!_textPointDic[key]) {
            info.number = textElement.textContent?:@"";
        } else {
            info = _textPointDic[key][0][@"info"];
        }
        NSMutableDictionary *dic = [@{@"text":textElement.textContent?:@"",@"point":NSStringFromCGPoint(point)?:@"",@"font":[textElement cascadedValueForStylableProperty:@"font-size"]?:@"",@"font-family":[textElement cascadedValueForStylableProperty:@"font-family"]?:@"",@"text-anchor":[textElement cascadedValueForStylableProperty:@"text-anchor"]?:@"",@"info":info} mutableCopy];
        if (!_textPointDic[key]) {
            NSMutableArray *arr = [NSMutableArray arrayWithCapacity:10];
            [arr addObject:dic];
            [_textPointDic setValue:arr forKey:key];
            if (!_keyArray) {
                _keyArray = [NSMutableArray arrayWithCapacity:10];
            }
            [_keyArray addObject:info];
        } else {
            NSMutableArray *arr = _textPointDic[key];
            [arr addObject:dic];
        }
    }
    //数组排序
    _keyArray = [[_keyArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        YGSVGAnalysisInfo *info1 = obj1;
        YGSVGAnalysisInfo *info2 = obj2;
        return [info1.number compare:info2.number options:NSNumericSearch];
    }] mutableCopy];
    [_keyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        YGSVGAnalysisInfo *info = obj;
        info.indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
    }];
}
#pragma mark 返回
- (void)back:(UIButton *)send {
    [self removeFromSuperview];
}
#pragma mark 增大缩小可视范围
- (void)zoomScrollView:(UIButton *)send {
    if (send.selected) {
        _scrollView.frame = CGRectMake(0, StatusBarHeight, ScreenWidth, (ScreenHeight-StatusBarHeight)/2);
        _promptAlertView.hidden = YES;
    } else {
        _scrollView.frame = CGRectMake(0, StatusBarHeight, ScreenWidth, ScreenHeight-StatusBarHeight);
        if (_selectedInfo) {
            _promptAlertView.hidden = NO;
            [_promptAlertView setContentViewInfo:_selectedInfo];
        }
    }
    [self zoomToAdaptSize];
    [self setCenterWithScrollView:_scrollView];
    send.selected = !send.selected;
}
#pragma mark 缩放视图到适应的大小
- (void)zoomToAdaptSize {
    CGSize imageSize = _svgImage.size;
    CGSize scrollViewSize = _scrollView.frame.size;
    CGFloat scale = _scrollView.zoomScale;
    if (imageSize.width/imageSize.height>scrollViewSize.width/scrollViewSize.height) {
        scale = scrollViewSize.width/imageSize.width;
    } else {
        scale = scrollViewSize.height/imageSize.height;
    }
    [_scrollView setZoomScale:scale animated:YES];
}
#pragma mark 设置中心
- (void)setCenterWithScrollView:(UIScrollView *)scrollView {
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?(scrollView.bounds.size.width - scrollView.contentSize.width)/2.0f : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?(scrollView.bounds.size.height - scrollView.contentSize.height)/2.0f : 0.0;
    _svgView.center = CGPointMake(scrollView.contentSize.width/2.0f + offsetX,scrollView.contentSize.height/2.0f + offsetY);
}
#pragma mark svg视图对应文字的点击事件
- (void)tap:(UITapGestureRecognizer *)send {
    CGPoint point = [send locationInView:_svgView];
    for (NSString *key in _textPointDic) {
        BOOL isReturn = NO;
        for (NSDictionary *pointDic in _textPointDic[key]) {
            CGPoint centPoint = [self getTextCentPointWithTextDic:pointDic];
            CGRect textRect = CGRectMake(centPoint.x-MarkRadius, centPoint.y-MarkRadius, MarkRadius*2.0f, MarkRadius*2.0f);
            if (CGRectContainsPoint(textRect,point)) {
                [self removeLayer];
                for (NSDictionary *pointDic in _textPointDic[key]) {
                    CGPoint centPoint = [self getTextCentPointWithTextDic:pointDic];
                    [self drawRoundWithCentPoint:centPoint];
                }
                YGSVGAnalysisInfo *info = pointDic[@"info"];
                [self selectTextPointReloadWithInfo:info];
                [_tableView scrollToRowAtIndexPath:info.indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
                if (_scrollView.frame.size.height>(ScreenHeight-StatusBarHeight)/2) {
                    [_promptAlertView setContentViewInfo:info];
                    _promptAlertView.alpha = 0;
                    [UIView animateWithDuration:0.5 animations:^{
                        _promptAlertView.alpha = 1;
                        _promptAlertView.hidden = NO;
                    }];
                    
                }
                isReturn = YES;
            }
        }
        if (isReturn) {
            return;
        }
    }
}
#pragma mark 获取文字中心点
- (CGPoint)getTextCentPointWithTextDic:(NSDictionary *)pointDic {
    NSString *textAnchor = pointDic[@"text-anchor"];
    CGFloat index = 2.0f;
    if( [@"middle" isEqualToString:textAnchor] )
        index = 0;
    else if( [@"end" isEqualToString:textAnchor] )
        index = -2.0f;
    CGPoint textPoint = CGPointFromString(pointDic[@"point"]);
    NSString *actualSize = pointDic[@"font"];
    NSString *actualFamily = pointDic[@"font-family"];
    NSString *text = pointDic[@"text"];
    CGSize textSize = [self getTextSizeWithActualSize:actualSize actualFamily:actualFamily text:text];
    CGPoint centPoint = CGPointMake(textPoint.x+textSize.width/index, textPoint.y-textSize.height/6.0f);
    return centPoint;
}
#pragma mark 获取文字的大小
- (CGSize)getTextSizeWithActualSize:(NSString *)actualSize actualFamily:(NSString *)actualFamily text:(NSString *)text{
    CGFloat effectiveFontSize = (actualSize.length > 0) ? [actualSize floatValue] : 12;
    CTFontRef font = NULL;
    if( actualFamily != nil)
        font = CTFontCreateWithName( (CFStringRef)actualFamily, effectiveFontSize, NULL);
    if( font == NULL ) {
        font = CTFontCreateWithName( (CFStringRef) @"HelveticaNeue", effectiveFontSize, NULL);
    }
    NSMutableAttributedString* tempString = [[NSMutableAttributedString alloc] initWithString:text];
    [tempString addAttribute:(NSString *)kCTFontAttributeName
                       value:(__bridge id)font
                       range:NSMakeRange(0, tempString.string.length)];
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString( (CFMutableAttributedStringRef) tempString );
    CGSize suggestedUntransformedSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), NULL, CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX), NULL);
    CFRelease(framesetter);
    return suggestedUntransformedSize;
}
#pragma mark 清除上一次画的圆
- (void)removeLayer {
    for (CAShapeLayer *layer in _markCALayerArray) {
        [layer removeFromSuperlayer];
    }
    [_markCALayerArray removeAllObjects];
}
#pragma mark 画圆
- (void)drawRoundWithCentPoint:(CGPoint)centPoint {
    CAShapeLayer *markCALayer = [[CAShapeLayer alloc]init];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:centPoint
                                                        radius:MarkRadius
                                                    startAngle:-M_PI
                                                      endAngle:M_PI
                                                     clockwise:YES];
    markCALayer.path = path.CGPath;
    markCALayer.fillColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.2].CGColor;
    markCALayer.strokeColor = [UIColor redColor].CGColor;
    markCALayer.lineWidth = 2;
    [_svgView.layer addSublayer:markCALayer];
    
    if (!_markCALayerArray) {
        _markCALayerArray = [NSMutableArray arrayWithCapacity:10];
    }
    [_markCALayerArray addObject:markCALayer];
    
    CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnima.duration = 1.0f;
    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnima.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnima.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnima.fillMode = kCAFillModeForwards;
    pathAnima.removedOnCompletion = NO;
    [markCALayer addAnimation:pathAnima forKey:@"strokeEndAnimation"];
}
#pragma mark UIScrollViewDelegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _svgView;
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [self setCenterWithScrollView:scrollView];
}
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _keyArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MyCell";
    YGSVGAnalysisCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell=[[YGSVGAnalysisCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
    }
    YGSVGAnalysisInfo *info = _keyArray[indexPath.row];
    info.indexPath = indexPath;
    [cell setContentViewInfo:info];
    return cell;
}
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [YGSVGAnalysisCell cellHeigt];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YGSVGAnalysisInfo *info = _keyArray[indexPath.row];
    NSMutableArray *arr = _textPointDic[info.number];
    [self removeLayer];
    for (NSDictionary *pointDic in arr) {
        CGPoint centPoint = [self getTextCentPointWithTextDic:pointDic];
        [self drawRoundWithCentPoint:centPoint];
    }
    [self zoomToAdaptSize];
    [self selectTextPointReloadWithInfo:info];
}
#pragma 设置info的选择状态
- (void)selectTextPointReloadWithInfo:(YGSVGAnalysisInfo *)info {
    _selectedInfo.isSelect = NO;
    info.isSelect = YES;
    _selectedInfo = info;
    [_tableView reloadData];
}


@end
