//
//  LWBottomMenuContainer.m
//  LWModules
//
//  Created by apple on 2018/4/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LWBottomMenuContainer.h"
#import "LWBottomMenuWindow.h"
#import "LWBottomMenuViewController.h"
#import <ReactiveCocoa.h>

@interface LWBottomMenuContainer()

@property(nonatomic, strong)LWBottomMenuWindow *window;

@property(nonatomic, strong)LWBottomMenuViewController *viewController;

@property(nonatomic, assign)float height;

@end

@implementation LWBottomMenuContainer


- (instancetype)initWithHeight:(float)height{
    self = [super init];
    if (self) {
        self.height = height;
        [self subScribeSubject];
    }
    return self;
}

- (void)subScribeSubject{
    __weak LWBottomMenuContainer *weakSelf = self;
    [self.viewController.returnGestureSubject subscribeNext:^(id x) {
        [weakSelf hide];
    }];
    
    [self.viewController.returnAnimationCompleteSubject subscribeNext:^(id x) {
        [weakSelf releaseWindow];
    }];
}

- (void)show{
    [self.window makeKeyAndVisible];
}
- (void)hide{
    [self.viewController disappearAnimation];
}

- (void)releaseWindow{
    [self.window resignKeyWindow];
    _window = nil;
}

- (LWFlowLayoutView *)layoutView{
    return self.viewController.contentView;
}

- (LWBottomMenuWindow *)window{
    if (!_window) {
        _window = [[LWBottomMenuWindow alloc] init];
        _window.rootViewController = self.viewController;
    }
    return _window;
}

- (LWBottomMenuViewController *)viewController{
    if (!_viewController) {
        _viewController = [[LWBottomMenuViewController alloc] initWithHeight:self.height];
        _viewController.isDownSwipeReturnOpen = YES;
        _viewController.isSingleTapReturnOpen = YES;
    }
    return _viewController;
}
@end
