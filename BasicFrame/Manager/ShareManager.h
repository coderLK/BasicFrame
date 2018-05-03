//
//  ShareManager.h
//  BasicFrame
//
//  Created by zkingsoft on 2018/5/3.
//

#import <Foundation/Foundation.h>

/**
 分享 相关服务
 */
@interface ShareManager : NSObject

+ (instancetype)shareadShareManager;

/**
 展示分享页面
 */
-(void)showShareView;

@end
