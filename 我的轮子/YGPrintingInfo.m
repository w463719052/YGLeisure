//
//  YGPrintingInfo.m
//  我的轮子
//
//  Created by zccl2 on 17/2/22.
//  Copyright © 2017年 com.zccl. All rights reserved.
//

#import "YGPrintingInfo.h"

@implementation YGPrintingInfo

- (instancetype)init{
    self = [super init];
    if (self) {
        //获取事先准备好的XML文件
        NSBundle *b = [NSBundle mainBundle];
        NSString *path = [b pathForResource:@"2_25_100" ofType:@".mrt"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        self.par = [[NSXMLParser alloc]initWithData:data];
        //添加代理
        self.par.delegate = self;
        //初始化数组，存放解析后的数据
        self.list = [NSMutableArray arrayWithCapacity:5];
        _infoDic = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    return self;
}

//几个代理方法的实现，是按逻辑上的顺序排列的，但实际调用过程中中间三个可能因为循环等问题乱掉顺序
//开始解析
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"parserDidStartDocument...");
}
//准备节点
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict{
    
    self.currentElement1 = elementName;
    if (_isBeginRecord) {
        _isBeginRecord = NO;
        self.currentElement = elementName;
        _infoDic = [NSMutableDictionary dictionaryWithCapacity:10];
    }
//    if (!_isBeginRecord) {
//        [_infoDic setDictionary:attributeDict];
//    }
    if ([elementName isEqualToString:@"Components"]) {
        _isBeginRecord = YES;
//        [self.textArry addObject:self.currentElement];
//        self.list = [NSMutableArray arrayWithCapacity:10];
    }
//    if ([self.currentElement isEqualToString:@"ClientRectangle"]){
//        self.person = [[YGPrintingPerson alloc] init];
//    }
    
}
//获取节点内容
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    _str = string;
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
    [_infoDic setValue:_str forKey:self.currentElement1];
    if ([elementName isEqualToString:self.currentElement]) {
        _isBeginRecord = YES;
        [self.list addObject:_infoDic];
    }
//    self.currentElement = nil;
}

//解析结束
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"parserDidEndDocument...");
}

//外部调用接口
-(void)parse{
    [self.par parse];
}

@end
