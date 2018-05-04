//
//  SQLiteManager.h
//  BasicFrame
//
//  Created by zkingsoft on 2018/5/4.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>

@interface SQLiteManager : NSObject

@property (nonatomic, strong) FMDatabaseQueue *dbQueue;

+ (instancetype)sharedManager;

/**
 查询
 
 @param sql sql
 @param completion completion
 */
- (void)queryArrayofDict:(NSString *)sql completion:(void(^)(NSMutableArray<NSMutableDictionary *> *dictArrayM)) completion;

@end
