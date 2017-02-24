
#import "YGCommunityTopScrollerView.h"
#import "UIImageView+WebCache.h"

@interface YGCommunityTopScrollerView ()
{
    UIImageView *_imgview;
    UISegmentedControl *segmented;
}
@end

@implementation YGCommunityTopScrollerView
-(instancetype)initWithFrame:(CGRect)frame rollPictureArray:(NSArray *)rollPictureArray{
    if (self=[super initWithFrame:frame]) {
        self.timer=[NSTimer scheduledTimerWithTimeInterval:6
                                                    target:self
                                                  selector:@selector(runtimer)
                                                  userInfo:nil
                                                   repeats:YES];
        UIScrollView *mainPageTopScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        mainPageTopScrollView.delegate=self;
        mainPageTopScrollView.pagingEnabled=YES;
        mainPageTopScrollView.showsHorizontalScrollIndicator=NO;
        mainPageTopScrollView.showsVerticalScrollIndicator=NO;
        mainPageTopScrollView.bounces=NO;
        [self addSubview:mainPageTopScrollView];
        self.mainPageTopScrollView=mainPageTopScrollView;
        self.rollPictureArray=rollPictureArray;
        if (rollPictureArray.count>0) {
            NSMutableArray *newArray = [NSMutableArray arrayWithArray:rollPictureArray];
            [newArray insertObject:rollPictureArray[rollPictureArray.count-1] atIndex:0];
            [newArray addObject:rollPictureArray[0]];
            for (int i=0; i<newArray.count; i++) {
                UIImageView *rollPictureImg=[[UIImageView alloc]init];
                NSString *url = @"";
                UIImage *image = nil;
                if ([newArray[i] isKindOfClass:[UIImage class]]) {
                    image = newArray[i];
                } else {
                    url = newArray[i];
                }
                [rollPictureImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:image];
                rollPictureImg.contentMode = UIViewContentModeScaleAspectFill;
                rollPictureImg.layer.masksToBounds = YES;
                rollPictureImg.frame=CGRectMake(frame.size.width*i, 0, frame.size.width, frame.size.height);
                rollPictureImg.userInteractionEnabled = YES;
                [self.mainPageTopScrollView addSubview:rollPictureImg];
            }
        }
        self.mainPageTopScrollView.contentOffset=CGPointMake(frame.size.width, 0);
        self.mainPageTopScrollView.contentSize=CGSizeMake(frame.size.width*(rollPictureArray.count+2), frame.size.height);
    }
    return self;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth=self.mainPageTopScrollView.frame.size.width;
    int page=floorf((self.mainPageTopScrollView.contentOffset.x-pageWidth)/pageWidth+1);
    self.page=page;
}
-(void)runtimer{
    NSInteger page=self.page;
    page++;
    page=page>self.rollPictureArray.count?1:page;
    self.page=page;
    [self.mainPageTopScrollView scrollRectToVisible:CGRectMake(self.frame.size.width*page, 0, self.frame.size.width, self.bounds.size.height) animated:NO];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat pageWidth=self.mainPageTopScrollView.frame.size.width;
    int page=floorf((self.mainPageTopScrollView.contentOffset.x-pageWidth)/pageWidth+1);
    if (page>self.rollPictureArray.count) {
        self.mainPageTopScrollView.contentOffset=CGPointMake(self.frame.size.width, 0);
    }else if (page<1){
        self.mainPageTopScrollView.contentOffset=CGPointMake(self.frame.size.width*self.rollPictureArray.count, 0);
    }
}

- (void)startTimer {
    [_timer setFireDate:[NSDate distantPast]];
}
- (void)stopTimer{
    [_timer setFireDate:[NSDate distantFuture]];
}


@end
