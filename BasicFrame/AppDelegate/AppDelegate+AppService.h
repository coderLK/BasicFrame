//
//  AppDelegate+AppService.h
//  BasicFrame
//
//  Created by zkingsoft on 2018/4/28.
//

#import "AppDelegate.h"

@interface AppDelegate (AppService)

//初始化服务
-(void)initService;

//初始化 window
-(void)initWindow;

//初始化 UMeng
-(void)initUMeng;

//初始化用户系统
-(void)initUserManager;

//监听网络状态
- (void)monitorNetworkStatus;

//初始化网络配置
-(void)NetWorkConfig;

//单例
+ (AppDelegate *)shareAppDelegate;

/**
 当前顶层控制器
 */
- (UIViewController*)getCurrentVC;

- (UIViewController*)getCurrentUIVC;

@end
