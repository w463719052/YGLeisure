//
//  YGNewBluetoothPrintingVC.m
//  我的轮子
//
//  Created by zccl2 on 17/2/21.
//  Copyright © 2017年 com.zccl. All rights reserved.
//

#import "YGNewBluetoothPrintingVC.h"
#import "YGTool.h"
#import "TscCommand.h"
#import "BLKWrite.h"
#import "MyPeripheral.h"
#import "CBController.h"
#import "UIImage+Bitmap.h"
#import "YGPrintingSetingView.h"
#import "YGPrintingInfo.h"

@interface YGNewBluetoothPrintingVC ()
{
    UITableView *_tableView;
    DeviceInfo *_deviceInfo;/**< 设备信息*/
    MyPeripheral *_controlPeripheral;/**< 外部设备*/
    NSMutableArray *_connectedDeviceInfoArray;/**< 已连接的设备列表*/
    NSMutableArray *_connectingList;/**< 连接列表*/
    
}

@end

@implementation YGNewBluetoothPrintingVC

static id _instance;
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    YGPrintingInfo *info = [[YGPrintingInfo alloc] init];
    [info parse];
    [self setNavigationBarWithBackButton:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = RGBCOLOR(243, 243, 243);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    _connectionStatus = LE_STATUS_IDLE;
    _connectedDeviceInfoArray = [NSMutableArray new];
    _connectingList = [NSMutableArray new];
    _deviceInfo = [[DeviceInfo alloc] init];
}

#pragma mark 设置NavigationBar样式
- (void)setNavigationBarWithBackButton:(BOOL)isBackButton {
    /**< 导航条标题*/
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                              NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
    /**< 导航条背景颜色*/
    self.navigationController.navigationBar.barTintColor = RGBCOLOR(37, 37, 37);
    /**< 如果有返回按钮*/
    if (isBackButton) {
        [self setBackButton];
    }
    self.edgesForExtendedLayout = UIRectEdgeLeft | UIRectEdgeRight;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 60, 40);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightBtn setTitle:@"打印设置" forState:UIControlStateNormal];
    rightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}
