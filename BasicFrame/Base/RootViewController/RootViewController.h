//
//  RootViewController.h
//  BasicFrame
//
//  Created by zkingsoft on 2018/5/2.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>

/**
 ViewController基类
 */
@interface RootViewController : UIViewController

/**
 *  修改状态栏颜色
 */
@property (nonatomic, assign) UIStatusBarStyle StatusBarStyle;

/**
 *  是否显示返回按钮,默认情况是YES
 */
@property (nonatomic, assign) BOOL isShowBackBtn;

/**
 是否显示导航栏
 */
@property (nonatomic, assign) BOOL isHidenNaviBar;

/**
 显示无数据页面
 */
- (void)showNoDataView;

/**
 移除无数据页面
 */
- (void)removeNoDataView;

/**
 显示加载数据视图
 */
- (void)showLoadingAnimation;

/**
 停止加载
 */
- (void)stopLoadingAnimation;

/**
 导航栏添加文本按钮

 @param titles 文本数组
 @param isLeft 是否是左边 非左即右
 @param target 目标
 @param action 点击方法
 @param tags tags数组 回调区分用
 */
- (void)addNavigationItemWithTitles:(NSArray <NSString *>*)titles isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags;

/**
 导航栏添加图片按钮

 @param imageNames 图片数组
 @param isLeft 是否是左边 非左即右
 @param target 目标
 @param action 点击方法
 @param tags tags数组 回调区分用
 */
- (void)addNavigationItemWithImageNames:(NSArray <NSString *>*)imageNames isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags;

 /**
 *  默认返回按钮的点击事件，默认是返回，子类可重写
 */
- (void)backBtnClicked;

/**
 取消网络请求
 */
- (void)cancleRequest;

@end
