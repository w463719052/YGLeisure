//
//  YGSVGAnalysisInfo.h
//  我的轮子
//
//  Created by qpy2 on 2017/12/15.
//  Copyright © 2017年 com.zccl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YGSVGAnalysisInfo : NSObject

@property (nonatomic,strong) NSDictionary *pointDic;/**< 对应的位置信息*/
@property (nonatomic,copy) NSString *number;/**<标识*/
@property (nonatomic,assign) BOOL isSelect;/**<是否选择*/
@property (nonatomic) NSIndexPath *indexPath;

@end
