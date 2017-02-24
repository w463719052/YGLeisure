//
//  YGNewMainVC.m
//  我的轮子
//
//  Created by zccl2 on 16/12/5.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import "YGNewMainVC.h"
#import "YGCommunityTopScrollerView.h"
#import "YGHeader.h"

@interface YGNewMainVC ()
{
    YGCommunityTopScrollerView *_topView;
    UICollectionView *collectionView;
}
@end

@implementation YGNewMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarWithBackButton:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *array = @[[UIImage imageNamed:@"image1"],[UIImage imageNamed:@"image2"],[UIImage imageNamed:@"image3"]];
    if (!_topView) {
        _topView = [[YGCommunityTopScrollerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 120) rollPictureArray:array];
        _topView.backgroundColor = [UIColor redColor];
        [self.view addSubview:_topView];
    }
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    lbl.text = @"ajdajslkdjalksdjlajslkdjaklsdjklajklsdjsakljdklasjdklsa";
    lbl.lineBreakMode = NSLineBreakByClipping;
    [self.view addSubview:lbl];
    NSLog(@"%@",lbl.text);
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_topView startTimer];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_topView stopTimer];
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
