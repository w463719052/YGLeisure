//
//  YGSVGAnalysisVC.m
//  我的轮子
//
//  Created by qpy2 on 2017/12/7.
//  Copyright © 2017年 com.zccl. All rights reserved.
//

#import "YGSVGAnalysisVC.h"
#import "YGSVGAnalysisView.h"
#import "YGHeader.h"
#import "SVGKit.h"
#import "SVGParser.h"
#import "UIScrollView+YGTouch.h"
#import "YGSVGAnalysisCell.h"
#import <CoreText/CoreText.h>
#import "YGSVGAnalysisPromptAlertView.h"

@interface YGSVGAnalysisVC ()<QLPreviewControllerDataSource,QLPreviewControllerDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView *_scrollView;
    SVGKImage *_svgImage;
    SVGKLayeredImageView *_svgView;
    NSMutableDictionary *_textPointDic;
    NSMutableArray *_keyArray;
    
    NSMutableArray *_markCALayerArray;
    
    UITableView *_tableView;
    YGSVGAnalysisInfo *_selectedInfo;
    
    YGSVGAnalysisPromptAlertView *_promptAlertView;
}

@end

static const NSInteger MarkRadius = 20;

@implementation YGSVGAnalysisVC

#define YGWIDTH [UIScreen mainScreen].bounds.size.width
#define YGHEIGHT [UIScreen mainScreen].bounds.size.height
#define GRAY_BGCOLOR RGBCOLOR(243,243,243)


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarWithBackButton:YES];
//    if (!_tableView) {
//        UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, (ScreenHeight-TopBarHeight)/2, ScreenWidth, 40)];
//        titleLbl.backgroundColor = GRAY_BGCOLOR;
//        titleLbl.font = [UIFont boldSystemFontOfSize:15];
//        titleLbl.textColor =  [UIColor darkGrayColor];
//        titleLbl.text = @"  配件清单:";
//        [self.view addSubview:titleLbl];
//
//        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLbl.frame), ScreenWidth, (ScreenHeight-TopBarHeight)/2-40) style:UITableViewStyleGrouped];
//        _tableView.backgroundColor = RGBCOLOR(243, 243, 243);
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//        _tableView.showsHorizontalScrollIndicator = NO;
//        _tableView.showsVerticalScrollIndicator = NO;
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//        _tableView.bounces = NO;
//        [self.view addSubview:_tableView];
//    }
//    [self setMagnifyImage];
//
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(ScreenWidth-50, 10, 40, 40);
//    button.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:button];
//    [button addTarget:self action:@selector(zoomScrollView) forControlEvents:UIControlEventTouchUpInside];
//
//    if (!_promptAlertView) {
//        _promptAlertView = [[YGSVGAnalysisPromptAlertView alloc] initWithFrame:CGRectMake(0, ScreenHeight-TopBarHeight-20-[YGSVGAnalysisPromptAlertView viewHeigt], ScreenWidth, [YGSVGAnalysisPromptAlertView viewHeigt])];
//        _promptAlertView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
//        _promptAlertView.cancleButton.hidden = NO;
//        [self.view addSubview:_promptAlertView];
//        _promptAlertView.hidden = YES;
//    }
    YGSVGAnalysisView *SVGAnalysisView = [[YGSVGAnalysisView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:SVGAnalysisView];
    
//    [self setImaa];
    
//    QLPreviewController *previewController = [[QLPreviewController alloc] init];
//    [self setDataSource:self];
//    [self setDelegate:self];
//    NSLog(@"%@",self.dataSource);
//    [self presentModalViewController:previewController animated:YES];
}
#pragma mark 增大缩小可视范围
- (void)zoomScrollView {
    if (_scrollView.frame.size.height>(ScreenHeight-TopBarHeight)/2) {
        _scrollView.frame = CGRectMake(0, 0, ScreenWidth, (ScreenHeight-TopBarHeight)/2);
        _promptAlertView.hidden = YES;
    } else {
        _scrollView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-TopBarHeight);
        if (_selectedInfo) {
            _promptAlertView.hidden = NO;
            [_promptAlertView setContentViewInfo:_selectedInfo];
        }
    }
    [self zoomToAdaptSize];
    [self setCenterWithScrollView:_scrollView];
}
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

