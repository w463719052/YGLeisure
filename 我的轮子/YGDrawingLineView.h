//
//  YGDrawingLineView.h
//  我的轮子
//
//  Created by zccl2 on 16/9/23.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGDrawingLineView : UILabel

@property (nonatomic,strong) UIDynamicAnimator *animator;
@property(nonatomic,strong) UIAttachmentBehavior *attachmentBehavior;

@end
