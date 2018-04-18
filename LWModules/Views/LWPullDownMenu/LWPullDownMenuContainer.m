//
//  LWPullDownMenuContainer.m
//  LWModules
//
//  Created by apple on 2018/4/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LWPullDownMenuContainer.h"
#import "LWPullDownMenuWindow.h"
#import "LWPullDownBaseViewController.h"

#import <ReactiveCocoa.h>

@interface LWPullDownMenuContainer()

@property(nonatomic, strong, readwrite)LWPullDownMenuWindow *window;

@property(nonatomic, strong, readwrite)LWPullDownBaseViewController *viewController;

@end

@implementation LWPullDownMenuContainer

- (instancetype)init{
    self = [super init];
    if (self){
        [self subScribeSubject];
    }
    return self;
}

- (void)subScribeSubject{
    __weak LWPullDownMenuContainer *weakSelf = self;
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

- (UIView *)contentView{
    return self.viewController.contentView;
}

- (LWPullDownMenuWindow *)window{
    if (!_window) {
        _window = [[LWPullDownMenuWindow alloc] init];
        _window.rootViewController = self.viewController;
    }
    return _window;
}

- (LWPullDownBaseViewController *)viewController{
    if (!_viewController) {
        _viewController = [[LWPullDownBaseViewController alloc] init];
        _viewController.isUpSwipeReturnOpen = YES;
        _viewController.isSingleTapReturnOpen = YES;
    }
    return _viewController;
}
@end
