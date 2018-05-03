//
//  FileManager.m
//  BasicFrame
//
//  Created by zkingsoft on 2018/5/3.
//

#import "FileManager.h"

static NSString *const CachesPath = @"Download";

@implementation FileManager

+ (instancetype)sharedFileManager {
    static FileManager *fileManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fileManager = [[FileManager alloc] init];
    });
    return fileManager;
}

/**
 获取缓存目录
 
 @return 缓存路径
 */
+ (NSString*)cacheDirectory {
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDirectory = [paths objectAtIndex:0];
    cacheDirectory = [cacheDirectory stringByAppendingPathComponent:CachesPath];
    return cacheDirectory;
}

/**
 获取NSDocumentDirectory目录
 
 @return 缓存路径
 */
+ (NSString*)cacheDocument {
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    documentDirectory = [documentDirectory stringByAppendingPathComponent:@"ZKDocument"];
    return documentDirectory;
}


/**
 创建文件目录
 
 @param fileName 文件名
 @return 文件创建结果
 */
+ (NSString *)createFile:(NSString *)fileName {
    NSString *documentsDirectory = [FileManager cacheDirectory];
    NSString * path = [documentsDirectory stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if  (![fileManager fileExistsAtPath:path isDirectory:&isDir]) {//先判断目录是否存在，不存在才创建
        BOOL res = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        if (res) {
            DLog(@"文件夹创建成功");
            return path;
        }else {
            DLog(@"文件夹创建失败");
            return nil;
        }
    }else  {
        return path;
    };
}


/**
 获取目录下的所有文件
 
 @param filePath 文件目录
 @return 文件列表
 */
+ (NSArray *)getAllFileWithFilePath:(NSString *)filePath {
    //获取当前目录下的所有文件
    NSError *error;
    NSArray *directoryContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:filePath error:&error];
    return directoryContents;
}


/**
 获取默认目录下的文件列表
 
 @return 文件列表
 */
+ (NSArray *)getAllFileAtDocument {
    //获取当前目录下的所有文件
    NSString *path = [FileManager cacheDocument];
    NSArray *directoryContents = [FileManager getAllFileWithFilePath:path];
    return directoryContents;
}


+ (BOOL)isTimeOutWithFile:(NSString *)filePath timeOut:(double)timeOut {
    //获取文件的属性
    NSDictionary *fileDict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
    //获取文件的上次的修改时间
    NSDate *lastModfyDate = fileDict.fileModificationDate;
    //算出时间差获取当前系统时间 和 lastModfyDate时间差
    NSTimeInterval sub = [[NSDate date] timeIntervalSinceDate:lastModfyDate];
    if (sub < 0) {
        sub = -sub;
    }
    //比较是否超时
    if (sub > timeOut) {
        //如果时间差大于 设置的超时时间那么就表示超时
        return YES;
    }
    return NO;
}

#pragma mark 清空缓存方法
+ (void)cleanCaches:(NSString *)path
{
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:path]) {
        NSArray *fileNameArray = [manager subpathsAtPath:path];
        for (NSString *fileName in fileNameArray) {
            //拼接绝对路径
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            //通过管理者删除文件
            [manager removeItemAtPath:absolutePath error:nil];
        }
    }
}

@end
