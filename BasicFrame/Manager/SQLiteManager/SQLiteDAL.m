//
//  SQLiteDAL.m
//  BasicFrame
//
//  Created by zkingsoft on 2018/5/4.
//

#import "SQLiteDAL.h"
#import "SQLiteManager.h"

static NSString *const listTableName = @"topics";
static NSString *const newListTableName = @"n_topics";

static const NSTimeInterval maxTime = - 7 * 24 * 3600;

@implementation SQLiteDAL

+ (void)cachesTopicList:(NSMutableArray<NSMutableDictionary *> *)topics arreaType:(NSString *)areaType {
    if (!topics) {
        return;
    }
    
    NSString *tableName = nil;
    if ([areaType isEqualToString:@"list"]) {
        tableName = listTableName;
    }else if ([areaType isEqualToString:@"newlist"]) {
        tableName = newListTableName;
    }
    
    NSString *sql = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@(topic, type, t) VALUES(?, ?, ?)", tableName];
    [[SQLiteManager sharedManager].dbQueue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        [topics enumerateObjectsUsingBlock:^(NSMutableDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            @try {
                NSData *topicData = [NSJSONSerialization dataWithJSONObject:obj options:0 error:nil];
                if (![db executeUpdate:sql withArgumentsInArray:@[topicData, obj[@"type"], obj[@"t"]]]) {
                    *stop = YES;
                    *rollback = YES;
                }
            } @catch(NSException *exception) {
                NSLog(@"存储错误: %@", exception);
            } @finally {
                
            }
        }];
    }];
}

+ (void)queryTopicListFromDiskWithAreaType:(NSString *)areaType topicType:(NSString *)topicType maxTime:(NSString *)maxTime per:(NSUInteger)per completion:(void(^)(NSMutableArray <NSMutableDictionary *> *dictArrayM)) completion {
    NSString *tableName = nil;
    if ([areaType isEqualToString:@"list"]) {
        tableName = listTableName;
    }else if ([areaType isEqualToString:@"newlist"]) {
        tableName = newListTableName;
    }
    
    NSString *sql = nil;
    NSString *count = [NSString stringWithFormat:@"%zd", per];
    if (!maxTime) {
        if ([topicType isEqualToString:@"1"]) {
            sql = [NSString stringWithFormat:@"SELECT * FROM %@ ORDER BY t DESC LIMIT %@", tableName, count];
        }else {
            sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE type = %@ ORDER BY t DESC LIMIT %@", tableName, topicType, count];
        }
    }else if (maxTime) {
        if ([topicType isEqualToString:@"1"]) {
            sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE t < %@ ORDER BY t DESC LIMIT %@", tableName, maxTime, count];
        }else {
            sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE t < %@ AND type = %@ ORDER BY t DESC LIMIT %@", tableName, maxTime, topicType, count];
        }
    }
    
    [[SQLiteManager sharedManager] queryArrayofDict:sql completion:^(NSMutableArray<NSMutableDictionary *> *dictArrayM) {
        NSMutableArray<NSMutableDictionary *> *dictArrayM_new = [NSMutableArray array];
        [dictArrayM enumerateObjectsUsingBlock:^(NSMutableDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSData *topicData = obj[@"topic"];
            @try {
                NSDictionary *topicDic = [NSJSONSerialization JSONObjectWithData:topicData options:NSJSONReadingMutableLeaves error:nil];
                [dictArrayM_new addObject:[NSMutableDictionary dictionaryWithDictionary:topicDic]];
            }@catch (NSException *exception) {
                
            }@finally {
                
            }
        }];
        
        completion(dictArrayM_new);
    }];
}

+ (void)clearOutTimeCashes {
    NSDate *earlyTime = [NSDate  dateWithTimeIntervalSinceNow:maxTime];
    NSString *earlyTimeStr = [SQLiteDAL stringWithFormat:@"yyyy-MM-dd HH:mm:ss" timeZone:nil locale:[NSLocale localeWithLocaleIdentifier:@"en_US"] date:earlyTime];
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE time < %@", listTableName, earlyTimeStr];
    [[SQLiteManager sharedManager].dbQueue  inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        BOOL result = [db executeUpdate:sql withArgumentsInArray:@[]];
        if (result) {
            *rollback = NO;
        }else {
            *rollback = YES;
        }
    }];
    
    NSString *newSql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE time < %@", newListTableName, earlyTimeStr];
    [[SQLiteManager sharedManager].dbQueue  inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        BOOL result = [db executeUpdate:newSql withArgumentsInArray:@[]];
        if (result) {
            *rollback = NO;
        }else {
            *rollback = YES;
        }
    }];
}

+ (NSString *)stringWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale date:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    if (timeZone) [formatter setTimeZone:timeZone];
    if (locale) [formatter setLocale:locale];
    return [formatter stringFromDate:date];
}

@end
