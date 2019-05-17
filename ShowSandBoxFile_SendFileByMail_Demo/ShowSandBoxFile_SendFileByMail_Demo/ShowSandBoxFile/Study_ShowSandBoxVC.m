//
//  Study_ShowSandBoxVC.m
//  TodayNews
//
//  Created by linxiang on 2019/4/29.
//  Copyright © 2019 LX. All rights reserved.
//

#import "Study_ShowSandBoxVC.h"

#import "Study_ShowSandBox_Cell.h"
#import "Study_ShowSandBox_Model.h"

// 导入头文件
#import "SKPSMTPMessage.h"
#import "NSData+Base64Additions.h"

#import "Masonry.h"
#import "SVProgressHUD+LX.h"

typedef NS_ENUM(NSInteger, SDImageFormat) {
    SDImageFormatUndefined = -1,
    SDImageFormatJPEG = 0,
    SDImageFormatPNG,
    SDImageFormatGIF,
    SDImageFormatTIFF,
    SDImageFormatWebP
};

@interface Study_ShowSandBoxVC ()<SKPSMTPMessageDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray * dataSource;
@property (nonatomic, copy) NSString * rootPath;

@end

@implementation Study_ShowSandBoxVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 初始化
    _rootPath = NSHomeDirectory();
    _dataSource = @[];
    
    // init
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(80);
        make.left.and.right.and.bottom.equalTo(self.view);
    }];
    
    // close
    UIButton *closeBtn = [[UIButton alloc] init];
    closeBtn.backgroundColor = [UIColor orangeColor];
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnCallBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(80));
        make.width.and.top.and.right.equalTo(self.view);
    }];
    
    // 加载数据
    [self loadPath:nil];
}

-(void)closeBtnCallBack {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}


- (void)loadPath:(NSString*)filePath {
    NSMutableArray* files = @[].mutableCopy;
    NSFileManager* fm = [NSFileManager defaultManager];
    
    NSString* targetPath = filePath;
    if (targetPath.length == 0 || [targetPath isEqualToString:_rootPath]) {
        targetPath = _rootPath;
    } else {
        Study_ShowSandBox_Model* file = [Study_ShowSandBox_Model new];
        file.name = @"🔙..";
        file.type = ASFileItemUp;
        file.path = filePath;
        file.filesize = @"";
        [files addObject:file];
    }
    
    NSError* err = nil;
    NSArray* paths = [fm contentsOfDirectoryAtPath:targetPath error:&err];
    for (NSString* path in paths) {
        if ([[path lastPathComponent] hasPrefix:@"."]) {
            continue;
        }
        
        BOOL isDir = false;
        NSString* fullPath = [targetPath stringByAppendingPathComponent:path];
        [fm fileExistsAtPath:fullPath isDirectory:&isDir];
        
        Study_ShowSandBox_Model* file = [Study_ShowSandBox_Model new];
        file.path = fullPath;
        if (isDir) {
            file.type = ASFileItemDirectory;
            file.name = [NSString stringWithFormat:@"%@ %@", @"📁", path];
            file.filesize = [self FileURL:fullPath isDirectory:YES];
        } else {
            file.type = ASFileItemFile;
            file.name = [NSString stringWithFormat:@"%@ %@", @"📄", path];
            file.filesize = [self FileURL:fullPath isDirectory:NO];
        }
        [files addObject:file];
    }
    _dataSource = files.copy;
    [_tableView reloadData];
}


#pragma mark- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // cell
    Study_ShowSandBox_Cell * cell = [Study_ShowSandBox_Cell cellWithTableView:tableView];
    
    Study_ShowSandBox_Model * itemModel = self.dataSource[indexPath.row];
    [cell setmodel:itemModel];
    
    //（这种是没有点击后的阴影效果)
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

