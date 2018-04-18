//
//  LWLoginRequest.h
//  LWModules
//
//  Created by apple on 2018/3/28.
//Copyright © 2018年 apple. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@protocol LWLoginRequestSource
@required
- (NSString *)LWLoginRequestServerUrl;
- (NSString *)LWLoginRequestRequestUrl;

- (NSDictionary *)LWLoginRequestBody;
- (NSDictionary *)LWLoginRequestHeader;

@end

@interface LWLoginRequest : YTKRequest

@property(nonatomic, weak, readwrite)NSObject<LWLoginRequestSource> *source;

@end
