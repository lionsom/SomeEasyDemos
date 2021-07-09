//
//  DownloadManager.h
//  LocalNotif_OC
//
//  Created by 启业云03 on 2021/7/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DownloadManager : NSObject

+ (instancetype)shareManager;

- (void)start:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
