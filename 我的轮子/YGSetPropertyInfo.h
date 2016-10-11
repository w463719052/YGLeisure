//
//  YGSetPropertyInfo.h
//  我的轮子
//
//  Created by zccl2 on 16/10/11.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YGSetPropertyInfo : NSObject

@property (nonatomic,copy) NSString *identification;/**<标识*/
@property (nonatomic,copy) NSString *type;/**<类型*/
@property (nonatomic,copy) NSString *number;/**<数字*/
@property (nonatomic,copy) NSString *unit;/**<单位*/
@property (nonatomic,copy) NSString *custom;/**<自定义*/

@end
