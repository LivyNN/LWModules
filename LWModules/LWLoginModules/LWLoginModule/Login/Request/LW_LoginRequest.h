//
// Part name
// Project name
//
// Created by <LWHRequestFileWriter: 0x604000074480> on 2018-04-01 04:46:35 +0000
// Copyright © 2018 <LWHRequestFileWriter: 0x604000074480>. All rights reserved.
// When you saw this file, I had finished my mission and was released. Remember that such a instance has made a small contribution to your project. Good luck.
// By <LWHRequestFileWriter: 0x604000074480>
//
#import <YTKNetwork/YTKNetwork.h>
@protocol LW_LoginRequestSource
@required
- (NSString *)LW_LoginRequestServerUrl;
- (NSString *)LW_LoginRequestRequestUrl;
- (NSDictionary *)LW_LoginRequestBody;
- (NSDictionary *)LW_LoginRequestHeader;
/*请求方式在Request中自行修改,这里不设置代理*/
@end
@interface LW_LoginRequest:YTKRequest
@property(nonatomic, weak)NSObject<LW_LoginRequestSource> *source;
@end
