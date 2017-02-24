

#import <UIKit/UIKit.h>

@interface YGCommunityTopScrollerView : UIView<UIScrollViewDelegate>
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) UIScrollView *mainPageTopScrollView;
@property (nonatomic,strong) NSArray *rollPictureArray;
@property (nonatomic,assign) NSInteger page;
-(instancetype)initWithFrame:(CGRect)frame rollPictureArray:(NSArray *)rollPictureArray;
- (void)startTimer;
- (void)stopTimer;
@end
