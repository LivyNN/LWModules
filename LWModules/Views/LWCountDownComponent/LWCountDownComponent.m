//
//  LWCountDownComponent.m
//  LWModules
//
//  Created by apple on 2018/4/4.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LWCountDownComponent.h"
#import <ReactiveCocoa.h>

@interface LWCountDownComponent()

@property(nonatomic, strong, readwrite)RACSubject *countDownSubject;
@property(nonatomic, strong, readwrite)RACSubject *countDownCompleteSubject;

@property(nonatomic, assign, readwrite)NSInteger countDownNum;

@property(nonatomic, assign, readwrite)BOOL isCountingDown;

@end

@implementation LWCountDownComponent

- (void)countDownWithSeconds:(NSInteger)seconds{
    if (!self.isCountingDown) {
        self.countDownNum = seconds;
        __weak LWCountDownComponent *weakSelf = self;
        NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
            if (weakSelf.countDownNum>0) {
                weakSelf.countDownNum = weakSelf.countDownNum-1;
                [self.countDownSubject sendNext:@(weakSelf.countDownNum)];
            }else{
                [self.countDownCompleteSubject sendNext:@(weakSelf.countDownNum)];
                [timer invalidate];
                timer = nil;
                weakSelf.isCountingDown = NO;
            }
        }];
        self.isCountingDown = YES;
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
}

- (RACSubject *)countDownSubject{
    if (!_countDownSubject) {
        _countDownSubject = [RACSubject subject];
    }
    return _countDownSubject;
}

- (RACSubject *)countDownCompleteSubject{
    if (!_countDownCompleteSubject) {
        _countDownCompleteSubject = [RACSubject subject];
    }
    return _countDownCompleteSubject;
}

@end
