//
//  LWBottomMenuContainer.h
//  LWModules
//
//  Created by apple on 2018/4/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class LWFlowLayoutView;

@interface LWBottomMenuContainer : NSObject

/*暴露出一个View交给用户去自定义,用户把自己的子视图加到这个上面*/
@property(nonatomic, strong,readonly)LWFlowLayoutView *layoutView;

/*从最顶部下拉下来的高度*/
@property(nonatomic, assign, readwrite)CGFloat menuHeight;

/*动画时间*/
@property(nonatomic, assign, readwrite)float animationTime;

- (void)show;
- (void)hide;

- (instancetype)initWithHeight:(float)height;

@end
