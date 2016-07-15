//
//  YGTool.m
//  CloudShop-qpyun
//
//  Created by zccl2 on 16/3/17.
//  Copyright © 2016年 Wyg. All rights reserved.
//

#import "YGTool.h"

@implementation YGTool
#pragma mark 获取当地时间
/**
 *  获取当地日期
 */
+(NSString *)getCurrentDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    //获得当前时间的年月日时分
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    NSString *nowDate = [NSString stringWithFormat:@"%ld-%ld-%ld %02ld:%02ld:%02ld",(long)nowCmps.year,(long)nowCmps.month,(long)nowCmps.day,(long)nowCmps.hour,(long)nowCmps.minute,(long)nowCmps.second];
    return nowDate;
}

#pragma mark 判断字符串是否为空
+ (BOOL)isBlankString:(NSString *)string {
    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if ([string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        return YES;
    }
    return NO;
}

#pragma mark 保存是否第一次使用
+ (void)setSaveIsOnesUse:(NSString *)isOnesUse {
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setObject:isOnesUse forKey:@"isOnesUse"];
    [userdefaults synchronize];
}
+(NSString *)getIsOnesUse {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"isOnesUse"];
}

@end
