//
//  UtilsMacros.h
//  BasicFrame
//
//  Created by zkingsoft on 2018/5/2.
//

//全局工具类宏定义

#ifndef UtilsMacros_h
#define UtilsMacros_h

//获取系统对象
#define kApplication        [UIApplication sharedApplication]
#define kAppWindow          [UIApplication sharedApplication].delegate.window
#define kAppDelegate        [AppDelegate sharedDelegate]
#define kUserDefaults       [NSUserDefaults standardUserDefaults]

#define kStatusBarHeight    [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight       44.0
#define kTabBarHeight       (kStatusBarHeight > 20? 83:49)
#define kTopHeight          (kStatusBarHeight + kNavBarHeight)

//获取屏幕宽高
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

//屏幕适配
#define Iphone6ScaleWidth KScreenWidth/375.0
#define Iphone6ScaleHeight KScreenHeight/667.0
#define dpxScaleWidth(with) ((with)*(KScreenWidth/1024.0f))

//强弱引用
#define kWeakSelf __weak typeof(self) weakSelf = self;

//当前系统版本号
#define kSystemVersion [[UIDevice currentDevice].systemVersion doubleValue]

//-------------------打印日志-------------------------
//DEBUG  模式下打印日志,当前行
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

//拼接字符串
#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]

//字体
#define BoldFont(FONTSIZE)    [UIFont boldSystemFontOfSize:FONTSIZE]
#define SystemFont(FONTSIZE)  [UIFont systemFontOfSize:FONTSIZE]
#define FONT(NAME, FONTSIZE)  [UIFont fontWithName:(NAME) size:(FONTSIZE)]

//发送通知
#define KNotificationCenter [NSNotification defaultCenter]

#define KPostNotification(name,obj) [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj];

//数据验证
#define StrValid(f) (f!=nil && [f isKindOfClass:[NSString class]] && ![f isEqualToString:@""])
#define SafeStr(f) (StrValid(f) ? f:@"")
#define HasString(str,key) ([str rangeOfString:key].location!=NSNotFound)

#define ValidStr(f) StrValid(f)
#define ValidDict(f) (f!=nil && [f isKindOfClass:[NSDictionary class]])
#define ValidArray(f) (f!=nil && [f isKindOfClass:[NSArray class]] && [f count]>0)
#define ValidNum(f) (f!=nil && [f isKindOfClass:[NSNumber class]])
#define ValidClass(f,cls) (f!=nil && [f isKindOfClass:[cls class]])
#define ValidData(f) (f!=nil && [f isKindOfClass:[NSData class]])





#endif /* UtilsMacros_h */
