//
//  YGSVGAnalysisView.h
//  qpy
//
//  Created by qpy2 on 2017/12/7.
//

#import <UIKit/UIKit.h>
#import "YGHeader.h"
#import "SVGKit.h"
#import "YGSVGAnalysisCell.h"
#import <CoreText/CoreText.h>
#import "YGSVGAnalysisPromptAlertView.h"

@interface YGSVGAnalysisView : UIView<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)    UIScrollView *scrollView;
@property (nonatomic,strong)    SVGKImage *svgImage;/**< 矢量图*/
@property (nonatomic,strong)    SVGKLayeredImageView *svgView;/**< 矢量图显示视图*/
@property (nonatomic,strong)    NSMutableDictionary *textPointDic;/**< 对于文字的点的位置*/
@property (nonatomic,strong)    NSMutableArray *keyArray;
    
@property (nonatomic,strong)    NSMutableArray *markCALayerArray;
    
@property (nonatomic,strong)    UITableView *tableView;
@property (nonatomic,strong)    YGSVGAnalysisInfo *selectedInfo;
    
@property (nonatomic,strong)    YGSVGAnalysisPromptAlertView *promptAlertView;

@end
