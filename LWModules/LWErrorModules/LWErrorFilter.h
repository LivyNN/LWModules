//
//  LWErrorFilter.h
//  LWModules
//
//  Created by apple on 2018/3/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>


/* 错误搜集器：
 * 通过json配置文件的方式定义错误类型和描述；
 * 提供缺省错误处理方式和特殊错误处理方式。
 * 通过维持一个Key(errorCode)-value(^handleBlock)的字典
 */
@interface LWErrorFilter : NSObject

+ (instancetype)shareInstance;

/* 在AppDelegate中或者其他一定会执行的地方进行这个配置
 * @param 保存json配置的文件路径
 * @param 统一的从请求返回值提取错误码的块
 * @param 缺省的处理块
 */
- (void)lw_configWithJsonFilePath:(NSString *)filePath extractIdentity:(NSString *(^)(id responseObj))extractBlock defaultErrorHandling:(void(^)(NSString *errorCode,NSString *errorDescription))defaultBlock;


/* 同上：若返回错误时，一定是key_value格式可以使用这个进行配置
 * @param 保存json配置的文件路径
 * @param 错误码的唯一标识
 * @param 缺省的处理块
 */
- (void)lw_configWithJsonFilePath:(NSString *)filePath identityKey:(NSString *)key defaultErrorHandling:(void (^)(NSString *errorCode,NSString *errorDescription))defaultBlock;

/* 一种更直接的方式初始化
 * @param error字典，不建议使用这种方式，一旦error发生变更需要从代码中找源码修改
 * @param 统一的从请求返回值提取错误码的块
 * @param 缺省的处理块
 */
- (void)lw_configWithDictionary:(NSDictionary *)errorDictionary extractIdentity:(NSString *(^)(id responseObj))extractBlock defaultErrorHandling:(void(^)(NSString *errorCode,NSString *errorDescription))defaultBlock;

/* 一种更直接的方式初始化：如果这种搭配的种类更多的话就不得不使用桥模式
 * @param error字典，不建议使用这种方式，一旦error发生变更需要从代码中找源码修改
 * @param 统一的从请求返回值提取错误码的块
 * @param 缺省的处理块
 */
- (void)lw_configWithDictionary:(NSDictionary *)errorDictionary identityKey:(NSString *)key defaultErrorHandling:(void(^)(NSString *errorCode,NSString *errorDescription))defaultBlock;


/* 特殊的配置，保存一个特殊的报错代码块，选择性执行，在有特殊需要的时候保存这个代码块
 * @param 错误码
 * @param 处理块
 */
- (void)lw_configCustomizedErrorHandlingForError:(NSString *)errorCode withHandling:(void(^)(NSString *errorCode,NSString *errorDescription))customizedBlock;


/* 调用checkBlock进行错误检测
 * @param request.responseObj
 */
- (BOOL)detectError:(id)responseObj;

@end
