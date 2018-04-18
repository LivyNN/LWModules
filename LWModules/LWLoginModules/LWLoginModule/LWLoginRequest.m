//
//  LWLoginRequest.m
//  LWModules
//
//  Created by apple on 2018/3/28.
//Copyright © 2018年 apple. All rights reserved.
//

#import "LWLoginRequest.h"

@interface LWLoginRequest ()

@end

@implementation LWLoginRequest

#pragma mark -Init

#pragma mark -Private Method

- (NSString *)baseUrl{
    if (self.source&&[self.source respondsToSelector:@selector(LWLoginRequestServerUrl)]) {
        return self.source.LWLoginRequestServerUrl;
    }else if([YTKNetworkConfig sharedConfig].baseUrl){
        return [YTKNetworkConfig sharedConfig].baseUrl;
    }else{
        NSLog(@"错误——找不到服务器的Url");
        return @"";
    }
}

- (NSString *)requestUrl{
    if (self.source&&[self.source respondsToSelector:@selector(LWLoginRequestRequestUrl)]) {
        return self.source.LWLoginRequestRequestUrl;
    }else{
        NSLog(@"错误——找不到请求Url");
        return @"";
    }
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST ;
}

- (YTKRequestSerializerType )requestSerializerType{
    return YTKRequestSerializerTypeJSON ;
}

- (YTKResponseSerializerType)responseSerializerType{
    return YTKResponseSerializerTypeHTTP ;
}

- (id)requestArgument{
    if (self.source&&[self.source respondsToSelector:@selector(LWLoginRequestBody)]) {
        return self.source.LWLoginRequestBody;
    }else{
        return @{};
    }
}

- (NSDictionary *)requestHeaderFieldValueDictionary{
    if (self.source&&[self.source respondsToSelector:@selector(LWLoginRequestHeader)]) {
        return self.source.LWLoginRequestHeader;
    }else{
        return @{};
    }
}

@end
