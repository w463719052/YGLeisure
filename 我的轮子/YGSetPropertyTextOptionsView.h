//
//  YGSetPropertyTextOptionsView.h
//  我的轮子
//
//  Created by zccl2 on 16/10/19.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGSetPropertyTextOptionsView : UIView <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,copy) void (^cellPress)(NSString *text);

@end
