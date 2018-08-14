//
//  RLMObject+Syncable.h
//  RealmSyncDemo
//
//  Created by ZHK on 2018/8/14.
//Copyright © 2018年 ZHK. All rights reserved.
//

#import <Realm/Realm.h>
#import <CloudKit/CloudKit.h>

@interface RLMObject (Syncable)

@property (nonatomic, strong) CKServerChangeToken *zoneChangesToken;
@property (nonatomic, assign, getter=isCustomZoneCreated) BOOL customZoneCreated;

- (void)addRecord:(CKRecord *)record;

- (void)deleteReocrd:(CKRecord *)record;

- (void)registerLocalDatabase;

- (void)cleanUp;

@end
