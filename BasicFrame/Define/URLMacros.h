//
//  URLMacros.h
//  BasicFrame
//
//  Created by zkingsoft on 2018/5/2.
//

#ifndef URLMacros_h
#define URLMacros_h

//每次版本递增
#define kVersionCode 1

#define DevelopServer   1 //开发环境
#define TestServer      0 //测试环境
#define ProductSever    0 //生产环境

#if DevelopServer

/**开发服务器*/
#define URL_server @"http://192.168.20.31:20000/shark-miai-service"

#elif TestSever

/**测试服务器*/
#define URL_server @"http://192.168.20.31:20000/shark-miai-service"

#elif ProductSever

/**生产服务器*/
#define URL_server @"http://192.168.20.31:20000/shark-miai-service"
#endif

#pragma mark - ——————— 详细接口地址 ————————

//测试接口
#define URL_Test @"/api/cast/home/start"


#pragma mark - ——————— 用户相关 ————————
//自动登录
#define URL_user_auto_login @"/api/autoLogin"
//登录
#define URL_user_login @"/api/login"
//用户详情
#define URL_user_info_detail @"/api/user/info/detail"
//修改头像
#define URL_user_info_change_photo @"/api/user/info/changephoto"
//注释
#define URL_user_info_change @"/api/user/info/change"

#endif /* URLMacros_h */
