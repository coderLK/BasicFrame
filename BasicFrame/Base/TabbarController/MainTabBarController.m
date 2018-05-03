//
//  MainTabBarController.m
//  BasicFrame
//
//  Created by zkingsoft on 2018/5/2.
//

#import "MainTabBarController.h"
#import "RootNavigationController.h"
#import "Header.h"

@interface MainTabBarController ()

@property (nonatomic, strong) NSMutableArray *VCS;

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化tabbar
    [self setUpTabBar];
    //添加子控制器
    [self setUpChildViewController];
}

#pragma mark ————— 初始化TabBar —————
- (void)setUpTabBar {
    //设置背景色 去掉分割线
    //[self setValue:[XYTabBar new] forKey:@"tabBar"];
    [self.tabBar setBackgroundColor:[UIColor whiteColor]];
    [self.tabBar setBackgroundImage:[UIImage new]];
    //通过这两个参数来调整badge位置
    //    [self.tabBar setTabIconWidth:29];
    //    [self.tabBar setBadgeTop:9];
}

#pragma mark - ——————— 初始化VC ————————
- (void)setUpChildViewController {
    
}

-(void)setupChildViewController:(UIViewController*)controller title:(NSString *)title imageName:(NSString *)imageName seleceImageName:(NSString *)selectImageName{
    controller.title = title;
    controller.tabBarItem.title = title;//跟上面一样效果
    controller.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //未选中字体颜色
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:kBlackColor,NSFontAttributeName:SystemFont(10.0f)} forState:UIControlStateNormal];
    
    //选中字体颜色
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:CNavBgColor,NSFontAttributeName:SystemFont(10.0f)} forState:UIControlStateSelected];
    //包装导航控制器
    RootNavigationController *nav = [[RootNavigationController alloc]initWithRootViewController:controller];
    
    //    [self addChildViewController:nav];
    [_VCS addObject:nav];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