- (void)setMagnifyImage {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, (ScreenHeight-TopBarHeight)/2)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.userInteractionEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.maximumZoomScale = 10;
    _scrollView.minimumZoomScale = 0.2;
    [self.view addSubview:_scrollView];
//    NSString *svgName = @"4G63-D-J4-03";
//    SVGKImage *svgImage = [SVGKImage imageNamed:svgName];
    _svgImage = [SVGKImage imageWithContentsOfURL:[NSURL URLWithString:@"http://epc.svw.servision.com.cn/legend/svg/a4e8708ec1f39283b411f24daed92605.svg"]];
    _svgView = [[SVGKLayeredImageView alloc] initWithSVGKImage:_svgImage];
    _svgView.frame = CGRectMake(0, 0, _svgImage.size.width, _svgImage.size.height);
    _svgView.backgroundColor = [UIColor clearColor];
    _svgView.userInteractionEnabled = YES;
    [_scrollView addSubview:_svgView];
    [_scrollView setContentSize:CGSizeMake(_svgImage.size.width, _svgImage.size.height)];
    _scrollView.contentOffset = CGPointMake((_svgImage.size.width-ScreenWidth)/2.0f, (_svgImage.size.height-(ScreenHeight-TopBarHeight))/2.0f);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    // 添加手势
    [_svgView addGestureRecognizer:tap];
    
    NodeList *textList = [_svgImage.DOMTree getElementsByTagName:@"text"];
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

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _svgView;
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [self setCenterWithScrollView:scrollView];
}
#pragma mark 设置中心
- (void)setCenterWithScrollView:(UIScrollView *)scrollView {
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?(scrollView.bounds.size.width - scrollView.contentSize.width)/2.0f : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?(scrollView.bounds.size.height - scrollView.contentSize.height)/2.0f : 0.0;
    _svgView.center = CGPointMake(scrollView.contentSize.width/2.0f + offsetX,scrollView.contentSize.height/2.0f + offsetY);
}

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
                if (_scrollView.frame.size.height>(ScreenHeight-TopBarHeight)/2) {
                    [_promptAlertView setContentViewInfo:info];
//                    if ([info.number isEqualToString:@"15"]) {
////                        [_promptAlertView setContentViewText:[NSString stringWithFormat:@"%@测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试",info.number]];
//                    } else {
//                        [_promptAlertView setContentViewText:[NSString stringWithFormat:@"%@测试测试",info.number]];
//                    }
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
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    UITouch *touch = touches.anyObject;//获取触摸对象
//    CGPoint point = [touch locationInView:_svgView];
//    if (!_markCALayer) {
//        _markCALayer = [[CAShapeLayer alloc]init];
//    }
//    [_markCALayer removeFromSuperlayer];
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(point.x, point.y, 40, 40) cornerRadius:20];
//    _markCALayer.path = path.CGPath;
//    _markCALayer.fillColor = [UIColor clearColor].CGColor;
//    _markCALayer.strokeColor = [UIColor orangeColor].CGColor;
//    _markCALayer.lineWidth = 3;
//    //    _markCALayer.strokeStart = 0;
//    //    _markCALayer.strokeStart = 1;
//    //    _markCALayer.strokeEnd = 1;
//    [_svgView.layer addSublayer:_markCALayer];
//}

