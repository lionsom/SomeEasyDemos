//
//  QYCAvoidCrash_KVCTest_VC.m
//  Qiyeyun
//
//  Created by 启业云 on 2019/9/4.
//  Copyright © 2019 安元. All rights reserved.
//

#import "QYCAvoidCrash_KVCTest_VC.h"
#import "QYCAvoidCrash_KVCCrashObject.h"

@interface QYCAvoidCrash_KVCTest_VC ()

@end

@implementation QYCAvoidCrash_KVCTest_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
    
    // 1. key 不是对象的属性，造成崩溃
    [self testKVCCrash1];

    // 2. keyPath 不正确，造成崩溃
    [self testKVCCrash2];

    // 3. key 为 nil，造成崩溃
    [self testKVCCrash3];

    // 4. value 为 nil，为非对象设值，造成崩溃
    [self testKVCCrash4];
}


/**
 1. key 不是对象的属性，造成崩溃
 */
- (void)testKVCCrash1 {
    // 崩溃日志：[<KVCCrashObject 0x600000d48ee0> setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key XXX.;
    
    QYCAvoidCrash_KVCCrashObject *objc = [[QYCAvoidCrash_KVCCrashObject alloc] init];
    [objc setValue:@"value" forKey:@"address"];
}

/**
 2. keyPath 不正确，造成崩溃
 */
- (void)testKVCCrash2 {
    // 崩溃日志：[<KVCCrashObject 0x60000289afb0> valueForUndefinedKey:]: this class is not key value coding-compliant for the key XXX.

    QYCAvoidCrash_KVCCrashObject *objc = [[QYCAvoidCrash_KVCCrashObject alloc] init];
    [objc setValue:@"后厂村路" forKeyPath:@"address.street"];
}

/**
 3. key 为 nil，造成崩溃
 */
- (void)testKVCCrash3 {
    // 崩溃日志：'-[KVCCrashObject setValue:forKey:]: attempt to set a value for a nil key

    NSString *keyName;
    // key 为 nil 会崩溃，如果传 nil 会提示警告，传空变量则不会提示警告

    QYCAvoidCrash_KVCCrashObject *objc = [[QYCAvoidCrash_KVCCrashObject alloc] init];
    [objc setValue:@"value" forKey:keyName];
}

/**
 4. value 为 nil，造成崩溃
 */
- (void)testKVCCrash4 {
    // 崩溃日志：[<KVCCrashObject 0x6000028a6780> setNilValueForKey]: could not set nil as the value for the key XXX.

    // value 为 nil 会崩溃
    QYCAvoidCrash_KVCCrashObject *objc = [[QYCAvoidCrash_KVCCrashObject alloc] init];
    [objc setValue:nil forKey:@"age"];
}

@end