#pragma mark- UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:false];

    Study_ShowSandBox_Model* item = [_dataSource objectAtIndex:indexPath.row];
    if (item.type == ASFileItemUp) {
        [self loadPath:[item.path stringByDeletingLastPathComponent]];
    } else if(item.type == ASFileItemFile) {
        NSLog(@"sharePath == %@",item.path);
        
        // 1. 实例化
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否发送邮件到开发人员邮箱" message:@"\n 开发人员：lionsom \n 邮箱：linxiang@misrobot.com" preferredStyle:UIAlertControllerStyleAlert];
        // 2. 添加方法
        [alert addAction:[UIAlertAction actionWithTitle:@"发送" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // 发送
            [self sendEmail:item];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        // 3. 显示
        [self presentViewController:alert animated:YES completion:nil];
        
    } else if(item.type == ASFileItemDirectory) {
        [self loadPath:item.path];
    }
}


#pragma mark - Lazy init

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        //设置代理
        _tableView.delegate = self;
        _tableView.dataSource =self;
        //设置不显示分割线
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        // heightForHeader 和 heightForFooter 两个delegate不执行
        _tableView.estimatedRowHeight = 0;
        if (@available(iOS 11.0, *)) {
            //当有heightForHeader delegate时设置
            _tableView.estimatedSectionHeaderHeight = 0;
            //当有heightForFooter delegate时设置
            _tableView.estimatedSectionFooterHeight = 0;
        }
        
        //其实不用判断两层，@available(iOS 11.0)会有一个else的
        if(@available(iOS 11.0, *)){
            if ([_tableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
                _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            }
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        // 解决tableview上按钮点击效果的延迟现象
        _tableView.delaysContentTouches = NO;
        
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}


#pragma mark - SKP SMTP 邮件发送
// 发送邮件 附件
- (void)sendEmail:(Study_ShowSandBox_Model *)model {
    NSString * filename = model.name;
    NSString * filepath = model.path;
    NSData * txtData = nil;
    NSData * imageData = nil;
    NSData * audioData = nil;
    NSData * videoData = nil;
    
    // 1、邮件Body文本
    NSString * content = [NSString stringWithCString:[filename UTF8String] encoding:NSUTF8StringEncoding];
    // 1.1、附件内容
    if ([filename hasSuffix:@".txt"]) {
        txtData = [NSData dataWithContentsOfFile:filepath];
    } else if ([filename hasSuffix:@".jpg"] || [filename hasSuffix:@".png"]) {
        imageData = [NSData dataWithContentsOfFile:filepath];
    } else if ([filename hasSuffix:@".mp3"]) {
        audioData = [NSData dataWithContentsOfFile:filepath];
    }  else if ([filename hasSuffix:@".mov"]) {
        videoData = [NSData dataWithContentsOfFile:filepath];
    } else {
        txtData = [NSData dataWithContentsOfFile:filepath];
    }
    // 1.2、附件内容为空，则不发送邮件
    if (txtData.length <= 0 && imageData.length <= 0 && audioData.length <=0 && videoData.length <= 0) {
        [SVProgressHUD showError:@"附件内容为空，无法送邮件" toView:self.view dismissCompletion:nil];
        return;
    }
    
    // 2、邮件内容整理
    NSDictionary *bodyPart = @{};
    NSDictionary *txtPart = @{};
    NSDictionary *imagePart = @{};
    NSDictionary *audioPart = @{};
    NSDictionary *videoPart = @{};
    if (content.length > 0) {
        // 2.1、邮件内容
        bodyPart =@{kSKPSMTPPartContentTypeKey :@"text/plain; charset=UTF-8",
                    kSKPSMTPPartMessageKey:content,
                    kSKPSMTPPartContentTransferEncodingKey :@"8bit"};
    }
    if (txtData.length > 0) {
        // 2.2、附件 - txt
        txtPart = @{kSKPSMTPPartContentTypeKey:@"text/directory;\r\n\tx-unix-mode=0644;\r\n\tname=\"text.txt\"",
                    kSKPSMTPPartContentDispositionKey:@"attachment;\r\n\tfilename=\"text.txt\"",
                    kSKPSMTPPartMessageKey:[txtData encodeBase64ForData],
                    kSKPSMTPPartContentTransferEncodingKey:@"base64"};
    }
    if (imageData.length > 0) {
        // 2.3、附件 - 图片
        imagePart = @{kSKPSMTPPartContentTypeKey:@"image/jpg;\r\n\tx-unix-mode=0644;\r\n\tname=\"image.jpg\"",
                      kSKPSMTPPartContentDispositionKey:@"attachment;\r\n\tfilename=\"image.jpg\"",
                      kSKPSMTPPartMessageKey:[imageData encodeBase64ForData],
                      kSKPSMTPPartContentTransferEncodingKey:@"base64"};
    }
    if (audioData.length > 0) {
        // 2.4、附件 - mp3
        audioPart = @{kSKPSMTPPartContentTypeKey:@"audio/mpeg;\r\n\tx-unix-mode=0644;\r\n\tname=\"audio.mp3\"",
                      kSKPSMTPPartContentDispositionKey:@"attachment;\r\n\tfilename=\"audio.mp3\"",
                      kSKPSMTPPartMessageKey:[audioData encodeBase64ForData],
                      kSKPSMTPPartContentTransferEncodingKey:@"base64"};
    }
    if (videoData.length > 0) {
        // 2.5、附件 - 视频
         videoPart = @{kSKPSMTPPartContentTypeKey:@"video/quicktime;\r\n\tx-unix-mode=0644;\r\n\tname=\"video.mov\"",
                       kSKPSMTPPartContentDispositionKey:@"attachment;\r\n\tfilename=\"video.mov\"",
                       kSKPSMTPPartMessageKey:[videoData encodeBase64ForData],
                       kSKPSMTPPartContentTransferEncodingKey:@"base64"};
    }
    
    // 3、如果有附件，则需要添加到发送数组中
    NSMutableArray * arr = [[NSMutableArray alloc] initWithCapacity:5];
    if (bodyPart.count > 0) {
        [arr addObject:bodyPart];
    }
    if (txtPart.count > 0) {
        [arr addObject:txtPart];
    }
    if (imagePart.count > 0) {
        [arr addObject:imagePart];
    }
    if (audioPart.count > 0) {
        [arr addObject:audioPart];
    }
    if (videoPart.count > 0) {
        [arr addObject:videoPart];
    }
    
// ------------------------------------------
    // 4、初始化 SKPSMTPMessage 对象
    SKPSMTPMessage *myMessage = [[SKPSMTPMessage alloc] init];
    myMessage.fromEmail = @"15151963160@163.com"; //发送邮箱
    myMessage.toEmail = @"linxiang@misrobot.com"; //收件邮箱
    // myMessage.ccEmail = @"597207909@qq.com"; //抄送
    
    myMessage.relayHost = @"smtp.163.com";//发送地址host 网易企业邮箱
    myMessage.requiresAuth = YES;
    myMessage.login = @"15151963160@163.com";//发送邮箱的用户名
    myMessage.pass = @"misrobot001";  //发送邮箱的密码
    
    myMessage.wantsSecure = YES;
    myMessage.subject = @"OSCE Log Mail";//邮件主题
    myMessage.delegate = self;
    
    myMessage.parts = [arr copy];
    
    [SVProgressHUD showMessage:@"正在发送..." toView:self.view];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        [myMessage send];
        [[NSRunLoop currentRunLoop] run];  // 这里开启一下runloop要不然重试其他端口的操作不会进行
    });
}


