//
//  OSCELOGManager.m
//  OSCE_GRADE_PAD
//
//  Created by linxiang on 2019/5/7.
//  Copyright © 2019 minxing. All rights reserved.
//

#import "OSCELOGManager.h"
#import <UIKit/UIKit.h>

static const NSInteger kDefaultCacheMaxCacheAge = 60 * 60 * 24 * 7; // 1 week
static const NSInteger kMaxCacheSize = 30 * 1024 * 1024;        // The maximum size of the cache, in bytes.  30M

typedef void(^OSCELOGNoParamsBlock)(void);

@interface OSCELOGManager()

@property (strong, nonatomic, nonnull) NSString *diskCachePath;

@property (strong, nonatomic, nullable) dispatch_queue_t ioQueue;

@end

@implementation OSCELOGManager {
    NSFileManager *_fileManager;
}

+(instancetype)shareManager {
    static OSCELOGManager * _manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 初始化单例
        _manager = [[OSCELOGManager alloc] init];
    });
    return _manager;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        [self createDirectory];
    }
    return self;
}

-(void)createDirectory {
// 参考自SDWebImage
    // Create IO serial queue
    _ioQueue = dispatch_queue_create("com.OSCE.Cache", DISPATCH_QUEUE_SERIAL);
    
    // Init the disk cache   // Library/Caches
    _diskCachePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"OSCE"];
    
    // 创建目录
    dispatch_sync(_ioQueue, ^{
        _fileManager = [NSFileManager new];
        // 创建目录
        [_fileManager createDirectoryAtPath:_diskCachePath withIntermediateDirectories:YES attributes:nil error:nil];
    });
    
    
    // 清除缓存的时机
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deleteOldFiles)
                                                 name:UIApplicationWillTerminateNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(backgroundDeleteOldFiles)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
}

