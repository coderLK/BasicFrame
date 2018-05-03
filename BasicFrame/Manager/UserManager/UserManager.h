//
//  UserManager.h
//  BasicFrame
//
//  Created by zkingsoft on 2018/4/28.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

typedef NS_ENUM(NSInteger, UserLoginType){
    kUserLoginTypeUnKnow = 0,//未知
    kUserLoginTypeWeChat,//微信登录
    kUserLoginTypeQQ,///QQ登录
    kUserLoginTypePwd,///账号登录
};

typedef void (^loginBlock)(BOOL success, NSString * des);

#define isLogin [UserManager sharedManager].isLogined
#define curUser [UserManager sharedManager].curUserInfo
#define userManager [UserManager sharedManager]


@interface UserManager : NSObject

//当前用户
@property (nonatomic, strong) UserInfo *curUserInfo;
@property (nonatomic, assign) UserLoginType loginType;
@property (nonatomic, assign) BOOL isLogined;

+ (UserManager *)sharedManager;

#pragma mark - ——————— 登录相关 ————————

/**
 三方登录
 
 @param loginType 登录方式
 @param completion 回调
 */
-(void)login:(UserLoginType )loginType completion:(loginBlock)completion;

/**
 带参登录
 
 @param loginType 登录方式
 @param params 参数，手机和账号登录需要
 @param completion 回调
 */
-(void)login:(UserLoginType )loginType params:(NSDictionary *)params completion:(loginBlock)completion;

/**
 自动登录
 
 @param completion 回调
 */
-(void)autoLoginToServer:(loginBlock)completion;

/**
 退出登录
 
 @param completion 回调
 */
- (void)logout:(loginBlock)completion;

/**
 加载缓存用户数据
 
 @return 是否成功
 */
-(BOOL)loadUserInfo;
@end
