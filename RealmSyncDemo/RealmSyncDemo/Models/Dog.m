//
//  Dog.m
//  RealmSyncDemo
//
//  Created by ZHK on 2018/8/13.
//  Copyright © 2018年 ZHK. All rights reserved.
//

#import "Dog.h"

@implementation Dog

+ (NSString *)primaryKey {
    return @"did";
}

+ (NSDictionary *)defaultPropertyValues {
    return @{@"did" : [NSUUID UUID].UUIDString};
}

@end
