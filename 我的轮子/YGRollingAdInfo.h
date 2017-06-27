//
//  YGRollingAdInfo.h
//  keepCar
//
//  Created by zccl2 on 17/5/19.
//  Copyright © 2017年 zccl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YGRollingAdInfo : NSObject

@property (nonatomic,copy) NSString *type;/**<0表示默认系统图片1表示专属供应商推广图片*/
@property (nonatomic,copy) NSString *imageurl;/**<图片地址*/
@property (nonatomic,copy) NSString *linkurl;/**<跳转链接地址*/
@property (nonatomic,copy) NSString *times;/**<滚动间隔(没有给 你们就默认设置一个)。*/
@property (nonatomic,strong) UIImage *image;/**<图片*/

@end
