//
//  LWErrorFilter.m
//  LWModules
//
//  Created by apple on 2018/3/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LWErrorFilter.h"

@interface LWErrorFilter()

@property (nonatomic, copy, readwrite)NSDictionary *errorCodeDictionary;

@property (nonatomic, copy, readwrite)NSMutableDictionary *errorBlockDictionary;

@property (nonatomic, copy, readwrite)NSString *(^extractIdentityBlock)(id responseObj);

@property (nonatomic, copy, readwrite)void(^defaultErrorHandlingBlock)(NSString *errorCode, NSString *errorDiscription);


@end

@implementation LWErrorFilter

+ (instancetype)shareInstance{
    static LWErrorFilter *share;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[self alloc] init];
    });
    return share;
}

#pragma mark - public
- (void)lw_configWithJsonFilePath:(NSString *)filePath extractIdentity:(NSString *(^)(id))extractBlock defaultErrorHandling:(void (^)(NSString *, NSString *))defaultBlock{
    NSString *path = [[NSBundle mainBundle] pathForResource:filePath ofType:@"geojson"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    if (data) {
        self.errorCodeDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        if (!self.errorCodeDictionary) {
            NSLog(@"配置错误码失败");
        }
    }else{
        NSLog(@"配置错误码失败");
    }
    self.defaultErrorHandlingBlock = defaultBlock;
    self.extractIdentityBlock = extractBlock;
}

- (void)lw_configWithJsonFilePath:(NSString *)filePath identityKey:(NSString *)key defaultErrorHandling:(void (^)(NSString *, NSString *))defaultBlock{
    [self lw_configWithJsonFilePath:filePath extractIdentity:^NSString *(id responseObj) {
        NSDictionary *dic = responseObj;
        return [dic objectForKey:key];
    } defaultErrorHandling:defaultBlock];
}

- (void)lw_configWithDictionary:(NSDictionary *)errorDictionary extractIdentity:(NSString *(^)(id responseObj))extractBlock defaultErrorHandling:(void(^)(NSString *errorCode,NSString *errorDescription))defaultBlock{
    self.errorCodeDictionary = errorDictionary;
    if (self.errorCodeDictionary) {
        NSLog(@"配置错误码失败");
    }
    self.defaultErrorHandlingBlock = defaultBlock;
    self.extractIdentityBlock = extractBlock;
}

- (void)lw_configWithDictionary:(NSDictionary *)errorDictionary identityKey:(NSString *)key defaultErrorHandling:(void(^)(NSString *errorCode,NSString *errorDescription))defaultBlock{
    [self lw_configWithDictionary:errorDictionary extractIdentity:^NSString *(id responseObj) {
        NSDictionary *dic = responseObj;
        return [dic objectForKey:key];
    } defaultErrorHandling:defaultBlock];
}

- (void)lw_configCustomizedErrorHandlingForError:(NSString *)errorCode withHandling:(void (^)(NSString *, NSString *))customizedBlock{
    if (customizedBlock) {
        [self.errorBlockDictionary setValue:customizedBlock forKey:errorCode];
    }
}

- (BOOL)detectError:(id)responseObj{
    NSString *errorCode = self.extractIdentityBlock(responseObj);
    if (!errorCode&&(errorCode.length == 0)) {
        return NO;
    }else{
        NSString *errorDiscription = [self.errorCodeDictionary objectForKey:errorCode];
        if (errorDiscription) {
            if ([self.errorBlockDictionary objectForKey:errorCode]) {
                /*用户对这个错误进行了自定义处理*/
                void (^customBlock)(NSString *errorCode, NSString *errorDiscription) = [self.errorBlockDictionary objectForKey:errorCode];
                customBlock(errorCode,errorDiscription);
                return YES;
            }else{
                /*走缺省处理*/
                self.defaultErrorHandlingBlock(errorCode, errorDiscription);
                return YES;
            }
        }else{
            /*跳转到未知的错误中去，这个错误服务器有，但是用户的json中没有配置*/
            NSLog(@"未知的错误");
            return YES;
        }
    }
}

#pragma mark - lazyLoad
- (NSMutableDictionary *)errorBlockDictionary{
    if (!_errorBlockDictionary) {
        _errorBlockDictionary = [[NSMutableDictionary alloc] init];
    }
    return _errorBlockDictionary;
}

@end
