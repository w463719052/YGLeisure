//
//  YGLogisticsInformationVC.m
//  我的轮子
//
//  Created by zccl2 on 16/7/8.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import "YGLogisticsInformationVC.h"
#import "YGLogisticsInformationInfo.h"
#import "YGLogisticsInformationCell.h"
#import "YGLogisticsInformationDetailCell.h"
#import "YGHeader.h"

@interface YGLogisticsInformationVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    YGLogisticsInformationInfo *_logisticsInfo;
    NSMutableArray *_infoArray;
    CGSize _textViewSize;
}
@end

@implementation YGLogisticsInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarWithBackButton:YES];
    self.edgesForExtendedLayout = UIRectEdgeLeft | UIRectEdgeRight;
    self.title = @"物流";
    self.view.backgroundColor = [UIColor whiteColor];
    [self addContentView];
    [self getLogisticsInfo];
    // Do any additional setup after loading the view.
}

- (void)addContentView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.bounces = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)getLogisticsInfo {
    _logisticsInfo = [[YGLogisticsInformationInfo alloc] init];
    _logisticsInfo.string1 = @"已签收";
    _logisticsInfo.string2 = @"申通速递";
    _logisticsInfo.string3 = @"22100655848";
    _logisticsInfo.string4 = @"95543";
    _logisticsInfo.string5 = @"";
    
    _infoArray  = [NSMutableArray arrayWithArray:@[@"【厦门市】已签收，签收人是本人，感谢您使用申通快递，期待再次为您服务。\n2016-04-27 17:28:49",@"【厦门市】福建厦门海沧生活区派件员：天心岛部18059204567正在为您派件。\n2016-04-27 17:28:49",@"【福建省厦门市海沧生活区】已收入。\n2016-04-27 17:28:49",@"【上海市】上海青浦公司 已发出。\n2016-04-27 17:28:49",@"商家正通知快递公司揽件。\n2016-04-27 17:28:49",@"您的包裹已出库。\n2016-04-27 17:28:49",@"您的待配货。\n2016-04-27 17:28:49"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return _infoArray.count;
    }
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 30;
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 8;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *cellIdentifier=@"MyCell";
        YGLogisticsInformationCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell=[[YGLogisticsInformationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellEditingStyleNone;
        }
        [cell setContentViewInfo:_logisticsInfo];
        return cell;
    } else {
        static NSString *cellIdentifier=@"MyCell1";
        YGLogisticsInformationDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell=[[YGLogisticsInformationDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellEditingStyleNone;
        }
        if (indexPath.row == 0) {
            cell.circleView.backgroundColor = [UIColor greenColor];
            cell.testView.color = [UIColor greenColor];
            cell.topLayer.hidden = YES;
        } else {
            cell.circleView.backgroundColor = [UIColor lightGrayColor];
            cell.testView.color = [UIColor darkGrayColor];
            cell.topLayer.hidden = NO;
        }
        [cell.testView setAttributedStringWithString:_infoArray[indexPath.row]];
        CGSize size = [cell.testView adaptiveDimension];
        _textViewSize = size;
        CGRect frame = cell.testView.frame;
        frame.size.height = size.height;
        cell.testView.frame = frame;
        [cell addLayerViewWithHeight:size.height];
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, ScreenWidth-30, 30)];
        label.text = @"物流跟踪";
        label.font = [UIFont systemFontOfSize:14];
        [view addSubview:label];
        UIView *layer = [[UIView alloc] initWithFrame:CGRectMake(15, 30, ScreenWidth-30, 1)];
        layer.backgroundColor = RGBCOLOR(233, 233, 233);
        [view addSubview:layer];
        return view;
    } else {
        return nil;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100;
    } else {
        return _textViewSize.height+20;
    }
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
