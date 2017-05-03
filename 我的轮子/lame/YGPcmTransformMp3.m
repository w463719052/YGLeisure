//
//  YGPcmTransformMp3.m
//  我的轮子
//
//  Created by zccl2 on 17/5/2.
//  Copyright © 2017年 com.zccl. All rights reserved.
//

#import "YGPcmTransformMp3.h"
#include "lame.h"
#include <stdio.h>

@implementation YGPcmTransformMp3

+ (void)audio_PCMtoMP3WithInFile:(NSString *)inFile outFile:(NSString *)outFile scuccess:(void(^)(NSString *outFile))successBlock
{
    @try {
        size_t read;
        int write;
        
        FILE *pcm = fopen([inFile UTF8String], "rb");  //source 被转换的音频文件位置
        if( pcm == NULL ) {
            return;
        }
        fseek(pcm, 4*1024, SEEK_CUR);                                   //skip file header
        FILE *mp3 = fopen([outFile UTF8String], "wb");  //output 输出生成的Mp3文件位置
        if( mp3 == NULL ) {
            return;
        }
        const int PCM_SIZE = 8192;
        const int MP3_SIZE = 8192;
        short int pcm_buffer[PCM_SIZE*2];
        unsigned char mp3_buffer[MP3_SIZE];
        
        lame_t lame = lame_init();
        lame_set_in_samplerate(lame, 11025.0);
        lame_set_VBR(lame, vbr_default);
        lame_init_params(lame);
        
        do {
            read = fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
            if (read == 0)
                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
            else
                write = lame_encode_buffer_interleaved(lame, pcm_buffer, (int)read, mp3_buffer, MP3_SIZE);
            
            fwrite(mp3_buffer, write, 1, mp3);
            
        } while (read != 0);
        
        lame_close(lame);
        fclose(mp3);
        fclose(pcm);
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[exception description]);
    }
    @finally {
        if (successBlock) {
            successBlock(outFile);
        }
    }
}


@end
