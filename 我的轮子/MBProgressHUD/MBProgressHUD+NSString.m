//
//  MBProgressHUD+NSString.m
//  JianFaWuZiApp
//
//  Created by wzgs-imac on 15/5/28.
//  Copyright (c) 2015年 wzgs-imac. All rights reserved.
//

#import "MBProgressHUD+NSString.h"

@implementation MBProgressHUD (NSString)


+ (void)myShowTextOnly:(NSString *)title toView:(UIView *)view
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = title;
    hud.margin = 5.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:1];
}

+ (BOOL)myHideHUDForView:(UIView *)view animated:(BOOL)animated {
    MBProgressHUD *hud = [self HUDForView:view];
    if (hud != nil) {
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:animated];
        return YES;
    }
    return NO;
}

+ (void)myShowHUDAddedTo:(UIView *)view animated:(BOOL)animated {
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.removeFromSuperViewOnHide = YES;
    hud.labelText = @"正在加载...";
    [view addSubview:hud];
    [hud show:animated];
}
@end
