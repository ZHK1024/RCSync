//
//  CKRecordConvertible.h
//  RealmSyncDemo
//
//  Created by ZHK on 2018/8/13.
//Copyright © 2018年 ZHK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CloudKit/CloudKit.h>

@protocol CKRecordConvertible <NSObject>

@property (nonatomic, strong, readonly) CKRecordID *recordId;
@property (nonatomic, strong, readonly) CKRecord   *record;
@property (nonatomic, assign, readonly) BOOL        isdelete;


+ (NSString *)recordType;

+ (CKRecordZoneID *)customZoneID;

@end
