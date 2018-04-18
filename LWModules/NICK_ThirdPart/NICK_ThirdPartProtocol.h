//
//  NICK_ThirdPartProtocol.h
//  LWModules
//
//  Created by apple on 2018/4/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*专用于NICK的第三方服务协议*/

/*第三方服务的初始化*/
@protocol NICK_ThirdPartProtocol_Initialize
@required
- (void)thirdPartInitialize;
@end

/*第三方服务的登录，注销，重连等*/
@protocol NICK_ThirdPartProtocol_LoginLogout
@required
- (BOOL)thirdPartLogin;
- (BOOL)thirdPartLogout;
- (BOOL)thirdPartReconnect;
@end

/*第三方服务在主页上的进入接口*/
@protocol NICK_ThirdPartProtocol_MainPresent
@required
- (UIView *)thirdPartMainPresentViewWithModelString:(NSString *)modelString;//View内部要包含逻辑
@end

/*第三方服务的和我们服务器的模型适配*/
@protocol NICK_ThirdPartProtocol_CommonAdapt
@required
- (NSString *)thirdPartGetStringWithModel:(id)thirdPartModel;
- (id)thirdPartGetModelWithModelString:(NSString *)modelString;
@end

/*第三方服务的增加服务项*/
@protocol NICK_ThirdPartProtocol_AddAndDelete
@required
- (UIView *)thirdPartAddViewWithModelString:(NSString *)modelString;//这个View自带跳转逻辑
- (BOOL)thirdPartDeleteWithModelString:(NSString *)modelString;
@end

/*第三方服务的错误检测*/
@protocol NICK_ThirdPartProtocol_ErrorDetect

@end

@protocol NICK_ThirdPartProtocol <NICK_ThirdPartProtocol_Initialize,NICK_ThirdPartProtocol_LoginLogout,NICK_ThirdPartProtocol_MainPresent,NICK_ThirdPartProtocol_CommonAdapt,NICK_ThirdPartProtocol_AddAndDelete,NICK_ThirdPartProtocol_ErrorDetect>

@end


