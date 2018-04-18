//
// Part name
// Project name
//
// Created by <LWMRequestFileWriter: 0x604000074b80> on 2018-04-01 04:46:35 +0000
// Copyright © 2018 <LWMRequestFileWriter: 0x604000074b80>. All rights reserved.
// When you saw this file, I had finished my mission and was released. Remember that such a instance has made a small contribution to your project. Good luck.
// By <LWMRequestFileWriter: 0x604000074b80>
//
#import "LW_LoginRequest.h"

@interface LW_LoginRequest()

@end
@implementation LW_LoginRequest
/*重写父类的方法*/
- (NSString *)baseUrl{
    if (self.source&&[self.source respondsToSelector:@selector(LW_LoginRequestServerUrl)]) {
        return self.source.LW_LoginRequestServerUrl;
    }else if([YTKNetworkConfig sharedConfig].baseUrl){
        return [YTKNetworkConfig sharedConfig].baseUrl;
    }else{
        NSLog(@"错误——找不到服务器Url");
        return @"";
    }
}

- (NSString *)requestUrl{
    if (self.source&&[self.source respondsToSelector:@selector(LW_LoginRequestRequestUrl)]) {
        return self.source.LW_LoginRequestRequestUrl;
    }else{
        NSLog(@"错误——找不到请求Url");
        return @"";
    }
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
/*    return YTKRequestMethodGET;*/
/*    return YTKRequestMethodDELETE;*/
/*    return YTKRequestMethodPUT;*/
}

- (YTKRequestSerializerType )requestSerializerType{
    return YTKRequestSerializerTypeJSON;
}

- (YTKResponseSerializerType)responseSerializerType{
    return YTKResponseSerializerTypeHTTP;
}

- (id)requestArgument{
    if (self.source&&[self.source respondsToSelector:@selector(LW_LoginRequestBody)]) {
        return self.source.LW_LoginRequestBody;
    }else{
        return @{};
    }
}

- (NSDictionary *)requestHeaderFieldValueDictionary{
    if (self.source&&[self.source respondsToSelector:@selector(LW_LoginRequestHeader)]) {
        return self.source.LW_LoginRequestHeader;
    }else{
        return @{};
    }
}
@end
