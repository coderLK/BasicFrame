//
//  FileDownloadManager.m
//  BasicFrame
//
//  Created by zkingsoft on 2018/5/4.
//

#import "FileDownloadManager.h"
#import "FileManager.h"

static NSString *const CachesL = @"NSFileSize";

@interface FileDownloadManager()<NSURLSessionDataDelegate>

@property (nonatomic , strong) NSOutputStream *stream;

@property (nonatomic , assign) NSInteger currentLength;

@property (nonatomic , assign) NSInteger totalLength;

@property (nonatomic , strong) NSURLSession *session;

@property (nonatomic , strong) NSURLSessionDataTask *task;

@property (nonatomic , copy) NSString *urlPath;

@property (nonatomic , copy) NSString *fileName;

@end

@implementation FileDownloadManager

+ (instancetype)sharedFileDownloadManager {
    static FileDownloadManager *downloadManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        downloadManager = [[FileDownloadManager alloc] init];
    });
    return downloadManager;
}

- (void)networkConfig {
    //NSURLSession *session = [NSURLSession sharedSession];
    // 使用代理方法请求
    /**
     参数一：配置信息
     参数二：代理
     参数三：控制代理方法在哪个线程中调用
     遵守代理:NSURLSessionDataDelegate
     */
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURL *url =[NSURL URLWithString:@"http://120.25.226.186:32812/login?username=520it&pwd=520it&type=JSON"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request];
    [dataTask resume];
}

- (void)urlSessionDowmload:(NSString *)urlStr {
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request];
    [task resume];
}

- (void)startDownLoad {
    [self.task resume];
}

- (void)stopDownLoad {
    [self.task suspend];
}

- (void)saveTotalLength:(NSInteger)lenght {
    NSNumber *number = [[NSNumber alloc] initWithInteger:lenght];
    NSDictionary *dic = @{number: CachesL};
    [[FileManager sharedFileManager] saveDicToFile:dic withFileName:CachesL];
}

#pragma mark 懒加载
- (NSURLSession *)session {
    if (!_session) {
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;
}

- (NSURLSessionDataTask *)task {
    if (!_task) {
        NSDictionary *dic = [[FileManager sharedFileManager] getCacheDicFromPath:CachesL];
        self.currentLength = [[dic objectForKey:CachesL] integerValue];
        NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_02.mp4"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        NSString *range =[NSString stringWithFormat:@"bytes=%zd-",self.currentLength];
        [request setValue:range forHTTPHeaderField:@"Range"];
        _task = [self.session dataTaskWithRequest:request];
    }
    return _task;
}

#pragma mark - NSURLSessionDataDelegate
// 接收到服务器响应的时候调用
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    // 拿到文件总大小 获得的是当次请求的数据大小，当我们关闭程序以后重新运行，开下载请求的数据是不同的 ,所以要加上之前已经下载过的内容
    NSLog(@"接收到服务器响应");
    self.totalLength = response.expectedContentLength + self.currentLength;
    // 把文件总大小保存到沙盒 没有必要每次都存储一次,只有当第一次接收到响应，self.currentLength为零时，存储文件总大小就可以了
    if (self.currentLength == 0) {
        [self saveTotalLength:self.totalLength];
    }
    NSString *caches = [FileManager cacheDirectory];
    NSLog(@"%@",caches);
    // 创建输出流 如果没有文件会创建文件，YES：会往后面进行追加
    NSOutputStream *stream = [[NSOutputStream alloc]initToFileAtPath:caches append:YES];
    [stream open];
    self.stream = stream;
    //NSLog(@"didReceiveResponse 接受到服务器响应");
    completionHandler(NSURLSessionResponseAllow);
    
    
    // completionHandler 控制是否接受服务器返回的数据
    /**
     typedef NS_ENUM(NSInteger, NSURLSessionResponseDisposition) {
     NSURLSessionResponseCancel = 0, // 默认，表示不接收数据
     NSURLSessionResponseAllow = 1,   // 接受数据
     NSURLSessionResponseBecomeDownload = 2,
     NSURLSessionResponseBecomeStream NS_ENUM_AVAILABLE(10_11, 9_0) = 3,
     }
     */
}

// 接收到服务器返回数据时调用，会调用多次
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    self.currentLength += data.length;
    // 输出流写数据
    [self.stream write:data.bytes maxLength:data.length];
    NSLog(@"%f",1.0 * self.currentLength / self.totalLength);
}

// 当请求完成之后调用，如果请求失败error有值
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    // 关闭stream
    [self.stream close];
    self.stream = nil;
    NSLog(@"didCompleteWithError 请求完成");
}

- (void)dealloc {
    [self saveTotalLength:self.currentLength];
}


@end
