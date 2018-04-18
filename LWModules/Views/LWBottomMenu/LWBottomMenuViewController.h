//
//  LWBottomMenuViewController.h
//  LWModules
//
//  Created by apple on 2018/4/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RACSubject;
@class LWFlowLayoutView;

@interface LWBottomMenuViewController : UIViewController

@property(nonatomic, strong, readonly)LWFlowLayoutView *contentView;

@property(nonatomic,assign)BOOL isSingleTapReturnOpen;
@property(nonatomic,assign)BOOL isDownSwipeReturnOpen;
//内部识别的手势信号
@property(nonatomic,strong,readonly)RACSubject *returnGestureSubject;
@property(nonatomic,strong,readonly)RACSubject *returnAnimationCompleteSubject;

- (void)appearAnimation;
- (void)disappearAnimation;
- (instancetype)initWithHeight:(float)height;
@end
