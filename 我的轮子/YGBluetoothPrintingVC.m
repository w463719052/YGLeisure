//
//  YGBluetoothPrintingVC.m
//  我的轮子
//
//  Created by zccl2 on 17/2/17.
//  Copyright © 2017年 com.zccl. All rights reserved.
//

#import "YGBluetoothPrintingVC.h"
#import "YGTool.h"
#import "TscCommand.h"
#import "BLKWrite.h"
#import "MyPeripheral.h"

@interface YGBluetoothPrintingVC ()<CBCentralManagerDelegate,UITableViewDataSource,UITableViewDelegate,CBPeripheralDelegate>
{
    UITableView *_tableView;
    CBCentralManager *_manager;
    NSMutableArray *_bluetoothArray;
    NSMutableArray *_characterArray;
    CBCharacteristic *_chatacter;
    CBPeripheral *_peripheral;
}
@end

@implementation YGBluetoothPrintingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarWithBackButton:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *bluetoothButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bluetoothButton.frame = CGRectMake(20, 10, 100, 40);
    bluetoothButton.backgroundColor = [UIColor redColor];
    [bluetoothButton addTarget:self action:@selector(bluetoothButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bluetoothButton];
    
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleButton.frame = CGRectMake(200, 10, 100, 40);
    cancleButton.backgroundColor = [UIColor redColor];
    [cancleButton addTarget:self action:@selector(cancleButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancleButton];
    
    _manager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bluetoothButton.frame)+10, ScreenWidth, ScreenHeight-64-(CGRectGetMaxY(bluetoothButton.frame)+10)) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = RGBCOLOR(243, 243, 243);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    
    // Do any additional setup after loading the view.
}

- (void)bluetoothButtonPress:(UIButton *)send {
    [_bluetoothArray removeAllObjects];
    [_manager scanForPeripheralsWithServices:nil options:nil];
}

- (void)cancleButtonPress:(UIButton *)send {
    [_manager cancelPeripheralConnection:_peripheral];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    NSLog(@"%@",central);
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
            NSLog(@"打开，可用");
            [_manager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@(NO)}];
            break;
        case CBCentralManagerStatePoweredOff:
            NSLog(@"可用，未打开");
            break;
        case CBCentralManagerStateUnsupported:
            NSLog(@"SDK不支持");
            break;
        case CBCentralManagerStateUnauthorized:
            NSLog(@"程序未授权");
            break;
        case CBCentralManagerStateResetting:
            NSLog(@"CBCentralManagerStateResetting");
            break;
        case CBCentralManagerStateUnknown:
            NSLog(@"CBCentralManagerStateUnknown");
            break;
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI {
    if (peripheral.name.length <= 0) {
        return ;
    }
    if (!_bluetoothArray) {
        _bluetoothArray = [NSMutableArray arrayWithCapacity:10];
    }
    [_bluetoothArray addObject:peripheral];
    [_tableView reloadData];
}


#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _bluetoothArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MyCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
    }
    id info = _bluetoothArray[indexPath.row];
    if ([info isKindOfClass:[CBPeripheral class]]) {
        CBPeripheral *peripheral = (CBPeripheral *)info;
        cell.textLabel.text = peripheral.name;
        
    } else if ([info isKindOfClass:[CBCharacteristic class]]) {
        CBCharacteristic *character = info;
        cell.textLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)character.properties];
    }
    return cell;
}