-(void)writeLogToFile:(NSString *)file :(NSString *)function :(NSString *)line :(NSString *)format, ...{
    //1.获取时间戳
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    //2.格式化时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    //3.直接转换
    NSString * dateString = [formatter stringFromDate:date];
    //4.文件名、文件路径
    NSString * txtname = [NSString stringWithFormat:@"%@.txt",dateString];
    NSString *filepath = [_diskCachePath stringByAppendingPathComponent:txtname];
    // 创建文件
    dispatch_async(_ioQueue, ^{
        if (![_fileManager fileExistsAtPath:filepath]) {
            [_fileManager createFileAtPath:filepath contents:nil attributes:nil];
        }
    });
    
    // 内容格式  日期+内容+文件名+函数名+行号+content
    NSDateFormatter *contentFormatter = [[NSDateFormatter alloc] init];
    [contentFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    [contentFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    NSString * contentDateString = [contentFormatter stringFromDate:date];
    
    // 线程
    NSString * currentThread = @"";
    if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {
        currentThread = @"Main Thread";
    } else {
        currentThread = @"Sub Thread";
    }
    
    // 此段代码参考自CocoaLumberjack框架
    va_list args;
    if (format) {
        va_start(args, format);
        
        NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
        
        NSString * newContent = [NSString stringWithFormat:@"[%@] [%@] [%@] [Line:%@] [%@] [%@] \n\n",contentDateString ,file ,function ,line ,currentThread, message];
        
        // 异步执行 + 串行队列
        // 会开启新线程，但是因为任务是串行的，执行完一个任务，再执行下一个任务。
        dispatch_async(_ioQueue, ^{
        // 写入文件
            //初始化一个用于写入的文件句柄
            NSFileHandle * fileHandle = [NSFileHandle fileHandleForWritingAtPath:filepath];
            //将文件光标移动到文件的最后位置
            [fileHandle seekToEndOfFile];
            NSData * data=[newContent dataUsingEncoding:NSUTF8StringEncoding];
            //写入数据
            [fileHandle writeData:data];
            //用完之后需要关掉
            [fileHandle closeFile];
        });
        
        va_end(args);
    }
}

#pragma mark - 日志清理

- (void)deleteOldFiles {
    [self deleteOldFilesWithCompletionBlock:nil];
}

- (void)backgroundDeleteOldFiles {
    Class UIApplicationClass = NSClassFromString(@"UIApplication");
    if(!UIApplicationClass || ![UIApplicationClass respondsToSelector:@selector(sharedApplication)]) {
        return;
    }
    UIApplication *application = [UIApplication performSelector:@selector(sharedApplication)];
    __block UIBackgroundTaskIdentifier bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
        // Clean up any unfinished task business by marking where you
        // stopped or ending the task outright.
        [application endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }];
    
    // Start the long-running task and return immediately.
    [self deleteOldFilesWithCompletionBlock:^{
        [application endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }];
}


- (void)deleteOldFilesWithCompletionBlock:(nullable OSCELOGNoParamsBlock)completionBlock {
    dispatch_async(self.ioQueue, ^{
        NSURL *diskCacheURL = [NSURL fileURLWithPath:self.diskCachePath isDirectory:YES];
        NSArray<NSString *> *resourceKeys = @[NSURLIsDirectoryKey, NSURLContentModificationDateKey, NSURLTotalFileAllocatedSizeKey];
        
        // This enumerator prefetches useful properties for our cache files.
        NSDirectoryEnumerator *fileEnumerator = [_fileManager enumeratorAtURL:diskCacheURL
                                                   includingPropertiesForKeys:resourceKeys
                                                                      options:NSDirectoryEnumerationSkipsHiddenFiles
                                                                 errorHandler:NULL];
        
        NSDate *expirationDate = [NSDate dateWithTimeIntervalSinceNow:-kDefaultCacheMaxCacheAge];
        NSMutableDictionary<NSURL *, NSDictionary<NSString *, id> *> *cacheFiles = [NSMutableDictionary dictionary];
        NSUInteger currentCacheSize = 0;
        
        // Enumerate all of the files in the cache directory.  This loop has two purposes:
        //
        //  1. Removing files that are older than the expiration date.
        //  2. Storing file attributes for the size-based cleanup pass.
        NSMutableArray<NSURL *> *urlsToDelete = [[NSMutableArray alloc] init];
        for (NSURL *fileURL in fileEnumerator) {
            NSError *error;
            NSDictionary<NSString *, id> *resourceValues = [fileURL resourceValuesForKeys:resourceKeys error:&error];
            
            // Skip directories and errors.
            if (error || !resourceValues || [resourceValues[NSURLIsDirectoryKey] boolValue]) {
                continue;
            }
            
            // Remove files that are older than the expiration date;
            NSDate *modificationDate = resourceValues[NSURLContentModificationDateKey];
            if ([[modificationDate laterDate:expirationDate] isEqualToDate:expirationDate]) {
                [urlsToDelete addObject:fileURL];
                continue;
            }
            
            // Store a reference to this file and account for its total size.
            NSNumber *totalAllocatedSize = resourceValues[NSURLTotalFileAllocatedSizeKey];
            currentCacheSize += totalAllocatedSize.unsignedIntegerValue;
            cacheFiles[fileURL] = resourceValues;
        }
        
        for (NSURL *fileURL in urlsToDelete) {
            [_fileManager removeItemAtURL:fileURL error:nil];
        }
        
        // If our remaining disk cache exceeds a configured maximum size, perform a second
        // size-based cleanup pass.  We delete the oldest files first.
        if (kMaxCacheSize > 0 && currentCacheSize > kMaxCacheSize) {
            // Target half of our maximum cache size for this cleanup pass.
            const NSUInteger desiredCacheSize = kMaxCacheSize / 2;
            
            // Sort the remaining cache files by their last modification time (oldest first).
            NSArray<NSURL *> *sortedFiles = [cacheFiles keysSortedByValueWithOptions:NSSortConcurrent
                                                                     usingComparator:^NSComparisonResult(id obj1, id obj2) {
                                                                         return [obj1[NSURLContentModificationDateKey] compare:obj2[NSURLContentModificationDateKey]];
                                                                     }];
            
            // Delete files until we fall below our desired cache size.
            for (NSURL *fileURL in sortedFiles) {
                if ([_fileManager removeItemAtURL:fileURL error:nil]) {
                    NSDictionary<NSString *, id> *resourceValues = cacheFiles[fileURL];
                    NSNumber *totalAllocatedSize = resourceValues[NSURLTotalFileAllocatedSizeKey];
                    currentCacheSize -= totalAllocatedSize.unsignedIntegerValue;
                    
                    if (currentCacheSize < desiredCacheSize) {
                        break;
                    }
                }
            }
        }
        if (completionBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock();
            });
        }
    });
}

@end
