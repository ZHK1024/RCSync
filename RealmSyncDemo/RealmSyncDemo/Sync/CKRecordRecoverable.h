//
//  CKRecordRecoverable.h
//  RealmSyncDemo
//
//  Created by ZHK on 2018/8/14.
//Copyright © 2018年 ZHK. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CKRecord, RLMRealm;
@protocol CKRecordRecoverable <NSObject>

- (instancetype)parseFromRecord:(CKRecord *)record realm:(RLMRealm *)realm;

@end
