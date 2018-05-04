//
//  SQLiteManager.m
//  BasicFrame
//
//  Created by zkingsoft on 2018/5/4.
//

#import "SQLiteManager.h"

static NSString *const listTableName = @"topics";
static NSString *const newListTableName = @"n_topics";
static NSString *const dbName = @"zk_topics";

static NSString *dbPath = nil;

@implementation SQLiteManager

static id _instance = nil;
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_instance) {
            _instance = [[self alloc] init];
        }
    });
    return _instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self createTable];
    }
    return self;
}

- (void)createTable {
    NSString *createTableSql = @"CREATE TABLE IF NOT EXISTS t_topics (id INTEGER PRIMARY KEY AUTOINCREMENT, topic BLOB NOT NULL, type TEXT NOT NULL, t INTEGER NOT NULL, time TEXT NOT NULL DEFAULT (datetime('now', localtime)))";
    
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        BOOL result = [db executeStatements:createTableSql];
        if (result) {
            NSLog(@"创建表成功");
        }else {
            NSLog(@"创建表失败");
        }
    }];
    
    NSString *createNewTableSql = @"CREATE TABLE IF NOT EXISTS new_t_topics (id INTEGER PRIMARY KEY AUTOINCREMENT, topic BLOB NOT NULL, type TEXT NOT NULL, t INTEGER NOT NULL, time TEXT NOT NULL DEFAULT (datetime('now', localtime)))";
    
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        BOOL result = [db executeStatements:createNewTableSql];
        if (result) {
            NSLog(@"创建表成功");
        }else {
            NSLog(@"创建表失败");
        }
    }];
}

- (void)queryArrayofDict:(NSString *)sql completion:(void(^)(NSMutableArray<NSMutableDictionary *> *dictArrayM)) completion {
    NSMutableArray<NSMutableDictionary *> *dictArrayM = [NSMutableArray array];
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet *resultSet = [db executeQuery:sql withArgumentsInArray:@[]];
        while (resultSet.next) {
            NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
            
            for (int i = 0; i < resultSet.columnCount; i ++) {
                NSString *colName = [resultSet columnNameForIndex:i];
                NSString *colValue = [resultSet objectForColumn:colName];
                dictM[colName] = colValue;
            }
            [dictArrayM addObject:dictM];
        }
        completion(dictArrayM);
    }];
}

+ (void)load {
    dbPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingString:dbName];
}

- (FMDatabaseQueue *)dbQueue {
    if (!_dbQueue) {
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    }
    return _dbQueue;
}

@end
