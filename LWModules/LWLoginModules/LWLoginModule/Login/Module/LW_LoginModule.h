//
// Part name
// Project name
//
// Created by <LWHModuleFileWriter: 0x608000076580> on 2018-04-01 04:46:35 +0000
// Copyright © 2018 <LWHModuleFileWriter: 0x608000076580>. All rights reserved.
// When you saw this file, I had finished my mission and was released. Remember that such a instance has made a small contribution to your project. Good luck.
// By <LWHModuleFileWriter: 0x608000076580>
//
#import <Foundation/Foundation.h>
#import "LW_LoginBindModel.h"

@interface LW_LoginModule:NSObject
@property(nonatomic,copy)NSString *serverUrl;
@property(nonatomic,copy)NSString *requestUrl;
@property(nonatomic,strong,readonly)LW_LoginBindModel *bindModel;

- (instancetype)initWithServerUrl:(NSString *)serverUrl requestUrl:(NSString *)requestUrl;
- (void)constructLoginBodyContext:(NSDictionary *(^)(NSString *username,NSString *password))constructBlock;
- (void)constructLoginHeaderContext:(NSDictionary *(^)(void))constructBlock;
- (void)subscribeLoginSuccess:(void (^)(id responseObj))successBlock;
- (void)subscribeLoginFailed:(void (^)(NSInteger errorCode))failedBlock;
- (BOOL)start;
@end