#pragma mark 设置返回按钮
- (void)setBackButton {
    /**< 导航条按钮*/
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]
                                   initWithImage:[UIImage imageNamed:@"fanhui"]
                                   style:UIBarButtonItemStyleDone
                                   target:self
                                   action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftButton;
    /**< 导航条按钮颜色*/
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}
#pragma mark 返回上层
- (void)back {
    /**< 判断WebVC的navigationController里有多少viewController，如果1个则是pre*/
    if (self.navigationController.viewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark 设置
- (void)rightBtnClick {
    YGPrintingSetingView *printingSetingView = [YGPrintingSetingView buildInstance];
    [self.view addSubview:printingSetingView];
}

- (void)viewDidAppear:(BOOL)animated {
    if(_connectedDeviceInfoArray.count == 0) {
        [self configureTransparentServiceUUID:nil txUUID:nil rxUUID:nil];
        [self configureDeviceInformationServiceUUID:nil UUID2:nil];
    }
    //开始扫描外部设备
    [self startScan];
}
#pragma mark 开始扫描外部设备
- (void)startScan {
    [super startScan];
    if (_connectingList.count > 0) {
        for (int i=0; i< _connectingList.count; i++) {
            MyPeripheral *connectingPeripheral = _connectingList[0];
            if (connectingPeripheral.connectStaus == MYPERIPHERAL_CONNECT_STATUS_CONNECTING) {
                [devicesList addObject:connectingPeripheral];
            } else {
                [_connectingList removeObjectAtIndex:i];
            }
        }
    }
    _connectionStatus = LE_STATUS_SCANNING;
}

#pragma mark 停止扫描
- (void)stopScan {
    [super stopScan];
}
#pragma mark 发现设备的回调
- (void)updateDiscoverPeripherals {
    [super updateDiscoverPeripherals];
    [_tableView reloadData];
}
#pragma mark 断开连接的回调
- (void)updateMyPeripheralForDisconnect:(MyPeripheral *)myPeripheral {
    for (int idx =0; idx< [_connectedDeviceInfoArray count]; idx++) {
        DeviceInfo *tmpDeviceInfo = [_connectedDeviceInfoArray objectAtIndex:idx];
        if (tmpDeviceInfo.myPeripheral == myPeripheral) {
            [_connectedDeviceInfoArray removeObjectAtIndex:idx];
            break;
        }
    }
    for (int idx =0; idx< [_connectingList count]; idx++) {
        MyPeripheral *tmpPeripheral = [_connectingList objectAtIndex:idx];
        if (tmpPeripheral == myPeripheral) {
            [_connectingList removeObjectAtIndex:idx];
            break;
        }
    }
    [_tableView reloadData];
    if(_connectionStatus == LE_STATUS_SCANNING){
        [self stopScan];
        [self startScan];
        [_tableView reloadData];
    }
}
#pragma mark 连接设备的回调
- (void)updateMyPeripheralForNewConnected:(MyPeripheral *)myPeripheral {
    [[BLKWrite Instance] setPeripheral:myPeripheral];
    DeviceInfo *tmpDeviceInfo = [[DeviceInfo alloc]init];
    tmpDeviceInfo.myPeripheral = myPeripheral;
    tmpDeviceInfo.myPeripheral.connectStaus = myPeripheral.connectStaus;
    /*连接列表过滤*/
    bool b = FALSE;
    for (int idx =0; idx< [_connectedDeviceInfoArray count]; idx++) {
        DeviceInfo *tmpDeviceInfo = [_connectedDeviceInfoArray objectAtIndex:idx];
        if (tmpDeviceInfo.myPeripheral == myPeripheral) {
            b = TRUE;
            break;
        }
    }
    if (!b) {
        [_connectedDeviceInfoArray addObject:tmpDeviceInfo];
    }
    for (int idx =0; idx< [_connectingList count]; idx++) {
        MyPeripheral *tmpPeripheral = [_connectingList objectAtIndex:idx];
        if (tmpPeripheral == myPeripheral) {
            [_connectingList removeObjectAtIndex:idx];
            break;
        }
    }
    for (int idx =0; idx< [devicesList count]; idx++) {
        MyPeripheral *tmpPeripheral = [devicesList objectAtIndex:idx];
        if (tmpPeripheral == myPeripheral) {
            [devicesList removeObjectAtIndex:idx];
            break;
        }
    }
    [_tableView reloadData];
}
#pragma mark 断开连接按钮点击
- (void)actionButtonDisconnect:(UIButton *)sender {
    DeviceInfo *tmpDeviceInfo = [_connectedDeviceInfoArray objectAtIndex:sender.tag];
    [self disconnectDevice:tmpDeviceInfo.myPeripheral];
}
#pragma mark 取消连接按钮点击
- (void)actionButtonCancelConnect:(UIButton *)sender {
    MyPeripheral *tmpPeripheral = [devicesList objectAtIndex:sender.tag];
    tmpPeripheral.connectStaus = MYPERIPHERAL_CONNECT_STATUS_IDLE;
    [devicesList replaceObjectAtIndex:sender.tag withObject:tmpPeripheral];
    for (int idx =0; idx< [_connectingList count]; idx++) {
        MyPeripheral *tmpConnectingPeripheral = [_connectingList objectAtIndex:idx];
        if (tmpConnectingPeripheral == tmpPeripheral) {
            [_connectingList removeObjectAtIndex:idx];
            break;
        }
    }
    [self disconnectDevice:tmpPeripheral];
    [_tableView reloadData];
}


- (void)print {
    YGPrintingSetingView *view = [YGPrintingSetingView buildInstance];
    float width = [view.widthField.text floatValue];
    float height = [view.heightField.text floatValue];
    int totalColumn = [view.columnField.text intValue];
    int number = [view.numberField.text intValue];
    TscCommand *tscCmd = [[TscCommand alloc] init];
    [tscCmd setHasResponse:YES];
    /*
     一定会发送的设置项
     */
    [tscCmd addSize:width*totalColumn :height];//大小
    [tscCmd addGapWithM:1 withN:0];//间隔
    [tscCmd addReference:0
                        :0];/**< 原点坐标*/
    [tscCmd addSpeed:6];/**< 打印速度*/
    [tscCmd addDensity:8];/**< 打印浓度*/
    [tscCmd addDirection:1];/**< 打印方向*/
    [tscCmd addComonCommand];/**< 发送一些TSC的固定命令，在cls命令之前发送*/
    [tscCmd addCls];/**< 清除打印缓冲区*/
//    int row = 0;
    int column = 0;
    for (int i=0; i<totalColumn; i++) {
        NSArray *textArr = @[@"玻璃升降器L前336",@"10308290-033-6",@"EW",@"10308290-3",@"上海"];
        for (int i=0; i<textArr.count; i++) {
            [tscCmd addTextwithX:10+(width*8+10)*column
                           withY:10+i*((height*8-20)/textArr.count)
                        withFont:@"TSS24.BF2"
                    withRotation:0
                       withXscal:1.2
                       withYscal:1.2
                        withText:textArr[i]];
            [tscCmd addQRCode:width*8-110+(width*8+10)*column
                             :height*8-130
                             :@"H"
                             :4
                             :@"A"
                             :0
                             :@"https://www.baidu.com"];
        }
        if (column == totalColumn-1) {
//            row ++;
            column = 0;
        } else {
            column ++;
        }
    }
    [tscCmd addPrint:number :1];/**< 打印*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return [_connectedDeviceInfoArray count];
        case 1:
            return [devicesList count];
        default:
            return 0;
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    switch (indexPath.section) {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"connectedList"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"connectedList"];
            }
            DeviceInfo *tmpDeviceInfo = [_connectedDeviceInfoArray objectAtIndex:indexPath.row];
            cell.textLabel.text = tmpDeviceInfo.myPeripheral.advName;
            cell.detailTextLabel.text = @"已连接";
            UIButton *accessoryButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [accessoryButton addTarget:self action:@selector(actionButtonDisconnect:)  forControlEvents:UIControlEventTouchUpInside];
            accessoryButton.tag = indexPath.row;
            [accessoryButton setTitle:@"断开" forState:UIControlStateNormal];
            [accessoryButton setFrame:CGRectMake(0,0,70,35)];
            cell.accessoryView  = accessoryButton;
        }
            break;
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"devicesList"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"devicesList"];
            }
            MyPeripheral *tmpPeripheral = [devicesList objectAtIndex:indexPath.row];
            cell.textLabel.text = tmpPeripheral.advName;
            cell.detailTextLabel.text = @"";
            cell.accessoryView = nil;
            if (tmpPeripheral.connectStaus == MYPERIPHERAL_CONNECT_STATUS_CONNECTING) {
                cell.detailTextLabel.text = @"连接中";
                UIButton *accessoryButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                [accessoryButton addTarget:self action:@selector(actionButtonCancelConnect:)  forControlEvents:UIControlEventTouchUpInside];
                accessoryButton.tag = indexPath.row;
                [accessoryButton setTitle:@"取消" forState:UIControlStateNormal];
                [accessoryButton setFrame:CGRectMake(0,0,70,35)];
                cell.accessoryView  = accessoryButton;
            }
            if (cell.textLabel.text == nil)
                cell.textLabel.text = @"无";
        }
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = nil;
    switch (section) {
        case 0:
            title = @"已连接设备(点击名称进行打印):";
            break;
        case 1:
            title = @"未连接设备(点击名称进行连接):";
            break;
        default:
            break;
    }
    return title;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            _deviceInfo = [_connectedDeviceInfoArray objectAtIndex:indexPath.row];
            _controlPeripheral = _deviceInfo.myPeripheral;
            [self stopScan];
            _connectionStatus = LE_STATUS_IDLE;
            [self print];
        }
            break;
        case 1:
        {
            if ((devicesList.count != 0) && devicesList.count > indexPath.row) {
                MyPeripheral *tmpPeripheral = [devicesList objectAtIndex:indexPath.row];
                if (tmpPeripheral.connectStaus != MYPERIPHERAL_CONNECT_STATUS_IDLE) {
                    break;
                }
                [self connectDevice:tmpPeripheral];
                tmpPeripheral.connectStaus = MYPERIPHERAL_CONNECT_STATUS_CONNECTING;
                [devicesList replaceObjectAtIndex:indexPath.row withObject:tmpPeripheral];
                [_connectingList addObject:tmpPeripheral];
                [_tableView reloadData];
            }
            break;
        }
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
