//
//  LWLoginModule.m
//  LWModules
//
//  Created by apple on 2018/3/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LWLoginModule.h"
#import <JNKeychain.h>
#import "LWLoginRequest.h"

/*accessPath*/
static NSString* const kLWKeychainPath  = @"cn.evolab.www.LW";
/*username,password，每条记录的key是username，里面包含着一个dictionary，dictionary包含三项下面三项*/
static NSString* const kLWKeychainKey_Username = @"LW.username";
static NSString* const kLWKeychainKey_Password = @"LW.password";
static NSString* const kLWKeychainKey_Token = @"LW.token";

/*存储一个set*/
static NSString* const kLWUserDefaultKey_Usernames = @"LW.userdefault.usernames";



@interface LWLoginModule()<LWLoginRequestSource,YTKRequestDelegate>

@property(nonatomic, strong, readwrite)LW_LoginBindModel *bindModel;

@property(nonatomic, strong, readwrite)LWLoginRequest *loginRequest;

/*交由用户定制请求体的block*/
@property(nonatomic, copy)NSDictionary *(^bodyContext)(NSString *username, NSString *password);
@property(nonatomic, copy)NSDictionary *(^headerContext)(void);

@property(nonatomic, copy)void (^loginSuccessBlock)(id responseObj);
@property(nonatomic, copy)void (^loginFailedBlock)(NSInteger errorCode);

/*当前是否正在登录的状态，如果上一次的回调还没有过来，就不会执行下一次登录*/
@property(nonatomic, assign)BOOL isLogging;

/*考虑到用户把string绑定到textfield上的时候，在发送请求期间有可能修改输入内容，这里面标识一份发送请求实际使用的username和password从而便于存储正确的账号和密码，而不是时刻绑定在textfield上面的*/
@property(nonatomic, copy, readwrite)NSString *requestUsername;
@property(nonatomic, copy, readwrite)NSString *requestPassword;

//这部分是额外的不自动输出范围内
/*Storage*/
@property(nonatomic, copy, readwrite)NSString *(^extractTokenBlock)(id responseObj);

@end

@implementation LWLoginModule

- (instancetype)initWithServerUrl:(NSString *)serverUrl requestUrl:(NSString *)requestUrl{
    self = [super init];
    if (self) {
        self.serverUrl = serverUrl;
        self.requestUrl = requestUrl;
    }
    return self;
}

- (void)constructLoginBodyContext:(NSDictionary *(^)(NSString *username, NSString *password))constructBlock{
    self.bodyContext = constructBlock;
}
- (void)constructLoginHeaderContext:(NSDictionary *(^)(void))constructBlock{
    self.headerContext = constructBlock;
}
- (void)subscribeLoginSuccess:(void (^)(id responseObj))successBlock{
    self.loginSuccessBlock = successBlock;
}
- (void)subscribeLoginFailed:(void (^)(NSInteger errorCode))failedBlock{
    self.loginFailedBlock = failedBlock;
}

- (BOOL)startLogin{
    if (self.isLogging) {
        return NO;
    }else{
        self.isLogging = YES;
        self.requestUsername = self.bindModel.username;
        self.requestPassword = self.bindModel.password;
        [self.loginRequest start];
        return YES;
    }
}

#pragma mark-lazyLoad

- (LWLoginRequest *)loginRequest{
    if (!_loginRequest) {
        _loginRequest = [[LWLoginRequest alloc] init];
        _loginRequest.source = self;
        _loginRequest.delegate = self;
    }
    return _loginRequest;
}

- (LW_LoginBindModel *)bindModel{
    if (!_bindModel) {
        _bindModel = [[LW_LoginBindModel alloc] init];
    }
    return _bindModel;
}
#pragma mark-YTKDelegate
- (void)requestFinished:(__kindof YTKBaseRequest *)request{
    self.isLogging = NO;
    if (request.responseStatusCode == 200) {
        if (self.loginSuccessBlock) {
            NSString *string = [[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding] ;
            NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding] ;
            id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            //TODO:多线程账号密码存入keychain；账号存入NSUserDefault
            if (self.isNeedSaveUserInfo) {
                __weak LWLoginModule *weakSelf = self;
                dispatch_async(dispatch_get_global_queue(0, 0), ^{

                    NSDictionary *keychainDic;
                    if (self.extractTokenBlock) {
                        //抽取出token
                        NSString *token = weakSelf.extractTokenBlock(obj);
                        if (token) {
                            keychainDic = @{kLWKeychainKey_Username:weakSelf.requestUsername,
                                            kLWKeychainKey_Password:weakSelf.requestPassword,
                                            kLWKeychainKey_Token:token,
                                            };
                        }
                    }else{
                        keychainDic = @{kLWKeychainKey_Username:weakSelf.requestUsername,
                                        kLWKeychainKey_Password:weakSelf.requestPassword,
                                        };
                    }
                    [JNKeychain saveValue:keychainDic forKey:weakSelf.requestUsername forAccessGroup:kLWKeychainPath];
                    
                    //用户名列表存入userDefault
                    NSSet *userSet = [NSSet setWithSet:[[NSUserDefaults standardUserDefaults] objectForKey:kLWUserDefaultKey_Usernames]];
                    [userSet setByAddingObject:weakSelf.requestUsername];
                    [[NSUserDefaults standardUserDefaults] setObject:userSet forKey:kLWUserDefaultKey_Usernames];
                });
            }
            self.loginSuccessBlock(obj);
        }
    }else{
        if (self.loginFailedBlock) {
            self.loginFailedBlock(request.responseStatusCode);
        }
    }
}
- (void)requestFailed:(__kindof YTKBaseRequest *)request{
    self.isLogging = NO;
    if (self.loginFailedBlock) {
        self.loginFailedBlock(request.responseStatusCode);
    }
}
#pragma mark-LWSource
- (NSString *)LWLoginRequestServerUrl{
    if (self.serverUrl) {
        return self.serverUrl;
    }else if([YTKNetworkConfig sharedConfig].baseUrl){
        return [YTKNetworkConfig sharedConfig].baseUrl;
    }else{
        NSLog(@"错误——找不到服务器的Url");
        return @"";
    }
}
- (NSString *)LWLoginRequestRequestUrl{
    if (self.requestUrl) {
        return self.requestUrl;
    }else{
        NSLog(@"错误——找不到请求Url");
        return @"";
    }
}
- (NSDictionary *)LWLoginRequestBody{
    if (self.bodyContext) {
        return self.bodyContext(self.bindModel.username,self.bindModel.password);
    }else{
        return @{};
    }
}
- (NSDictionary *)LWLoginRequestHeader{
    if (self.headerContext) {
        return self.headerContext();
    }else{
        return @{};
    }
}

@end

@implementation LWLoginModule(Storage)
/*从用户返回信息中抽取出token*/
- (void)extractTokenFromResponseObj:(NSString *(^)(id))extractBlock{
    self.extractTokenBlock = extractBlock;
}

- (NSArray<NSString *> *)getPastUsernames{
    NSSet *set = [[NSUserDefaults standardUserDefaults] objectForKey:kLWUserDefaultKey_Usernames];
    return [set allObjects];
}

- (void)getPastUserInfoWithUserName:(NSString *)username block:(void (^)(NSString *, NSString *, NSString *))dataBlock{
    NSDictionary *dic = [JNKeychain loadValueForKey:username forAccessGroup:kLWKeychainPath];
    dataBlock([dic objectForKey:kLWKeychainKey_Username],[dic objectForKey:kLWKeychainKey_Password],[dic objectForKey:kLWKeychainKey_Token]);
}

@end
