//
//  YGSoundRecordingVC.m
//  我的轮子
//
//  Created by zccl2 on 16/7/25.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import "YGSoundRecordingVC.h"
#import <AVFoundation/AVFoundation.h>

@interface YGSoundRecordingVC ()
{
    AVAudioRecorder *_recorder;/**< 录音器*/
}
@end

@implementation YGSoundRecordingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    /**< 真机测试解决无法录音问题*/
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
    {
        //7.0第一次运行会提示，是否允许使用麦克风
        AVAudioSession *session = [AVAudioSession sharedInstance];
        NSError *sessionError;
        //AVAudioSessionCategoryPlayAndRecord用于录音和播放
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
        if(session == nil)
            NSLog(@"Error creating session: %@", [sessionError description]);
        else
            [session setActive:YES error:nil];
    }
    
    if (!_recorder) {
        
        NSString *tempPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/tempPath"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:tempPath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:tempPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        tempPath = [tempPath stringByAppendingPathComponent:@"tempAudio.m4a"];
        NSURL *tempPathURL = [NSURL fileURLWithPath:tempPath];
        //录音设置字典，设置录音格式为m4a，设置采样频率为22050.0，设置音频通道为1，设置录音质量为最低
        NSMutableDictionary *recordSetting = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                              [NSNumber numberWithInt:kAudioFormatMPEG4AAC], AVFormatIDKey,
                                              [NSNumber numberWithFloat:22050.0], AVSampleRateKey,
                                              [NSNumber numberWithInt:1], AVNumberOfChannelsKey,
                                              [NSNumber numberWithInt:AVAudioQualityMin], AVEncoderAudioQualityKey,
                                              [NSNumber numberWithInt:AVAudioQualityMin], AVSampleRateConverterAudioQualityKey,
                                              [NSNumber numberWithInt:8], AVLinearPCMBitDepthKey,
                                              [NSNumber numberWithInt:8],
                                              AVEncoderBitDepthHintKey,
                                              nil];
        _recorder = [[AVAudioRecorder alloc] initWithURL:tempPathURL settings:recordSetting error:nil];
    }
    [_recorder prepareToRecord];
    [_recorder setMeteringEnabled:YES];
    [_recorder record];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
