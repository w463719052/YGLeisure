//
//  YGPcmTransformMp3.h
//  我的轮子
//
//  Created by zccl2 on 17/5/2.
//  Copyright © 2017年 com.zccl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YGPcmTransformMp3 : NSObject


/**
 pcm 转 MP3

 @param inFile 输入的pcm文件路径
 @param outFile 输出的MP3文件路径
 @param successBlock 成功block
 */
+ (void)audio_PCMtoMP3WithInFile:(NSString *)inFile outFile:(NSString *)outFile scuccess:(void(^)(NSString *outFile))successBlock;

@end
