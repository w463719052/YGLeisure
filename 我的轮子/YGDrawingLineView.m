//
//  YGDrawingLineView.m
//  我的轮子
//
//  Created by zccl2 on 16/9/23.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import "YGDrawingLineView.h"

@implementation YGDrawingLineView

-(instancetype)init{
    if (self=[super init]) {
        self.frame = CGRectMake(0, 0, 100, 10);
        self.backgroundColor = [UIColor redColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.text = @"11.5cm";
        [self addContentView];
    }
    return self;
}

- (void)addContentView {
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.superview];
//    UIGravityBehavior* gravityBeahvior = [[UIGravityBehavior alloc] initWithItems:@[self]];
//    [_animator addBehavior:gravityBeahvior];
//    
//    UICollisionBehavior* collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self]];
//    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
//    [_animator addBehavior:collisionBehavior];
    self.userInteractionEnabled = YES;
    UIPanGestureRecognizer *longPress = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleAttachmentGesture:)];
    [self addGestureRecognizer:longPress];
}

- (void)handleAttachmentGesture:(UIPanGestureRecognizer*)gesture {
    CGPoint loction = [gesture locationInView:self];
    if (loction.x < 75.0) {
        if (gesture.state == UIGestureRecognizerStateBegan){
            CGPoint squareCenterPoint = CGPointMake(self.center.x, self.center.y);
            UIAttachmentBehavior* attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self attachedToAnchor:squareCenterPoint];
            self.attachmentBehavior = attachmentBehavior;
            [self.animator addBehavior:attachmentBehavior];
        } else if ( gesture.state == UIGestureRecognizerStateChanged) {
            [self.attachmentBehavior setAnchorPoint:[gesture locationInView:self.superview]];
        } else if (gesture.state == UIGestureRecognizerStateEnded) {
            [self.animator removeBehavior:self.attachmentBehavior];
        }
    } else if (loction.x > 75.0) {
        CGPoint oringPoint = [gesture locationInView:self.superview];
        if (gesture.state == UIGestureRecognizerStateBegan){
            oringPoint = [gesture locationInView:self.superview];
            self.layer.anchorPoint = CGPointMake(0, 0.5);
        } else if ( gesture.state == UIGestureRecognizerStateChanged) {
            CGPoint a = [gesture translationInView:self.superview];
            CGPoint b = [gesture velocityInView:self.superview];
            self.layer.transform = CATransform3DRotate(self.layer.transform, 0.01, 0, 0, 1);
        } else if (gesture.state == UIGestureRecognizerStateEnded) {
            [self.animator removeBehavior:self.attachmentBehavior];
        }
    }
}

@end
