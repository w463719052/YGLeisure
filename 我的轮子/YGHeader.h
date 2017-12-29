//
//  YGHeader.h
//  CloudShop-qpyun
//
//  Created by zccl2 on 16/3/10.
//  Copyright © 2016年 Wyg. All rights reserved.
//

#ifndef YGHeader_h
#define YGHeader_h

/**< 设备的物理宽度*/
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
/**< 设备的物理高度*/
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
/**< 当前View的宽度*/
#define ViewWidth self.bounds.size.width
/**< 当前View的高度*/
#define ViewHeight self.bounds.size.height

#define VERSION_IS_IOS8 ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)

#define IsiOS8System ((([[[UIDevice currentDevice] systemVersion] doubleValue]) >= 9.0)?YES:NO)

/**< 设置RGB颜色*/
#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define NAVBAR_BGCOLOR_2 RGBCOLOR(49,153, 215)
#define GRAY_BGCOLOR RGBCOLOR(243,243,243)

#define StatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height
#define TopBarHeight (StatusBarHeight+44.0f)

#define DEVICE_IS_IPHONEX ([[UIScreen mainScreen] bounds].size.height == 812)
#define BottomArcHeight ((DEVICE_IS_IPHONEX==1)?34.0f:0.0f)
#define TabbarHeight ((DEVICE_IS_IPHONEX==1)?83.0f:49.0f)

//数据中心
//正式
//#define TESTURL @"http://121.199.43.178:10003/appservice.asmx/Entrance"
///**< BeeCloud的注册id*/
//#define BeeCloudAppId @"4b2470fd-84f2-4f7f-9c58-e8e2bb214448"
///**< BeeCloud的注册Secret*/
//#define BeeCloudAppSecret @"128343d5-12d9-424c-9074-d0562413bc70"
//
//#define imageUpLoadURL @"http://121.199.43.178:10002/ashx/UploadUserImage.ashx"


///**< 微信注册Id*/
#define WeiXinAppId @"wx2d808f95af1caa51"


/**< 测试*/
#define TESTURL @"http://121.40.41.225:10001/appservice.asmx/Entrance"
#define BeeCloudAppId @"6f3ded6a-da9f-46d3-864a-b54e7f3a77d4"
#define BeeCloudAppSecret @"85ae5fe6-f729-4950-999d-fa85abd310b5"

#define imageUpLoadURL @"http://121.40.41.225:10005/ashx/UploadUserImage.ashx"

#endif /* YGHeader_h */
