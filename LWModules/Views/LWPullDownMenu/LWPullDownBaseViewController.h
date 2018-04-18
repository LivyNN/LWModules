//
//  LWPullDownBaseViewController.h
//  LWModules
//
//  Created by apple on 2018/4/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RACSubject;

@interface LWPullDownBaseViewController : UIViewController

@property(nonatomic, strong, readonly)UIView *contentView;

@property(nonatomic,assign)BOOL isSingleTapReturnOpen;
@property(nonatomic,assign)BOOL isUpSwipeReturnOpen;

//内部识别的手势信号
@property(nonatomic,strong,readonly)RACSubject *returnGestureSubject;
@property(nonatomic,strong,readonly)RACSubject *returnAnimationCompleteSubject;

- (void)appearAnimation;
- (void)disappearAnimation;

@end
