//
//  RootTableViewController.h
//  BasicFrame
//
//  Created by zkingsoft on 2018/5/2.
//

#import "RootViewController.h"

@interface RootTableViewController : RootViewController

@property (nonatomic, strong) UITableView *tableView;

/**
 结束刷新
 */
- (void)endHeaderFooterRefreshing;

@end
