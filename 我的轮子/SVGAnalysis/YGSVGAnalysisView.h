//
//  YGSVGAnalysisView.h
//  qpy
//
//  Created by qpy2 on 2017/12/7.
//

#import <UIKit/UIKit.h>

@interface YGSVGAnalysisView : UIView<NSXMLParserDelegate>

@property (nonatomic,strong) NSMutableArray *analysisArray;/**< 解析数组*/

@property (nonatomic,assign) int index;

@end
