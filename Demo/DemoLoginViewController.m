//
//  DemoLoginViewController.m
//  LWModules
//
//  Created by apple on 2018/3/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DemoLoginViewController.h"

#import "DemoLoginInputView.h"
#import "LWFlowLayoutView.h"

#import "masonry.h"

#import "LWLoginModule.h"

#import "LWErrorFilter.h"

@interface DemoLoginViewController ()

@property(nonatomic, strong, readwrite)LWFlowLayoutView *layoutView;

@property(nonatomic, strong, readwrite)DemoLoginInputView *usernameInputView;

@property(nonatomic, strong, readwrite)DemoLoginInputView *passwordInputView;

@property(nonatomic, strong, readwrite)UIButton *nextStepButton;

@property(nonatomic, strong, readwrite)LWLoginModule *loginModule;

@end

@implementation DemoLoginViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        [self addSubView];
        [self addConstraints];
        [self bindModule];
    }
    return self;
}

- (void)addSubView{
    [self.view addSubview:self.layoutView];
    [self.layoutView lw_InsertSubView:self.usernameInputView height:60];
    [self.layoutView lw_InsertSubView:self.passwordInputView height:60];
    [self.layoutView lw_InsertSubView:self.nextStepButton height:60];
}

- (void)addConstraints{
    [self.layoutView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.and.bottom.equalTo(self.view);
    }];
}

- (void)bindModule{
    [self.loginModule.bindModel bindUsernameWithObject:self.usernameInputView.textField keyPath:@"text"];
    [self.loginModule.bindModel bindPasswordWithObject:self.passwordInputView.textField keyPath:@"text"];
    
    [self.loginModule subscribeLoginSuccess:^(id responseObj) {
        NSLog(@"success");
        NSLog(@"%@",responseObj);
        [[LWErrorFilter shareInstance] detectError:responseObj];
    }];
    
    [self.loginModule subscribeLoginFailed:^(NSInteger errorCode) {
        NSLog(@"failed");
        NSLog(@"%ld",errorCode);
    }];
}

- (DemoLoginInputView *)usernameInputView{
    if (!_usernameInputView) {
        _usernameInputView = [[DemoLoginInputView alloc] init];
    }
    return _usernameInputView;
}

- (DemoLoginInputView *)passwordInputView{
    if (!_passwordInputView) {
        _passwordInputView = [[DemoLoginInputView alloc] init];
    }
    return _passwordInputView;
}

- (UIButton *)nextStepButton{
    if (!_nextStepButton) {
        _nextStepButton = [[UIButton alloc] init];
        _nextStepButton.backgroundColor = [UIColor greenColor];
        [_nextStepButton addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextStepButton;
}
- (void)buttonClicked{
    [self.loginModule startLogin];
}

- (LWFlowLayoutView *)layoutView{
    if (!_layoutView) {
        _layoutView = [[LWFlowLayoutView alloc] init];
    }
    return _layoutView;
}

- (LWLoginModule *)loginModule{
    if (!_loginModule) {
        _loginModule = [[LWLoginModule alloc] initWithServerUrl:@"http://app.littlelf.com:8051" requestUrl:@"/auth/login"];
        _loginModule.isNeedSaveUserInfo = NO;
        [_loginModule constructLoginBodyContext:^NSDictionary *(NSString *username, NSString *password) {
            NSLog(@"%@",password);
            NSLog(@"%@",username);
            
            if (username&&password) {
               return @{@"id":username,@"pw":password};
            }
            return @{};
        }];
        [_loginModule constructLoginHeaderContext:^NSDictionary *{
            return @{@"App-System":@"ios"};
        }];
    }
    return _loginModule;
}

@end