- (void)setImaa {
//    CGSize finalSize = CGSizeMake(CGRectGetWidth(self.view.frame), 600);
//    CGFloat layerHeight = finalSize.height * 0.2;
//    CAShapeLayer *bottomCurveLayer = [[CAShapeLayer alloc]init];
//
//    UIBezierPath *path = [[UIBezierPath alloc]init];
//    [path moveToPoint:CGPointMake(48.128, 203.776)];
//    [path addLineToPoint:CGPointMake(463.872, 0)];
//    [path addLineToPoint:CGPointMake(-75.776, -136.192)];
//    [path addLineToPoint:CGPointMake(71.68, -35.84)];
//    [path addQuadCurveToPoint:CGPointMake(15.36, 20.48) controlPoint:CGPointMake(34.304, 53.76)];
//    [path addQuadCurveToPoint:CGPointMake(46.592, 82.432) controlPoint:CGPointMake(0, 0)];
//    [path addLineToPoint:CGPointMake(-68.608, 35.84)];
//    [path addLineToPoint:CGPointMake(455.68, 0)];
//    [path addLineToPoint:CGPointMake(0, 71.68)];
//    [path addLineToPoint:CGPointMake(-179.2, 0)];
//    [path addQuadCurveToPoint:CGPointMake(15.36, 20.48) controlPoint:CGPointMake(34.304, 53.76)];
//
//    bottomCurveLayer.path = path.CGPath;
//    bottomCurveLayer.fillColor = [UIColor orangeColor].CGColor;
//    [self.view.layer addSublayer:bottomCurveLayer];

    
//    CGFloat width = 1024;
//    CGFloat height = 1024;
////    CGFloat bili = ScreenWidth/width;
//    SvgToBezier *bz = [[SvgToBezier alloc] initFromSVGPathNodeDAttr:@"M48.128 203.776l463.872 0-75.776-136.192 71.68-35.84q15.36 20.48 34.304 53.76t46.592 82.432l-68.608 35.84 455.68 0 0 71.68-179.2 0q-26.624 142.336-81.92 252.416t-142.336 192q66.56 51.2 170.496 91.136t245.248 72.704l-19.456 44.032-24.576 39.936q-153.6-52.224-261.12-99.84t-171.008-96.768q-63.488 46.08-168.448 96.256t-259.584 108.544l-44.032-76.8q148.48-41.984 250.368-86.528t162.304-92.672q-88.064-91.136-144.384-201.216t-79.872-243.2l-180.224 0 0-71.68zM516.096 667.648q81.92-78.848 130.048-176.64t66.56-215.552l-408.576 0q43.008 227.328 211.968 392.192z" rect:CGRectMake(200, 200, width, height)];

    
    CGPathRef path = [SVGParser pathFromSVGFileNamed:@"12111"];

//    CGSize finalSize = CGSizeMake(CGRectGetWidth(self.frame), 600);
//    CGFloat layerHeight = finalSize.height * 0.2;
    CAShapeLayer *bottomCurveLayer = [[CAShapeLayer alloc]init];

//            UIBezierPath *path = [[UIBezierPath alloc]init];
//            [path moveToPoint:CGPointMake(0, finalSize.height - layerHeight)];
//            [path addLineToPoint:CGPointMake(0, finalSize.height - 1)];
//            [path addLineToPoint:CGPointMake(finalSize.width, finalSize.height - 1)];
//            [path addLineToPoint:CGPointMake(finalSize.width, finalSize.height - layerHeight)];
//            [path addQuadCurveToPoint:CGPointMake(0, finalSize.height - layerHeight) controlPoint:CGPointMake(finalSize.width / 2, (finalSize.height - layerHeight) - 40)];


    bottomCurveLayer.path = path;
    bottomCurveLayer.fillColor = [UIColor blackColor].CGColor;
    bottomCurveLayer.strokeColor = [UIColor clearColor].CGColor;
//    bottomCurveLayer.lineWidth = 5;
    [self.view.layer addSublayer:bottomCurveLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.polyline
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


- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller
{
    return 1;
}
- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index
{
    return [[NSBundle mainBundle] URLForResource:@"127" withExtension:@"svg"];
}

//- (CGRect)previewController:(QLPreviewController *)controller frameForPreviewItem:(id<QLPreviewItem>)item inSourceView:(UIView *__autoreleasing  _Nullable *)view {
//    return CGRectMake(50, 100, 100, 200);
//}
//
//- (UIImage *)previewController:(QLPreviewController *)controller transitionImageForPreviewItem:(id<QLPreviewItem>)item contentRect:(CGRect *)contentRect {
//    return nil;
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
