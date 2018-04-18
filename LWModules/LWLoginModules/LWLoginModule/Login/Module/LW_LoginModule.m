//
// Part name
// Project name
//
// Created by <LWMModuleFileWriter: 0x6080000afc00> on 2018-04-01 04:46:35 +0000
// Copyright © 2018 <LWMModuleFileWriter: 0x6080000afc00>. All rights reserved.
// When you saw this file, I had finished my mission and was released. Remember that such a instance has made a small contribution to your project. Good luck.
// By <LWMModuleFileWriter: 0x6080000afc00>
//
#import "LW_LoginModule.h"
#import "LW_LoginRequest.h"
#import "LW_LoginBindModel.h"
@interface LW_LoginModule()<LW_LoginRequestSource,YTKRequestDelegate>

@property(nonatomic,strong)LW_LoginBindModel *bindModel;
@property(nonatomic,strong)LW_LoginRequest *request;

@property(nonatomic,copy)NSDictionary *(^bodyContext)(NSString * username,NSString * password);
@property(nonatomic,copy)NSDictionary *(^headerContext)(void);
@property(nonatomic,copy)void (^successBlock)(id  responseObj);
@property(nonatomic,copy)void (^failedBlock)(NSInteger  errorCode);
@property(nonatomic,assign)BOOL isSending;
@end
@implementation LW_LoginModule
- (instancetype)initWithServerUrl:(NSString *)serverUrl requestUrl:(NSString *)requestUrl{
    self = [super init];
    if (self) {
        self.serverUrl = serverUrl;
        self.requestUrl = requestUrl;
    }
    return self;
}
- (void)constructLoginBodyContext:(NSDictionary *(^)(NSString * username,NSString * password))constructBlock{
    self.bodyContext = constructBlock;
}
- (void)constructLoginHeaderContext:(NSDictionary *(^)(void))constructBlock{
self.headerContext = constructBlock;
}
- (void)subscribeLoginSuccess:(void (^)(id responseObj))successBlock{
self.successBlock = successBlock;
}
- (void)subscribeLoginFailed:(void (^)(NSInteger errorCode))failedBlock{
self.failedBlock = failedBlock;
}
- (BOOL)start{
    if (self.isSending) {
        return NO;
    }else{
        self.isSending = YES;
        [self.request start];
        return YES;
    }
}
- (LW_LoginRequest *)request{
    if (!_request) {
        _request = [[LW_LoginRequest alloc] init];
        _request.delegate = self;
        _request.source = self;
    }
    return _request;
}
- (LW_LoginBindModel *)bindModel{
    if (!_bindModel) {
        _bindModel = [[LW_LoginBindModel alloc] init];
    }
    return _bindModel;
}
- (void)requestFinished:(__kindof YTKBaseRequest *)request{
    self.isSending = NO;
    if (request.responseStatusCode == 200) {
        if (self.successBlock) {
            NSString *string = [[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding] ;
            NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding] ;
            id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            self.successBlock(obj);
        }
    }else{
        if (self.failedBlock) {
            self.failedBlock(request.responseStatusCode);
        }
    }
}
- (void)requestFailed:(__kindof YTKBaseRequest *)request{
    self.isSending = NO;
    if (self.failedBlock) {
        self.failedBlock(request.responseStatusCode);
    }
}
- (NSString *)LW_LoginRequestServerUrl{
    if (self.serverUrl) {
        return self.serverUrl;
    }else if([YTKNetworkConfig sharedConfig].baseUrl){
        return [YTKNetworkConfig sharedConfig].baseUrl;
    }else{
        NSLog(@"错误——找不到服务器的Url");
        return @"";
    }
}
- (NSString *)LW_LoginRequestRequestUrl{
    if (self.requestUrl) {
        return self.requestUrl;
    }else{
        NSLog(@"错误——找不到请求Url");
        return @"";
    }
}
- (NSDictionary *)LW_LoginRequestBody{
    if (self.bodyContext) {
        return self.bodyContext(self.bindModel.username,self.bindModel.password);
    }else{
        return @{};
    }
}
- (NSDictionary *)LW_LoginRequestHeader{
    if (self.headerContext) {
        return self.headerContext();
    }else{
        return @{};
    }
}
@end
