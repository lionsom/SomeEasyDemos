//
//  Person.m
//  Category与继承
//
//  Created by 启业云 on 2019/7/23.
//  Copyright © 2019 启业云. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>


@implementation Person

-(void)play {
    NSLog(@"in Person Play");
}

#pragma mark - description

-(NSString *)description {
    return [NSString stringWithFormat:@"<%@ : %p> , name = %@, age = %ld, sex = %@, school = %@ , height = %@ , weight = %ld",[self class], self, self.name, (long)self.age, self.sex, self.school, self.height, (long)self.weight];
}

@end


@implementation Person (C)

-(void)setHeight:(NSString *)height {
    objc_setAssociatedObject(self, @selector(height), height, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)height {
    return objc_getAssociatedObject(self, _cmd);
}


- (void)setWeight:(NSNumber *)weight {
    objc_setAssociatedObject(self, @selector(weight), weight, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSNumber *)weight {
    return objc_getAssociatedObject(self, _cmd);
}


-(void)play_C {
    
    NSLog(@"in Person Play_C");
}

@end
