//
//  RootCollectionViewController.m
//  BasicFrame
//
//  Created by zkingsoft on 2018/5/2.
//

#import "RootCollectionViewController.h"
#import "Header.h"

@interface RootCollectionViewController ()

@end

@implementation RootCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth , kScreenHeight - kTopHeight - kTabBarHeight) collectionViewLayout:flow];
        
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
        header.automaticallyChangeAlpha = YES;
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.hidden = YES;
        _collectionView.mj_header = header;
        
        //底部刷新
        _collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
        
        //#ifdef kiOS11Before
        //
        //#else
        //        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        //        _collectionView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
        //        _collectionView.scrollIndicatorInsets = _collectionView.contentInset;
        //#endif
        
        _collectionView.backgroundColor = CViewBgColor;
        _collectionView.scrollsToTop = YES;
    }
    return _collectionView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)headerRereshing {
    
}

- (void)footerRereshing {
    
}


/**
 结束刷新
 */
- (void)endHeaderFooterRefreshing
{
    NSLog(@"tableview----------------endHeaderFooterRefreshing");
    // 结束刷新状态
    ![self.collectionView.mj_header isRefreshing] ?: [self.collectionView.mj_header endRefreshing];
    ![self.collectionView.mj_footer isRefreshing] ?: [self.collectionView.mj_footer endRefreshing];
}


@end
