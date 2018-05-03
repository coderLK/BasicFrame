//
//  FileManager.h
//  BasicFrame
//
//  Created by zkingsoft on 2018/5/3.
//

#import <Foundation/Foundation.h>

/**
 文件存储
 */
@interface FileManager : NSObject

+ (instancetype)sharedFileManager;

/**
 获取NSDocumentDirectory目录
 
 @return 缓存路径
 */
+ (NSString*)cacheDocument;

/**
 创建缓存文件

 @param fileName 文件名
 @return 文件路径
 */
+ (NSString *)createFile:(NSString *)fileName;

@end
