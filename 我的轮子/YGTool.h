//
//  YGTool.h
//  CloudShop-qpyun
//
//  Created by zccl2 on 16/3/17.
//  Copyright © 2016年 Wyg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YGHeader.h"

@interface YGTool : NSObject
/**
 *  获取当地日期
 */
+(NSString *)getCurrentDate;
/**
 *  判断字符串是否为空
 *
 *  @param string 需要判断的字符串
 *
 *  @return 是否为空
 */
+ (BOOL)isBlankString:(NSString *)string;
/**< 保存和读取是否第一次登入*/
+ (void)setSaveIsOnesUse:(NSString *)isOnesUse;
+ (NSString *)getIsOnesUse;

@end
