//
//  YGPrintingInfo.h
//  我的轮子
//
//  Created by zccl2 on 17/2/22.
//  Copyright © 2017年 com.zccl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YGPrintingPerson.h"

@interface YGPrintingInfo : NSObject<NSXMLParserDelegate>
//添加属性
@property (nonatomic, strong) NSXMLParser *par;
@property (nonatomic, strong) YGPrintingPerson *person;
@property (nonatomic, strong) NSMutableDictionary *infoDic;
//存放每个person
@property (nonatomic, strong) NSMutableArray *list;
//标记当前标签，以索引找到XML文件内容
@property (nonatomic, copy) NSString *currentElement;

@property (nonatomic, copy) NSString *currentElement1;

@property (nonatomic,assign) BOOL isBeginRecord;
@property (nonatomic, copy) NSString *str;


//声明parse方法，通过它实现解析
-(void)parse;

@end
