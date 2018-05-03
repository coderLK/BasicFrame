//
//  UserInfo.h
//  BasicFrame
//
//  Created by zkingsoft on 2018/4/28.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, UserGender) {
    UserGenderUnKnow = 0,
    UserGenderMale, //男
    UserGenderFemale //女
};

@interface UserInfo : NSObject

/**
 用户ID
 */
@property(nonatomic,assign)long long userid;

/**
 展示用的用户ID
 */
@property (nonatomic,copy) NSString * idcard;

/**
 头像
 */
@property (nonatomic,copy) NSString * photo;

/**
 昵称
 */
@property (nonatomic,copy) NSString * nickname;

/**
 性别
 */
@property (nonatomic, assign) UserGender sex;
//@property (nonatomic,copy) NSString * imId;//IM账号
//@property (nonatomic,copy) NSString * imPass;//IM密码
//@property (nonatomic,assign) NSInteger  degreeId;//用户等级
//@property (nonatomic,copy) NSString * signature;//个性签名

/**
 用户登录后分配的登录Token
 */
@property (nonatomic,copy) NSString * token;

@end
