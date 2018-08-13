//
//  Person.m
//  RealmSyncDemo
//
//  Created by ZHK on 2018/8/13.
//  Copyright © 2018年 ZHK. All rights reserved.
//

#import "Person.h"

@implementation Person

+ (NSString *)primaryKey {
    return @"pid";
}

+ (NSDictionary *)defaultPropertyValues {
    return @{@"pid" : [NSUUID UUID].UUIDString};
}

@end
