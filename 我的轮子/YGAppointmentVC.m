//
//  YGAppointmentVC.m
//  我的轮子
//
//  Created by zccl2 on 17/3/20.
//  Copyright © 2017年 com.zccl. All rights reserved.
//

#import "YGAppointmentVC.h"
#import "YGSilkTransformPcm.h"
#import <AVFoundation/AVFoundation.h>
#import "YGPcmTransformMp3.h"
#import "YGTool.h"

@interface YGAppointmentVC ()
{
    
}
@property (nonatomic,strong) UILabel *messageLbl;
@end

@implementation YGAppointmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarWithBackButton:YES];
    [self addContentView];
    // Do any additional setup after loading the view.
}
#pragma mark 界面设置
- (void)addContentView {
    _messageLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, ScreenWidth, 50)];
    _messageLbl.textColor = [UIColor redColor];
    _messageLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_messageLbl];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((ScreenWidth-100)/2, CGRectGetMaxY(_messageLbl.frame)+20, 100, 50);
    button.backgroundColor = [UIColor purpleColor];
    [button setTitle:@"转换" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UIButton *playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    playButton.frame = CGRectMake(CGRectGetMinX(button.frame), CGRectGetMaxY(button.frame)+20, 100, 50);
    playButton.backgroundColor = [UIColor greenColor];
    [playButton setTitle:@"播放" forState:UIControlStateNormal];
    [playButton addTarget:self action:@selector(playWith) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playButton];
    
}
#pragma mark 转换
- (void)change {
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/tempPath"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *silkFile = [filePath stringByAppendingPathComponent:@"cs.silk"];
    NSString *pcmFile = [filePath stringByAppendingPathComponent:@"csp.pcm"];
    NSString *mp3File = [filePath stringByAppendingPathComponent:@"csm.m4a"];
    
    [YGSilkTransformPcm setDecoderWithInFile:silkFile outFile:pcmFile scuccess:^(NSString *outFile) {
        __weak typeof(self) thisVC = self;
        [YGPcmTransformMp3 audio_PCMtoMP3WithInFile:outFile outFile:mp3File scuccess:^(NSString *outFile) {
            thisVC.messageLbl.text = @"转换成功";
        }];
    }];
}
#pragma mark 播放
- (void)playWith {
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/tempPath"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *mp3File = [filePath stringByAppendingPathComponent:@"csm.m4a"];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:mp3File] error:nil];
    [player prepareToPlay];
    [player play];
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
