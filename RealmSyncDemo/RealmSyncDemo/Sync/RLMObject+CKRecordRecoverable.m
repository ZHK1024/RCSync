//
//  RLMObject+CKRecordRecoverable.m
//  RealmSyncDemo
//
//  Created by ZHK on 2018/8/14.
//Copyright © 2018年 ZHK. All rights reserved.
//

#import "RLMObject+CKRecordRecoverable.h"

@implementation RLMObject (CKRecordRecoverable)

- (instancetype)parseFromRecord:(CKRecord *)record realm:(RLMRealm *)realm {
    id obj = [[self.superclass alloc] init];
    return obj;
}

@end
