//
//  IMManager.m
//  BasicFrame
//
//  Created by zkingsoft on 2018/5/3.
//

#import "IMManager.h"

@implementation IMManager

+ (instancetype)sharedIMManager {
    static IMManager *iMManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        iMManager = [[IMManager alloc] init];
    });
    return iMManager;
}

#pragma mark ————— 初始化IM —————
-(void)initIM {
    //在注册 NIMSDK appKey 之前先进行配置信息的注册，如是否使用新路径,是否要忽略某些通知，是否需要多端同步未读数
    //    self.sdkConfigDelegate = [[NTESSDKConfigDelegate alloc] init];
    //    [[NIMSDKConfig sharedConfig] setDelegate:self.sdkConfigDelegate];
    //    [[NIMSDKConfig sharedConfig] setShouldSyncUnreadCount:YES];
    //    [[NIMSDKConfig sharedConfig] setMaxAutoLoginRetryTimes:10];
    //
    //    [[[NIMSDK sharedSDK] loginManager] addDelegate:self];
    //    [[[NIMSDK sharedSDK] chatManager] addDelegate:self];
    //
    //    [[NIMSDK sharedSDK] registerWithAppID:kIMAppKey
    //                                  cerName:kIMPushCerName];
}

#pragma mark ————— IM登录 —————
-(void)IMLogin:(NSString *)IMID IMPwd:(NSString *)IMPwd completion:(loginBlock)completion{
    //    [[[NIMSDK sharedSDK] loginManager] login:IMID token:IMPwd completion:^(NSError * _Nullable error) {
    //        if (!error) {
    //            if (completion) {
    //                completion(YES,nil);
    //            }
    //        }else{
    //            if (completion) {
    //                completion(NO,error.localizedDescription);
    //            }
    //        }
    //    }];
}
#pragma mark ————— IM退出 —————
-(void)IMLogout{
    //    [[[NIMSDK sharedSDK] loginManager] logout:^(NSError * _Nullable error) {
    //        if (!error) {
    //            DLog("IM 退出成功");
    //        }else{
    //            DLog("IM 退出失败 %@",error.localizedDescription);
    //        }
    //    }];
}

//-(void)onKick:(NIMKickReason)code clientType:(NIMLoginClientType)clientType
//{
//    NSString *reason = @"你被踢下线";
//    switch (code) {
//            case NIMKickReasonByClient:
//            case NIMKickReasonByClientManually:{
//                reason = @"你的帐号被踢出下线，请注意帐号信息安全";
//                break;
//            }
//            case NIMKickReasonByServer:
//            reason = @"你被服务器踢下线";
//            break;
//        default:
//            break;
//    }
//    KPostNotification(KNotificationOnKick, nil);
//}
//
//#pragma mark ————— 代理 收到新消息 —————
//- (void)onRecvMessages:(NSArray<NIMMessage *> *)messages{
//    DLog(@"收到新消息");
//}
//

@end