#pragma mark - SKPSMTPMessage Delegeate

- (void)messageSent:(SKPSMTPMessage *)message {
    [SVProgressHUD hideHUDWithCompletion:^{
        // 1. 实例化
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"邮件发送成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        // 2. 添加方法
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        // 3. 显示
        [self presentViewController:alert animated:YES completion:nil];
    }];
}

- (void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error {
    NSString *errorStr = [NSString stringWithFormat:@"error code : %ld \n %@ \n %@", (long)[error code], [error localizedDescription], [error localizedRecoverySuggestion]];
    [SVProgressHUD hideHUDWithCompletion:^{
        // 1. 实例化
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"邮件发送失败" message:errorStr preferredStyle:UIAlertControllerStyleAlert];
        // 2. 添加方法
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        // 3. 显示
        [self presentViewController:alert animated:YES completion:nil];
    }];
}


#pragma mark - 计算文件大小

- (NSString *)FileURL:(NSString *)cachepath isDirectory:(BOOL)isdirectory {
    NSFileManager * fileManager = [NSFileManager new];
    
    // 获取文件夹下面的所有文件
    NSArray *subpathArray = [fileManager subpathsAtPath:cachepath];
    NSString *filePath = nil;
    long long totleSize = 0;
    
    // 文件夹
    if (subpathArray.count > 0) {
        for (NSString *subpath in subpathArray) {
            //拼接每一个文件的全路径
            filePath = [cachepath stringByAppendingPathComponent:subpath];
            NSDictionary *dict = [fileManager attributesOfItemAtPath:filePath error:nil];
            long long size=[dict[@"NSFileSize"] longLongValue];
            totleSize+=size;
        }
    } else {
        // 单个文件
        NSDictionary *dict = [fileManager attributesOfItemAtPath:cachepath error:nil];
        long long size=[dict[@"NSFileSize"] longLongValue];
        totleSize = size;
    }
    
    //将文件夹大小转换为 G/M/KB/B
    NSString *totleStr = @"";
    if (totleSize > 1000 * 1000 * 1000) {
        totleStr = [NSString stringWithFormat:@"%.1fGB",totleSize / 1000.0f / 1000.0f / 1000.0f];
    } else if (totleSize > 1000 * 1000) {
        totleStr = [NSString stringWithFormat:@"%.1fMB",totleSize / 1000.0f / 1000.0f];
    } else if (totleSize > 1000) {
        totleStr = [NSString stringWithFormat:@"%.1fKB",totleSize / 1000.0f];
    } else {
        totleStr = [NSString stringWithFormat:@"%.1fB",totleSize / 1.0f];
    }
    return totleStr;
}


#pragma mark -- 图片类型判断

- (SDImageFormat)sd_imageFormatForImageData:(nullable NSData *)data {
    if (!data) {
        return SDImageFormatUndefined;
    }
    
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return SDImageFormatJPEG;
        case 0x89:
            return SDImageFormatPNG;
        case 0x47:
            return SDImageFormatGIF;
        case 0x49:
        case 0x4D:
            return SDImageFormatTIFF;
        case 0x52:
            // R as RIFF for WEBP
            if (data.length < 12) {
                return SDImageFormatUndefined;
            }
            
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                return SDImageFormatWebP;
            }
    }
    return SDImageFormatUndefined;
}

@end