#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id info = _bluetoothArray[indexPath.row];
    if ([info isKindOfClass:[CBPeripheral class]]) {
        _peripheral = _bluetoothArray[indexPath.row];
        // 连接某个蓝牙外设
        [_manager connectPeripheral:_peripheral options:nil];
        // 设置外设的代理是为了后面查询外设的服务和外设的特性，以及特性中的数据。
        [_peripheral setDelegate:self];
        // 既然已经连接到某个蓝牙了，那就不需要在继续扫描外设了
        [_manager stopScan];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    } else if ([info isKindOfClass:[CBCharacteristic class]]) {
        _chatacter = info;
        [self printWithPeripheral:_peripheral];
    }
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"连接成功");
    // 连接成功后，查找服务
    [peripheral discoverServices:nil];
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error
{
    NSLog(@"连接失败");
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error
{
    NSString *UUID = [peripheral.identifier UUIDString];
    NSLog(@"didDiscoverServices:%@",UUID);
    if (error) {
        NSLog(@"出错");
        return;
    }
    
    CBUUID *cbUUID = [CBUUID UUIDWithString:UUID];
    NSLog(@"cbUUID:%@",cbUUID);
    
    for (CBService *service in peripheral.services) {
        NSLog(@"service:%@",service.UUID);
        //如果我们知道要查询的特性的CBUUID，可以在参数一中传入CBUUID数组。
        [peripheral discoverCharacteristics:nil forService:service];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(nullable NSError *)error
{
    if (error) {
        NSLog(@"出错");
        return;
    }
    
    for (CBCharacteristic *character in service.characteristics) {
        // 这是一个枚举类型的属性
        [_bluetoothArray addObject:character];
        CBCharacteristicProperties properties = character.properties;
        if (properties & CBCharacteristicPropertyBroadcast) {
            //如果是广播特性
        }
        
        if (properties & CBCharacteristicPropertyRead) {
            //如果具备读特性，即可以读取特性的value
            [peripheral readValueForCharacteristic:character];
        }
        
        if (properties & CBCharacteristicPropertyWriteWithoutResponse) {
            //如果具备写入值不需要响应的特性
            //这里保存这个可以写的特性，便于后面往这个特性中写数据
//            _chatacter = character;
            
        }
        
        if (properties & CBCharacteristicPropertyWrite) {
            //如果具备写入值的特性，这个应该会有一些响应
            NSLog(@"%@",character);
        }
        
        if (properties & CBCharacteristicPropertyNotify) {
            //如果具备通知的特性，无响应
            [peripheral setNotifyValue:YES forCharacteristic:character];
        }
        [_tableView reloadData];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error {
    NSLog(@"didWriteValueForCharacteristic:%@",peripheral.services);
    
    if (error) {
        NSLog(@"didWriteValueForCharacteristic error：%@",[error localizedDescription]);
    }
    
//    [peripheral readValueForCharacteristic:characteristic]; //12.23新增
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    NSLog(@"didWriteValueForCharacteristic:%@",[characteristic.UUID UUIDString]);
    
    if (error) {
        NSLog(@"didWriteValueForCharacteristic error：%@",[error localizedDescription]);
    }
    
    [peripheral readValueForCharacteristic:characteristic]; //12.23新增
}


- (void)printWithPeripheral:(CBPeripheral *)peripheral {
    MyPeripheral *myPeripheral = [[MyPeripheral alloc] init];
    myPeripheral.peripheral = peripheral;
    myPeripheral.transparentDataWriteChar = _chatacter;
    myPeripheral.advName = peripheral.name;
    myPeripheral.canSendData = YES;
    [[BLKWrite Instance] setPeripheral:myPeripheral];
    BLKWrite *blw = [BLKWrite Instance];
    [blw setBWiFiMode:NO];
//    blw.connectedPeripheral = myPeripheral;
    [blw setConnectedPeripheral:myPeripheral];
    TscCommand *tscCmd = [[TscCommand alloc] init];
    [tscCmd setHasResponse:YES];
    /*
     一定会发送的设置项
     */
    //Size
    
    [tscCmd addSize:50 :30];
    
    //GAP
    [tscCmd addGapWithM:2   withN:0];
    
    //REFERENCE
    [tscCmd addReference:24
                        :24];
    
    //SPEED
    [tscCmd addSpeed:4];
    
    //DENSITY
    
    [tscCmd addDensity:8];
    
    //DIRECTION
    [tscCmd addDirection:0];
    
    //fixed command
    [tscCmd addComonCommand];
    [tscCmd addCls];
    
    //unit
    /*
     打印多行标签文本
     */
    
    for (int i=0; i<2;i++) {
        
        [tscCmd addTextwithX:24
                       withY:(24+i*24)
                    withFont:@"TSS24.BF2"
                withRotation:0
                   withXscal:1
                   withYscal:1
                    withText:@"汽配云（测试）"];
    }
    
    //print
    [tscCmd addPrint:1 :1];
    //    UIImage *newImage = [UIImage imageNamed:@"logo2.png"];
    //    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"tscpic.rtf"];
    //    NSData *tmpData = [NSData dataWithContentsOfFile: path];
    //
    //    NSData *data = UIImageJPEGRepresentation(newImage, 0.5);
    //    // 2.设置图片
    ////    UIImage *newImage = [pic imageWithscaleMaxWidth:120];
    ////        newImage = [newImage blackAndWhiteImage];
    //    CGSize sia = newImage.size;
    ////
    //    NSData *imageData = [newImage bitmapData];
    //    NSMutableData *data1 = [[NSMutableData alloc] initWithCapacity:0];
    ////    [data1 appendBytes:[self convertUIImageToBitmapRGBA8:newImage] length:1800];
    //
    //    [data1 appendBytes:[self convertUIImageToBitmapRGBA8:newImage] length:data.length*2];
    //    [tscCmd addBitmapwithX:0 withY:0 withWidth:newImage.size.width/8 withHeight:newImage.size.height withMode:0 withData:data1];
}
- (unsigned char *) convertUIImageToBitmapRGBA8:(UIImage *) image {
    
    CGImageRef imageRef = image.CGImage;
    
    // Create a bitmap context to draw the uiimage into
    CGContextRef context = [self newBitmapRGBA8ContextFromImage:imageRef];
    
    if(!context) {
        return NULL;
    }
    
    size_t width = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    CGRect rect = CGRectMake(0, 0, width, height);
    
    // Draw image into the context to get the raw image data
    CGContextDrawImage(context, rect, imageRef);
    
    // Get a pointer to the data
    unsigned char *bitmapData = (unsigned char *)CGBitmapContextGetData(context);
    
    // Copy the data and release the memory (return memory allocated with new)
    size_t bytesPerRow = CGBitmapContextGetBytesPerRow(context);
    size_t bufferLength = bytesPerRow * height;
    
    unsigned char *newBitmap = NULL;
    
    if(bitmapData) {
        newBitmap = (unsigned char *)malloc(sizeof(unsigned char) * bytesPerRow * height);
        
        if(newBitmap) {    // Copy the data
            for(int i = 0; i < bufferLength; ++i) {
                newBitmap[i] = bitmapData[i];
            }
        }
        
        free(bitmapData);
        
    } else {
        NSLog(@"Error getting bitmap pixel data\n");
    }
    
    CGContextRelease(context);
    
    return newBitmap;
}

- (CGContextRef) newBitmapRGBA8ContextFromImage:(CGImageRef) image {
    CGContextRef context = NULL;
    CGColorSpaceRef colorSpace;
    uint32_t *bitmapData;
    
    size_t bitsPerPixel = 32;
    size_t bitsPerComponent = 8;
    size_t bytesPerPixel = bitsPerPixel / bitsPerComponent;
    
    size_t width = CGImageGetWidth(image);
    size_t height = CGImageGetHeight(image);
    
    size_t bytesPerRow = width * bytesPerPixel;
    size_t bufferLength = bytesPerRow * height;
    
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    if(!colorSpace) {
        NSLog(@"Error allocating color space RGB\n");
        return NULL;
    }
    
    // Allocate memory for image data
    bitmapData = (uint32_t *)malloc(bufferLength);
    
    if(!bitmapData) {
        NSLog(@"Error allocating memory for bitmap\n");
        CGColorSpaceRelease(colorSpace);
        return NULL;
    }
    
    //Create bitmap context
    
    context = CGBitmapContextCreate(bitmapData,
                                    width,
                                    height,
                                    bitsPerComponent,
                                    bytesPerRow,
                                    colorSpace,
                                    kCGImageAlphaPremultipliedLast);    // RGBA
    if(!context) {
        free(bitmapData);
        NSLog(@"Bitmap context not created");
    }
    
    CGColorSpaceRelease(colorSpace);
    
    return context;
}

- (UIImage *) convertBitmapRGBA8ToUIImage:(unsigned char *) buffer
                                withWidth:(int) width
                               withHeight:(int) height {
    
    
    size_t bufferLength = width * height * 4;
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, buffer, bufferLength, NULL);
    size_t bitsPerComponent = 8;
    size_t bitsPerPixel = 32;
    size_t bytesPerRow = 4 * width;
    
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    if(colorSpaceRef == NULL) {
        NSLog(@"Error allocating color space");
        CGDataProviderRelease(provider);
        return nil;
    }
    
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    
    CGImageRef iref = CGImageCreate(width,
                                    height,
                                    bitsPerComponent,
                                    bitsPerPixel,
                                    bytesPerRow,
                                    colorSpaceRef,
                                    bitmapInfo,
                                    provider,    // data provider
                                    NULL,        // decode
                                    YES,            // should interpolate
                                    renderingIntent);
    
    uint32_t* pixels = (uint32_t*)malloc(bufferLength);
    
    if(pixels == NULL) {
        NSLog(@"Error: Memory not allocated for bitmap");
        CGDataProviderRelease(provider);
        CGColorSpaceRelease(colorSpaceRef);
        CGImageRelease(iref);
        return nil;
    }
    
    CGContextRef context = CGBitmapContextCreate(pixels,
                                                 width,
                                                 height,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpaceRef,
                                                 bitmapInfo);
    
    if(context == NULL) {
        NSLog(@"Error context not created");
        free(pixels);
    }
    
    UIImage *image = nil;
    if(context) {
        
        CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, width, height), iref);
        
        CGImageRef imageRef = CGBitmapContextCreateImage(context);
        
        // Support both iPad 3.2 and iPhone 4 Retina displays with the correct scale
        if([UIImage respondsToSelector:@selector(imageWithCGImage:scale:orientation:)]) {
            float scale = [[UIScreen mainScreen] scale];
            image = [UIImage imageWithCGImage:imageRef scale:scale orientation:UIImageOrientationUp];
        } else {
            image = [UIImage imageWithCGImage:imageRef];
        }
        
        CGImageRelease(imageRef);
        CGContextRelease(context);
    }
    
    CGColorSpaceRelease(colorSpaceRef);
    CGImageRelease(iref);
    CGDataProviderRelease(provider);
    
    if(pixels) {
        free(pixels);
    }
    return image;
}



@end
