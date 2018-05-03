//
//  LKViewController.m
//  BasicFrame
//
//  Created by zkingsoft on 2018/5/3.
//

#import "ZKAlertController.h"
#import "AppDelegate+AppService.h"

//toast默认展示时间
static NSTimeInterval const ZKAlertShowDurationDefault = 1.0f;


#pragma mark - I.AlertActionModel

@interface ZKAlertActionModel : NSObject

@property (nonatomic, copy) NSString * title;
@property (nonatomic, assign) UIAlertActionStyle style;

@end

@implementation ZKAlertActionModel

- (instancetype)init
{
    if (self = [super init]) {
        self.title = @"";
        self.style = UIAlertActionStyleDefault;
    }
    return self;
}
@end



#pragma mark - II.ZKAlertController
/**
 AlertActions配置
 
 @param actionBlock JXTAlertActionBlock
 */
typedef void (^ZKAlertActionsConfig)(ZKAlertActionBlock actionBlock);


@interface ZKAlertController ()
//JXTAlertActionModel数组
@property (nonatomic, strong) NSMutableArray <ZKAlertActionModel *>* zk_alertActionArray;
//是否操作动画
@property (nonatomic, assign) BOOL zk_setAlertAnimated;
//action配置
- (ZKAlertActionsConfig)alertActionsConfig;

@end

@implementation ZKAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (self.alertDidDismiss) {
        self.alertDidDismiss();
    }
}
- (void)dealloc
{
    //    NSLog(@"test-dealloc");
}

#pragma mark - Private
//action-title数组
- (NSMutableArray<ZKAlertActionModel *> *)jxt_alertActionArray
{
    if (_zk_alertActionArray == nil) {
        _zk_alertActionArray = [NSMutableArray array];
    }
    return _zk_alertActionArray;
}
//action配置
- (ZKAlertActionsConfig)alertActionsConfig
{
    return ^(ZKAlertActionBlock actionBlock) {
        if (self.jxt_alertActionArray.count > 0)
        {
            //创建action
            __weak typeof(self)weakSelf = self;
            [self.zk_alertActionArray enumerateObjectsUsingBlock:^(ZKAlertActionModel *actionModel, NSUInteger idx, BOOL * _Nonnull stop) {
                UIAlertAction *alertAction = [UIAlertAction actionWithTitle:actionModel.title style:actionModel.style handler:^(UIAlertAction * _Nonnull action) {
                    __strong typeof(weakSelf)strongSelf = weakSelf;
                    if (actionBlock) {
                        actionBlock(idx, action, strongSelf);
                    }
                }];
                //可利用这个改变字体颜色，但是不推荐！！！
                //                [alertAction setValue:[UIColor grayColor] forKey:@"titleTextColor"];
                //action作为self元素，其block实现如果引用本类指针，会造成循环引用
                [self addAction:alertAction];
            }];
        }
        else
        {
            NSTimeInterval duration = self.toastStyleDuration > 0 ? self.toastStyleDuration : ZKAlertShowDurationDefault;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:!(self.zk_setAlertAnimated) completion:NULL];
            });
        }
    };
}

#pragma mark - Public

- (instancetype)initAlertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle
{
    if (!(title.length > 0) && (message.length > 0) && (preferredStyle == UIAlertControllerStyleAlert)) {
        title = @"";
    }
    self = [[self class] alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    if (!self) return nil;
    
    self.zk_setAlertAnimated = NO;
    self.toastStyleDuration = ZKAlertShowDurationDefault;
    
    return self;
}

- (void)alertAnimateDisabled
{
    self.zk_setAlertAnimated = YES;
}

- (ZKAlertActionTitle)addActionDefaultTitle
{
    //该block返回值不是本类属性，只是局部变量，不会造成循环引用
    return ^(NSString *title) {
        ZKAlertActionModel *actionModel = [[ZKAlertActionModel alloc] init];
        actionModel.title = title;
        actionModel.style = UIAlertActionStyleDefault;
        [self.zk_alertActionArray addObject:actionModel];
        return self;
    };
}

- (ZKAlertActionTitle)addActionCancelTitle
{
    return ^(NSString *title) {
        ZKAlertActionModel *actionModel = [[ZKAlertActionModel alloc] init];
        actionModel.title = title;
        actionModel.style = UIAlertActionStyleCancel;
        [self.zk_alertActionArray addObject:actionModel];
        return self;
    };
}

- (ZKAlertActionTitle)addActionDestructiveTitle
{
    return ^(NSString *title) {
        ZKAlertActionModel *actionModel = [[ZKAlertActionModel alloc] init];
        actionModel.title = title;
        actionModel.style = UIAlertActionStyleDestructive;
        [self.zk_alertActionArray addObject:actionModel];
        return self;
    };
}

@end



#pragma mark - III.UIViewController扩展
@implementation UIViewController (ZKAlert)

- (void)zk_showAlertWithPreferredStyle:(UIAlertControllerStyle)preferredStyle title:(NSString *)title message:(NSString *)message appearanceProcess:(ZKAlertAppearanceProcess)appearanceProcess actionsBlock:(ZKAlertActionBlock)actionBlock
{
    if (appearanceProcess)
    {
        ZKAlertController *alertMaker = [[ZKAlertController alloc] initAlertControllerWithTitle:title message:message preferredStyle:preferredStyle];
        //防止nil
        if (!alertMaker) {
            return ;
        }
        //加工链
        appearanceProcess(alertMaker);
        //配置响应
        alertMaker.alertActionsConfig(actionBlock);
        //        alertMaker.alertActionsConfig(^(NSInteger buttonIndex, UIAlertAction *action){
        //            if (actionBlock) {
        //                actionBlock(buttonIndex, action);
        //            }
        //        });
        
        if (alertMaker.alertDidShown)
        {
            [self presentViewController:alertMaker animated:!(alertMaker.zk_setAlertAnimated) completion:^{
                alertMaker.alertDidShown();
            }];
        }
        else
        {
            [self presentViewController:alertMaker animated:!(alertMaker.zk_setAlertAnimated) completion:NULL];
        }
    }
}

- (void)zk_showAlertWithTitle:(NSString *)title message:(NSString *)message appearanceProcess:(ZKAlertAppearanceProcess)appearanceProcess actionsBlock:(ZKAlertActionBlock)actionBlock
{
    [self zk_showAlertWithPreferredStyle:UIAlertControllerStyleAlert title:title message:message appearanceProcess:appearanceProcess actionsBlock:actionBlock];
}

- (void)zk_showActionSheetWithTitle:(NSString *)title message:(NSString *)message appearanceProcess:(ZKAlertAppearanceProcess)appearanceProcess actionsBlock:(ZKAlertActionBlock)actionBlock
{
    [self zk_showAlertWithPreferredStyle:UIAlertControllerStyleActionSheet title:title message:message appearanceProcess:appearanceProcess actionsBlock:actionBlock];
}


@end

@implementation UIAlertController (ZK)

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
                 actionsBlock:(nullable ZKAlertActionBlock)actionBlock NS_AVAILABLE_IOS(8_0)
{
    [[[AppDelegate shareAppDelegate] getCurrentUIVC] zk_showAlertWithTitle:title message:message appearanceProcess:appearanceProcess actionsBlock:actionBlock];
}

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
                       actionsBlock:(nullable ZKAlertActionBlock)actionBlock NS_AVAILABLE_IOS(8_0)
{
    [[[AppDelegate shareAppDelegate] getCurrentUIVC] zk_showActionSheetWithTitle:title message:message appearanceProcess:appearanceProcess actionsBlock:actionBlock];
}

@end
