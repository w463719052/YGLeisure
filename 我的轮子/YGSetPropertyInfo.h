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


@property (nonatomic,copy) NSString *plainText;/**< 普通标注*/
@property (nonatomic,copy) NSString *holeIdentification;/**< 孔标识*/
@property (nonatomic,copy) NSString *holeStyle;/**< 孔样式*/
@property (nonatomic,copy) NSString *holeNumber;/**< 孔数*/
@property (nonatomic,copy) NSString *holeDiameter;/**< 孔直径*/

@property (nonatomic,copy) NSString *toothIdentification;/**< 齿标识*/
@property (nonatomic,copy) NSString *toothNumber;/**< 齿数*/
@property (nonatomic,copy) NSString *toothDiameter;/**< 齿径*/
@property (nonatomic,copy) NSString *toothThick;/**< 齿厚*/
@property (nonatomic,copy) NSString *toothStyle;/**< 齿样式*/

@property (nonatomic,copy) NSString *voltage;/**< 电压*/
@property (nonatomic,copy) NSString *current;/**< 电流*/
@property (nonatomic,copy) NSString *power;/**< 功率*/

@end
