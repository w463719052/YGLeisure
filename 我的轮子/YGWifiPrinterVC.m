//
//  YGWifiPrinterVC.m
//  我的轮子
//
//  Created by zccl2 on 17/2/28.
//  Copyright © 2017年 com.zccl. All rights reserved.
//

#import "YGWifiPrinterVC.h"
#import "GCDAsyncSocket.h"

@interface YGWifiPrinterVC ()<GCDAsyncSocketDelegate>

@property (strong, nonatomic) UITextView *logTextView; //日志文本
@property (strong, nonatomic) UITextView *textView;


@property (nonatomic,strong) NSData *tmpData;
@property (nonatomic,strong) NSData *currentData;

@property (nonatomic,strong) GCDAsyncSocket *clientSocket;

@end

@implementation YGWifiPrinterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _logTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 50, 300, 150)];
    _logTextView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_logTextView];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 270, 300, 100)];
    _textView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_textView];
    
    UIButton *connectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    connectBtn.frame = CGRectMake(10, 390, 60, 40);
    connectBtn.backgroundColor = [UIColor blueColor];
    [connectBtn setTitle:@"连接" forState:UIControlStateNormal];
    [connectBtn addTarget:self action:@selector(connectBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:connectBtn];
    
    
    UIButton *sentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sentBtn.frame = CGRectMake(80, 390, 60, 40);
    sentBtn.backgroundColor = [UIColor blueColor];
    [sentBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sentBtn addTarget:self action:@selector(print:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sentBtn];
    
    UIButton *disconnectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    disconnectBtn.frame = CGRectMake(150, 390, 60, 40);
    disconnectBtn.backgroundColor = [UIColor blueColor];
    [disconnectBtn setTitle:@"断开" forState:UIControlStateNormal];
    [disconnectBtn addTarget:self action:@selector(socketDisconnect:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:disconnectBtn];
    
    
    _clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    // Do any additional setup after loading the view.
}

#pragma mark - 私有方法
//日志
- (void)writeToLog:(NSString *)str{
    //NSString * tmp = self.logTextView.text;
    self.logTextView.text = [NSString stringWithFormat:@"%@",str];
}


//发送字符
- (void)sentMsg:(NSString *)str{
    
    NSData *msgData = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    [_clientSocket writeData:msgData withTimeout:-1 tag:100];
    
    //把当前发送的数据保存起来
    _tmpData = msgData;
}

#pragma mark - 按钮方法
//连接打印机
- (void)connectBtn:(id)sender {
    // 1. 连接打印机
    // NSString *ip = @"192.168.0.1";
    if (![_clientSocket isConnected]) {
        NSString *ip = @"192.168.0.1";
        UInt16 port = 9100;
        [_clientSocket connectToHost:ip onPort:port withTimeout:30 error:nil];
        // 启动一个等待读操作
//        [_clientSocket readDataWithTimeout:-1 tag:600];
    }else{
        [self writeToLog:@"已经连接了打印机"];
    }
}

//发送消息
- (void)sentStr:(id)sender {
    if ([_clientSocket isConnected] == NO) {
        NSLog(@" 没有连接不能发消息");
        [self writeToLog:@" 没有连接不能发消息"];
        return;
    }
    // 必须要连接上才可以发送
    // 开始发送消息
    if ([self.textView.text isEqualToString:@""]) {
        [self writeToLog:@"文本为空 不能发送"];
        return;
    }
    [self sentMsg:[NSString stringWithFormat:@"%@",self.textView.text]];
}


//与打印机断开连接
- (void)socketDisconnect:(id)sender {
    if([_clientSocket isConnected]){
        [_clientSocket disconnect];
        [self writeToLog:@"已与打印机断开连接"];
    }
}

//开始打印
- (void)print:(id)sender {
    if ([_clientSocket isConnected] == NO) {
        NSLog(@" 没有连接不能发消息");
        [self writeToLog:@"没有连接不能发消息"];
        return;
    }
    // 必须要连接上才可以发送
    // 开始发送消息
    [self sentMsg:@"\n"];
}

//打开WIFI选择界面
- (void)selectWIFI:(id)sender {
    NSURL *url = [NSURL URLWithString:@"prefs:root=WIFI"];
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url];
    }
}

//设置粗体
- (void)btnSetFont:(id)sender {
    Byte byte1[2]={27,69};
    Byte byte2[2]={27,70};
    NSData *data1=[[NSData alloc]initWithBytes:byte1 length:2];
    NSData *data2=[[NSData alloc]initWithBytes:byte2 length:2];
    [_clientSocket writeData:data1 withTimeout:2 tag:0];
    [_clientSocket writeData:data2 withTimeout:2 tag:0];
}

//换页
- (void)nextPage:(id)sender {
    Byte byte1[1]={12};
    NSData *data1=[[NSData alloc]initWithBytes:byte1 length:1];
    [_clientSocket writeData:data1 withTimeout:2 tag:0];
}


#pragma mark - sockt代理方法
//已经发送成功
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag {
    if(tag == 100){
        _currentData = _tmpData;
        _tmpData = nil;
        NSString *tmp = [[NSString alloc]initWithData:_currentData encoding:NSUTF8StringEncoding];
        [self writeToLog:[NSString stringWithFormat:@"表示发送完成了 打印机接收到了 :%@",tmp]];
        NSLog(@"客户端 表示发送完成了 肯定对方接收到了");
    }
}

//已经读取成功
-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    NSString *s = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (tag == 600) {
        [self writeToLog:[NSString stringWithFormat:@"读到了一个打印机的响应 %@", s]];
        NSLog(@"读到了一个打印机的响应 %@", s);
    }
    // 循环的读数据
}

// 这个函数表示已经上了 代理函数
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    NSString * msg = [NSString stringWithFormat:@"客户端 连接上了 %@:%d",host, port];
    [self writeToLog:msg];
    NSLog(@"客户端 连接上了 %@:%d", host, port);
    [_clientSocket readDataWithTimeout:12 tag:600];
}


//连接失败
-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    NSString * msg = [NSString stringWithFormat:@"连接出错 %@", err];
    [self writeToLog:msg];
    NSLog(@"连接出错 %@", err);
    
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
