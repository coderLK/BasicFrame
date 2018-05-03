//
//  LKViewController.h
//  BasicFrame
//
//  Created by zkingsoft on 2018/5/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - I.ZKAlertController构造

@class ZKAlertController;
/**
 ZKAlertController: alertAction配置链
 
 @param title 标题
 @return      ZKAlertController对象
 */
typedef ZKAlertController * _Nonnull (^ZKAlertActionTitle)(NSString *title);

/**
 ZKAlertController: alert按钮执行回调
 
 @param buttonIndex 按钮index(根据添加action的顺序)
 @param action      UIAlertAction对象
 @param alertSelf   本类对象
 */
typedef void (^ZKAlertActionBlock)(NSInteger buttonIndex, UIAlertAction *action, ZKAlertController *alertSelf);



NS_CLASS_AVAILABLE_IOS(8_0) @interface ZKAlertController : UIAlertController

/**
 ZKAlertController: 禁用alert弹出动画，默认执行系统的默认弹出动画
 */
- (void)alertAnimateDisabled;

/**
 ZKAlertController: alert弹出后，可配置的回调
 */
@property (nullable, nonatomic, copy) void (^alertDidShown)(void);

/**
 ZKAlertController: alert关闭后，可配置的回调
 */
@property (nullable, nonatomic, copy) void (^alertDidDismiss)(void);

/**
 ZKAlertController: 设置toast模式展示时间：如果alert未添加任何按钮，将会以toast样式展示，这里设置展示时间，默认1s
 */
@property (nonatomic, assign) NSTimeInterval toastStyleDuration;


/**
 ZKAlertController: 链式构造alert视图按钮，添加一个alertAction按钮，默认样式，参数为标题
 
 @return ZKAlertController对象
 */
- (ZKAlertActionTitle)addActionDefaultTitle;

/**
 ZKAlertController: 链式构造alert视图按钮，添加一个alertAction按钮，取消样式，参数为标题(warning:一个alert该样式只能添加一次!!!)
 
 @return ZKAlertController对象
 */
- (ZKAlertActionTitle)addActionCancelTitle;

/**
 ZKAlertController: 链式构造alert视图按钮，添加一个alertAction按钮，警告样式，参数为标题
 
 @return ZKAlertController对象
 */
- (ZKAlertActionTitle)addActionDestructiveTitle;

@end


#pragma mark - II.UIViewController扩展使用ZKAlertController

/**
 ZKAlertController: alert构造块
 
 @param alertMaker ZKAlertController配置对象
 */
typedef void(^ZKAlertAppearanceProcess)(ZKAlertController *alertMaker);

@interface UIViewController (ZKAlert)

/**
 ZKAlertController: show-alert(iOS8)
 
 @param title             title
 @param message           message
 @param appearanceProcess alert配置过程
 @param actionBlock       alert点击响应回调
 */
- (void)zk_showAlertWithTitle:(nullable NSString *)title
                       message:(nullable NSString *)message
             appearanceProcess:(ZKAlertAppearanceProcess)appearanceProcess
                  actionsBlock:(nullable ZKAlertActionBlock)actionBlock NS_AVAILABLE_IOS(8_0);

/**
 ZKAlertController: show-actionSheet(iOS8)
 
 @param title             title
 @param message           message
 @param appearanceProcess actionSheet配置过程
 @param actionBlock       actionSheet点击响应回调
 */
- (void)zk_showActionSheetWithTitle:(nullable NSString *)title
                             message:(nullable NSString *)message
                   appearanceProcess:(ZKAlertAppearanceProcess)appearanceProcess
                        actionsBlock:(nullable ZKAlertActionBlock)actionBlock NS_AVAILABLE_IOS(8_0);

@end

@interface UIAlertController (ZK)
/**
 ZKAlertController: show-alert(iOS8)
 
 @param title             title
 @param message           message
 @param appearanceProcess alert配置过程
 @param actionBlock       alert点击响应回调
 */
+ (void)mj_showAlertWithTitle:(nullable NSString *)title
                      message:(nullable NSString *)message
            appearanceProcess:(ZKAlertAppearanceProcess)appearanceProcess
                 actionsBlock:(nullable ZKAlertActionBlock)actionBlock NS_AVAILABLE_IOS(8_0);

/**
 ZKAlertController: show-actionSheet(iOS8)
 
 @param title             title
 @param message           message
 @param appearanceProcess actionSheet配置过程
 @param actionBlock       actionSheet点击响应回调
 */
+ (void)mj_showActionSheetWithTitle:(nullable NSString *)title
                            message:(nullable NSString *)message
                  appearanceProcess:(ZKAlertAppearanceProcess)appearanceProcess
                       actionsBlock:(nullable ZKAlertActionBlock)actionBlock NS_AVAILABLE_IOS(8_0);
@end

NS_ASSUME_NONNULL_END
