//
//  MBProgressHUD+NSString.h
//  JianFaWuZiApp
//
//  Created by wzgs-imac on 15/5/28.
//  Copyright (c) 2015年 wzgs-imac. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (NSString)
+ (BOOL)myHideHUDForView:(UIView *)view animated:(BOOL)animated;
+ (void)myShowHUDAddedTo:(UIView *)view animated:(BOOL)animated;
+ (void)myShowTextOnly:(NSString *)title toView:(UIView *)view;
@end
