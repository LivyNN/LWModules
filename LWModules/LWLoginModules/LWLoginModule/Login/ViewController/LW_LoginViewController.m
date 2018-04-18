//
// Part name
// Project name
//
// Created by <LWMViewControllerFileWriter: 0x608000281a90> on 2018-04-01 04:46:35 +0000
// Copyright © 2018 <LWMViewControllerFileWriter: 0x608000281a90>. All rights reserved.
// When you saw this file, I had finished my mission and was released. Remember that such a instance has made a small contribution to your project. Good luck.
// By <LWMViewControllerFileWriter: 0x608000281a90>
//
#import "LW_LoginViewController.h"
#import "LW_LoginModule.h"
#import "LWFlowLayoutView.h"
#import <Masonry.h>
@interface LW_LoginViewController()
@property(nonatomic,copy)LWFlowLayoutView *layoutView;
@property(nonatomic,copy)LW_LoginModule *module;

@property(nonatomic, strong, readwrite)UITextField *usernameTextField;
@property(nonatomic, strong, readwrite)UITextField *passwordTextField;
@property(nonatomic, strong, readwrite)UIButton *startButton;

@end
@implementation LW_LoginViewController
- (instancetype)init{
    self = [super init];
    if (self) {
        [self addSubviews];
        [self addConstraints];
        [self bindModule];
    }
    return self;
}
- (void)addSubviews{
    [self.view addSubview:self.layoutView];
/*Insert subviews here*/
    [self.layoutView lw_InsertSubView:self.usernameTextField height:100];
    [self.layoutView lw_InsertSubView:self.passwordTextField height:100];
    [self.layoutView lw_InsertSubView:self.startButton height:100];
}
- (void)addConstraints{
    [self.layoutView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.and.bottom.equalTo(self.view);
    }];
}
- (void)bindModule{
/*Example:  [self.module.bindModel bindXXXWithObject:self.inputView.textField keyPath:@"text"];*/
/*Example:  [self.module subscribeLoginSuccess:^(id responseObj) {NSLog(@"success");}];*/
    [self.module.bindModel bindUsernameWithObject:self.usernameTextField keyPath:@"text"];
    [self.module.bindModel bindPasswordWithObject:self.passwordTextField keyPath:@"text"];
    [self.startButton addTarget:self.module action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    
    [self.module subscribeLoginSuccess:^(id responseObj) {
        NSLog(@"请求成功");
        NSLog(@"%@",responseObj);
    }];
    
    [self.module subscribeLoginFailed:^(NSInteger errorCode) {
        NSLog(@"请求失败");
    }];
    
}
- (LWFlowLayoutView *)layoutView{
    if (!_layoutView) {
        _layoutView = [[LWFlowLayoutView alloc] init];
    }
    return _layoutView;
}
- (LW_LoginModule *)module{
    if (!_module) {
        _module = [[LW_LoginModule alloc] initWithServerUrl:@"http://app.littlelf.com:8051" requestUrl:@"/auth/login"];
        [_module constructLoginBodyContext:^NSDictionary *(NSString * username,NSString * password) {
            NSLog(@"%@",password);
            NSLog(@"%@",username);
            
            if (username&&password) {
                return @{@"id":username,@"pw":password};
            }
            return @{};
        }];
        [_module constructLoginHeaderContext:^NSDictionary *{
            return @{@"App-System":@"ios"};
        }];
    }
    return _module;
}

- (UITextField *)usernameTextField{
    if (!_usernameTextField) {
        _usernameTextField = [[UITextField alloc] init];
    }
    return _usernameTextField;
}

- (UITextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
    }
    return _passwordTextField;
}

- (UIButton *)startButton{
    if (!_startButton) {
        _startButton = [[UIButton alloc] init];
    }
    return _startButton;
}
@end
