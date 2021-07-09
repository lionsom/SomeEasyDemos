//
//  DownloadManager.m
//  LocalNotif_OC
//
//  Created by 启业云03 on 2021/7/9.
//

#import "DownloadManager.h"


@interface DownloadManager()<NSURLSessionDelegate, NSURLSessionDownloadDelegate>

@property (nonatomic, strong) NSURLSession *session;                 // NSURLSession

@end

@implementation DownloadManager

+ (instancetype)shareManager {
    static DownloadManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    if (self = [super init]) {
        // 单线程代理队列
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        queue.maxConcurrentOperationCount = 1;

        // 后台下载标识
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"HWDownloadBackgroundSessionIdentifier"];
        // 允许蜂窝网络下载，默认为YES，这里开启，我们添加了一个变量去控制用户切换选择
        configuration.allowsCellularAccess = YES;
        
        // 创建NSURLSession，配置信息、代理、代理线程
        _session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:queue];
    }
    return self;
}

- (void)start:(NSString *)url {
    NSString *test = @"https://www.apple.com/105/media/cn/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-cn-20170912_1280x720h.mp4";
    NSString *test1 = @"http://dldir1.qq.com/qqfile/QQforMac/QQ_V5.4.0.dmg";
    NSString *test2 = @"blob:chrome-extension://cdonnmffkdaoajfknoeeecmchibpmkmg/273a0946-6e69-48db-8279-2e08edd4ad1b";

    // 创建NSURLSessionDownloadTask
    NSURLSessionDownloadTask *downloadTask = [_session downloadTaskWithURL:[NSURL URLWithString:test1]];
    // 添加描述标签
    downloadTask.taskDescription = url;
    // 启动（继续下载）
    [downloadTask resume];
}



#pragma mark - NSURLSessionDownloadDelegate

// 接收到服务器返回数据，会被调用多次
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    
    // 更新当前下载大小
    NSUInteger tmpFileSize = (NSUInteger)totalBytesWritten;
    NSUInteger totalFileSize = (NSUInteger)totalBytesExpectedToWrite;
    float progress = 1.0 * tmpFileSize / totalFileSize;
    NSLog(@"DDDDDD:%f", progress);
}

#pragma mark - NSURLSessionDelegate

// 文件下载完毕时调用
- (void)URLSession:(nonnull NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(nonnull NSURL *)location {
    NSString *patchName = @"MyFile";
    // 拼接缓存目录
    NSString *downloadDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:patchName];
    
    
    NSString *A = NSSearchPathForDirectoriesInDomains(NSTrashDirectory, NSUserDomainMask, YES).firstObject;
    
    // 打开文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 创建Download目录
    [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
    // 拼接文件路径
//    NSString *localPath = [downloadDir stringByAppendingPathComponent:];
//    NSLog(@"==== URL ==== :%@", localPath);
//
//    // 移动文件，并发送本地通知。
//    NSError *error = nil;
//    [[NSFileManager defaultManager] moveItemAtPath:[location path] toPath:localPath error:&error];
}

// 请求完成后调用，无论成功还是失败
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    NSLog(@"%s", __func__);
    if (error == nil) {
        NSLog(@"任务: %@ 成功完成", task);
    } else {
        NSLog(@"任务: %@ 发生错误: %@", task, [error localizedDescription]);
    }
}


@end
