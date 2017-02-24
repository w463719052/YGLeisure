//
//  YGNewBluetoothPrintingVC.h
//  我的轮子
//
//  Created by zccl2 on 17/2/21.
//  Copyright © 2017年 com.zccl. All rights reserved.
//

#import "YGBaseViewController.h"
#import "CBController.h"
#import "DeviceInfo.h"
#import <UIKit/UIKit.h>

@interface YGNewBluetoothPrintingVC : CBController<UITableViewDataSource, UITextViewDelegate, UITableViewDelegate>

@property (assign) int connectionStatus;

+ (instancetype)sharedInstance;

@end
