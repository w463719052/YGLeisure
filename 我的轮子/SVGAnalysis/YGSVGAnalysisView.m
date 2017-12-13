//
//  YGSVGAnalysisView.m
//  qpy
//
//  Created by qpy2 on 2017/12/7.
//

#import "YGSVGAnalysisView.h"

@implementation YGSVGAnalysisView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        //获取事先准备好的XML文件
        NSString *path = [self getPdfPathByFile:@"127"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
        parser.delegate = self;
        [parser parse];
//        //添加代理
//        self.par.delegate = self;
//        //初始化数组，存放解析后的数据
//        self.list = [NSMutableArray arrayWithCapacity:5];
//        _infoDic = [NSMutableDictionary dictionaryWithCapacity:10];
        
        
        
    }
    return self;
}

- (NSString *)getPdfPathByFile:(NSString *)fileName {
    return [[NSBundle mainBundle] pathForResource:fileName ofType:@"svg"];
}


//几个代理方法的实现，是按逻辑上的顺序排列的，但实际调用过程中中间三个可能因为循环等问题乱掉顺序
//开始解析
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"parserDidStartDocument...");
}
//准备节点
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict{
//    if (attributeDict[@"d"]) {
//        if (_index < 10) {
//
//
//            CGSize finalSize = CGSizeMake(CGRectGetWidth(self.frame), 600);
//            CGFloat layerHeight = finalSize.height * 0.2;
//            CAShapeLayer *bottomCurveLayer = [[CAShapeLayer alloc]init];
//
//            //        UIBezierPath *path = [[UIBezierPath alloc]init];
//            //        [path moveToPoint:CGPointMake(0, finalSize.height - layerHeight)];
//            //        [path addLineToPoint:CGPointMake(0, finalSize.height - 1)];
//            //        [path addLineToPoint:CGPointMake(finalSize.width, finalSize.height - 1)];
//            //        [path addLineToPoint:CGPointMake(finalSize.width, finalSize.height - layerHeight)];
//            //        [path addQuadCurveToPoint:CGPointMake(0, finalSize.height - layerHeight) controlPoint:CGPointMake(finalSize.width / 2, (finalSize.height - layerHeight) - 40)];
//
//
//            bottomCurveLayer.path = bz.bezier.CGPath;
//            bottomCurveLayer.fillColor = [UIColor orangeColor].CGColor;
//            [self.layer addSublayer:bottomCurveLayer];
//            _index ++;
//        }
    
        
//        CAShapeLayer *rectLayer = [CAShapeLayer layer];
////        rectLayer.fillColor = [UIColor darkGrayColor].CGColor;
//        rectLayer.path = bezier.bezier.CGPath;
////        rectLayer.borderColor = [UIColor blackColor].CGColor;
////        rectLayer.lineWidth = bezier.bezier.lineWidth;
////        rectLayer.fillColor = [UIColor greenColor].CGColor;
////        rectLayer.strokeColor = [UIColor whiteColor].CGColor;
//        [self.layer addSublayer:rectLayer];
//    }
    
    
    if (!_analysisArray) {
        _analysisArray = [NSMutableArray arrayWithCapacity:10];
    }
    [_analysisArray addObject:attributeDict];
//    self.currentElement1 = elementName;
//    if (_isBeginRecord) {
//        _isBeginRecord = NO;
//        self.currentElement = elementName;
//        _infoDic = [NSMutableDictionary dictionaryWithCapacity:10];
//    }
//    //    if (!_isBeginRecord) {
//    //        [_infoDic setDictionary:attributeDict];
//    //    }
//    if ([elementName isEqualToString:@"Components"]) {
//        _isBeginRecord = YES;
//        //        [self.textArry addObject:self.currentElement];
//        //        self.list = [NSMutableArray arrayWithCapacity:10];
//    }
//    //    if ([self.currentElement isEqualToString:@"ClientRectangle"]){
//    //        self.person = [[YGPrintingPerson alloc] init];
//    //    }
//
}
//获取节点内容
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    NSLog(@"222222--%@",string);
//    _str = string;
    //    if ([self.currentElement isEqualToString:@"ClientRectangle"]) {
    //        self.person.ClientRectangle = string;
    //    }else if ([self.currentElement isEqualToString:@"Font"]){
    //        self.person.Font = string;
    //    }else if ([self.currentElement isEqualToString:@"Margins"]){
    //        self.person.Margins = string;
    //    }else if ([self.currentElement isEqualToString:@"Text"]){
    //        self.person.Text = string;
    //    } else if ([self.currentElement isEqualToString:@"VertAlignment"]){
    //        self.person.VertAlignment = string;
    //    }
    
}

//解析完一个节点
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName{
    NSLog(@"333333--%@",elementName);
    
//    [_infoDic setValue:_str forKey:self.currentElement1];
//    if ([elementName isEqualToString:self.currentElement]) {
//        _isBeginRecord = YES;
//        [self.list addObject:_infoDic];
//    }
    //    self.currentElement = nil;
}

//解析结束
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"parserDidEndDocument...");
    NSMutableArray *arr = _analysisArray;
    NSLog(@"%@",arr);
    
    
}


@end
