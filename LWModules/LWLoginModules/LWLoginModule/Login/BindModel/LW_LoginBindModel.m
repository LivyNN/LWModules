//
// Part name
// Project name
//
// Created by <LWMBindModelFileWriter: 0x604000073e40> on 2018-04-01 04:46:35 +0000
// Copyright © 2018 <LWMBindModelFileWriter: 0x604000073e40>. All rights reserved.
// When you saw this file, I had finished my mission and was released. Remember that such a instance has made a small contribution to your project. Good luck.
// By <LWMBindModelFileWriter: 0x604000073e40>
//
#import "LW_LoginBindModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface LW_LoginBindModel()
@property(nonatomic,copy)NSString *username;
@property(nonatomic,copy)NSString *password;
@property(nonatomic,strong)RACSignal *usernameSignal;
@property(nonatomic,strong)RACSignal *passwordSignal;
@end

@implementation LW_LoginBindModel

- (void)bindUsernameWithObject:(id)object keyPath:(NSString *)keyPath{
    self.usernameSignal = [object rac_valuesForKeyPath:keyPath observer:self];
    @weakify(self);
    [self.usernameSignal subscribeNext:^(id x) {
        @strongify(self)
        if ([x isKindOfClass:[NSString class]]) {
            self.username = x;
        }else{
            NSLog(@"绑定错误");
        }
    }];
}
- (void)bindPasswordWithObject:(id)object keyPath:(NSString *)keyPath{
    self.passwordSignal = [object rac_valuesForKeyPath:keyPath observer:self];
    @weakify(self);
    [self.passwordSignal subscribeNext:^(id x) {
        @strongify(self)
        if ([x isKindOfClass:[NSString class]]) {
            self.password = x;
        }else{
            NSLog(@"绑定错误");
        }
    }];
}
@end
