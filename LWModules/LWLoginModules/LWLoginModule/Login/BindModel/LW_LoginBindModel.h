//
// Part name
// Project name
//
// Created by <LWHBindModelFileWriter: 0x60c000273940> on 2018-04-01 04:46:35 +0000
// Copyright © 2018 <LWHBindModelFileWriter: 0x60c000273940>. All rights reserved.
// When you saw this file, I had finished my mission and was released. Remember that such a instance has made a small contribution to your project. Good luck.
// By <LWHBindModelFileWriter: 0x60c000273940>
//
#import <Foundation/Foundation.h>

@interface LW_LoginBindModel:NSObject

@property(nonatomic,copy,readonly)NSString *username;
@property(nonatomic,copy,readonly)NSString *password;

/*绑定方法*/
- (void)bindUsernameWithObject:(id)object keyPath:(NSString *)keyPath;
- (void)bindPasswordWithObject:(id)object keyPath:(NSString *)keyPath;

@end
