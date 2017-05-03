//
//  YGSilkTransformPcm.h
//  我的轮子
//
//  Created by zccl2 on 17/5/2.
//  Copyright © 2017年 com.zccl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YGSilkTransformPcm : NSObject


/**
 silk语音转换成pcm

 @param inFile 输入文件地址
 @param outFile 输出文件地址
 @return 是否成功
 */
+ (void)setDecoderWithInFile:(NSString *)inFile outFile:(NSString *)outFile scuccess:(void(^)(NSString *outFile))successBlock;

@end
