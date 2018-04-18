//
//  LWLoginModule.h
//  LWModules
//
//  Created by apple on 2018/3/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LW_LoginBindModel.h"
/**
 * 登录业务逻辑的抽象,viewModel可以持有一个weak对象,适用于通用登录业务
 */

@interface LWLoginModule : NSObject

@property(nonatomic, assign)BOOL isNeedSaveUserInfo;

@property(nonatomic, copy, readwrite)NSString *serverUrl;
@property(nonatomic, copy, readwrite)NSString *requestUrl;

@property(nonatomic, strong, readonly)LW_LoginBindModel *bindModel;


- (instancetype)initWithServerUrl:(NSString *)serverUrl requestUrl:(NSString *)requestUrl;

/*保存用户定制请求头和请求体的代码块,传入一次就可以*/
- (void)constructLoginBodyContext:(NSDictionary *(^)(NSString *username,NSString *password))constructBlock;
- (void)constructLoginHeaderContext:(NSDictionary *(^)(void))constructBlock;

/*订阅RequestFinish，仅最后一次订阅生效,后订阅的会把前面订阅的覆盖掉，如果需要多订阅者可以保存多个代码块，类似RACSubject*/
- (void)subscribeLoginSuccess:(void (^)(id responseObj))successBlock;
- (void)subscribeLoginFailed:(void (^)(NSInteger errorCode))failedBlock;

/*登录逻辑开始,如果返回yes就是开成功了，否则没有开始,通常在点击按钮中触发这个函数*/
- (BOOL)startLogin;

@end

@interface LWLoginModule(Storage)
/**额外的任务：只有在isNeedSaveUserInfo == YES的时候生效。
 *包括存储账号密码到keychain，userdefault
 *获取之前存储的账号列表，并通过账号从keychain中获取密码
 *如果用户不需要做这些任务的话就不需要传这些代码块,视为用户自己做存储
 */

/*抽取token，如果不需要存token返回nil*/
- (void)extractTokenFromResponseObj:(NSString *(^)(id responseObj))extractBlock;

/*获取历史用户列表，用于获取登录过的历史用户*/
- (NSArray<NSString *> *)getPastUsernames;
- (void)getPastUserInfoWithUserName:(NSString *)username block:(void(^)(NSString *username, NSString*password, NSString *token))dataBlock;

@end
