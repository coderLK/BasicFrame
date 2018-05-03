//
//  ShareManager.m
//  BasicFrame
//
//  Created by zkingsoft on 2018/5/3.
//

#import "ShareManager.h"
#import "ZKAlertController.h"
#import <UShareUI/UShareUI.h>

@implementation ShareManager

+ (instancetype)shareadShareManager {
    static ShareManager *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[ShareManager alloc] init];
    });
    return shareManager;
}

+ (void)UMSocialStart
{
    // 友盟分享
    
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:ThirdSDKUMSocialAppkey];
    
    // 获取友盟social版本号
    //NSLog(@"UMeng social version: %@", [UMSocialGlobal umSocialSDKVersion]);
    
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:ThirdSDKWeChatAppKey appSecret:ThirdSDKWeChatAppSecret redirectURL:ThirdSDKWeChatRedirectURL];
    
    
    //设置分享到QQ互联的appKey和appSecret
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:ThirdSDKQQAppKey  appSecret:ThirdSDKQQAppSecret redirectURL:ThirdSDKQQRedirectURL];
    
    //设置新浪的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:ThirdSDKSinaAppKey  appSecret:ThirdSDKSinaAppSecret redirectURL:ThirdSDKSinaRedirectURL];
    
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession), @(UMSocialPlatformType_WechatTimeLine), @(UMSocialPlatformType_Qzone)]];
    
    // 如果不想显示平台下的某些类型，可用以下接口设置
    //    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_AlipaySession),@(UMSocialPlatformType_Email),@(UMSocialPlatformType_Sms), @(UMSocialPlatformType_WechatFavorite), @(UMSocialPlatformType_TencentWb)]];
    
#ifdef DEBUG
    
    //打开调试日志
    //[[UMSocialManager defaultManager] openLog:YES];
    
#endif
}

- (void)showShareView{
    //显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        [self shareWebPageToPlatformType:platformType];
    }];
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString* thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"欢迎使用【友盟+】社会化组件U-Share" descr:@"欢迎使用【友盟+】社会化组件U-Share，SDK包最小，集成成本最低，助力您的产品开发、运营与推广！" thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = @"http://mobile.umeng.com/social";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
}

- (void)alertWithError:(NSError *)error
{
    NSString *result = nil;
    if (!error) {
        result = [NSString stringWithFormat:@"Share succeed"];
    }
    else{
        NSMutableString *str = [NSMutableString string];
        if (error.userInfo) {
            for (NSString *key in error.userInfo) {
                [str appendFormat:@"%@ = %@\n", key, error.userInfo[key]];
            }
        }
        if (error) {
            result = [NSString stringWithFormat:@"Share fail with error code: %d\n%@",(int)error.code, str];
        }
        else{
            result = [NSString stringWithFormat:@"Share fail"];
        }
    }

    [UIAlertController mj_showAlertWithTitle:@"share" message:result appearanceProcess:^(ZKAlertController * _Nonnull alertMaker) {
        alertMaker.
        addActionCancelTitle(@"取消").
        addActionDestructiveTitle(NSLocalizedString(@"sure", @"确定"));
    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, ZKAlertController * _Nonnull alertSelf) {
        if (buttonIndex == 0) {
           
        }
        else if (buttonIndex == 1) {
            
        }
    }];
}

@end
