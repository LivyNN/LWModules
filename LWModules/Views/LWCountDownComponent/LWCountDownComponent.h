//
//  LWCountDownComponent.h
//  LWModules
//
//  Created by apple on 2018/4/4.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

/*一个倒计时的微小组件,通过热信号传递数值,调用countdown函数后，就会有信号发射出来*/
/*注意：前一次倒数没有执行完的情况下不会开启第二次倒数*/
@class RACSubject;

@interface LWCountDownComponent : NSObject

@property(nonatomic, strong, readonly)RACSubject *countDownSubject;
@property(nonatomic, strong, readonly)RACSubject *countDownCompleteSubject;

@property(nonatomic, assign, readonly)NSInteger countDownNum;

- (void)countDownWithSeconds:(NSInteger)seconds;

@end
