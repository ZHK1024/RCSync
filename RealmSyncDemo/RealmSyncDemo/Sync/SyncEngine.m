//
//  SyncEngine.m
//  RealmSyncDemo
//
//  Created by ZHK on 2018/8/13.
//  Copyright © 2018年 ZHK. All rights reserved.
//

#import "SyncEngine.h"
#import <CloudKit/CloudKit.h>

static SyncEngine *engine = nil;

@interface SyncEngine ()

@property (nonatomic, strong) CKDatabase *database;
@property (nonatomic, strong) CKServerChangeToken *databaseChangeToken;

@end

@implementation SyncEngine

+ (instancetype)engine {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        engine = [[SyncEngine alloc] init];
        engine.database = CKContainer.defaultContainer.privateCloudDatabase;
    });
    return engine;
}

#pragma mark -

- (void)sync {
    [CKContainer.defaultContainer accountStatusWithCompletionHandler:^(CKAccountStatus accountStatus, NSError * _Nullable error) {
        if (accountStatus == CKAccountStatusAvailable) {
            [self fetchChangesInDatabase];
            [self resumeLongLivedOperationIfPossible];
            [self createCustomZones];
            [self startObservingRemoteChanges];
        } else {
            
        }
    }];
}

#pragma mark - Chat to the CloudKit API directly

- (void)fetchChangesInDatabase {
    if (@available(iOS 10.0, *)) {
        CKFetchDatabaseChangesOperation *operation = [[CKFetchDatabaseChangesOperation alloc] initWithPreviousServerChangeToken:_databaseChangeToken];
        operation.fetchAllChanges = YES;
        
        __weak typeof(self) ws = self;
        operation.changeTokenUpdatedBlock = ^(CKServerChangeToken * _Nonnull serverChangeToken) {
            ws.databaseChangeToken = serverChangeToken;
        };
        
        operation.fetchDatabaseChangesCompletionBlock = ^(CKServerChangeToken * _Nullable serverChangeToken, BOOL moreComing, NSError * _Nullable operationError) {
            if (operationError == nil) {
                ws.databaseChangeToken = serverChangeToken;
                [ws fetchChangesInZones];
            }
        };
        [_database addOperation:operation];
    } else {
        // Fallback on earlier versions
    }
}

- (void)fetchChangesInZones {
    if (@available(iOS 10.0, *)) {
        CKFetchRecordZoneChangesOperation *operation = [[CKFetchRecordZoneChangesOperation alloc] initWithRecordZoneIDs:[self zoneIds] optionsByRecordZoneID:[self zoneIdOptions]];
        operation.fetchAllChanges = YES;
        
        operation.recordZoneChangeTokensUpdatedBlock = ^(CKRecordZoneID * _Nonnull recordZoneID, CKServerChangeToken * _Nullable serverChangeToken, NSData * _Nullable clientChangeTokenData) {
            
        };
        
        operation.recordChangedBlock = ^(CKRecord * _Nonnull record) {
            
        };
        
        operation.recordWithIDWasDeletedBlock = ^(CKRecordID * _Nonnull recordID, NSString * _Nonnull recordType) {
            
        };
        
        operation.recordZoneFetchCompletionBlock = ^(CKRecordZoneID * _Nonnull recordZoneID, CKServerChangeToken * _Nullable serverChangeToken, NSData * _Nullable clientChangeTokenData, BOOL moreComing, NSError * _Nullable recordZoneError) {
            
        };
        
        [_database addOperation:operation];
    } else {
        // Fallback on earlier versions
    }
}


- (NSArray *)zoneIds {
    return @[];
}

- (NSDictionary *)zoneIdOptions {
    return @{};
}


- (void)createDatabaseSubscription {
    if (@available(iOS 10.0, *)) {
        CKDatabaseSubscription *subscription = [[CKDatabaseSubscription alloc] initWithSubscriptionID:@"private_changes"];
        CKNotificationInfo *info = [[CKNotificationInfo alloc] init];
        info.shouldSendContentAvailable = YES;
        subscription.notificationInfo = info;
        
        CKModifySubscriptionsOperation *operation = [[CKModifySubscriptionsOperation alloc] initWithSubscriptionsToSave:@[subscription] subscriptionIDsToDelete:nil];
        operation.qualityOfService = NSQualityOfServiceUtility;
        
        [_database addOperation:operation];
    } else {
        // Fallback on earlier versions
    }
}

- (void)startObservingRemoteChanges {
    [[NSNotificationCenter defaultCenter] addObserverForName:@"" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [self fetchChangesInDatabase];
    }];
}

#pragma mark - Long-lived Manipulation

- (void)resumeLongLivedOperationIfPossible {
    if (@available(iOS 9.3, *)) {
        [CKContainer.defaultContainer fetchAllLongLivedOperationIDsWithCompletionHandler:^(NSArray<NSString *> * _Nullable outstandingOperationIDs, NSError * _Nullable error) {
            for (NSString *ID in outstandingOperationIDs) {
                [CKContainer.defaultContainer fetchLongLivedOperationWithID:ID completionHandler:^(CKOperation * _Nullable outstandingOperation, NSError * _Nullable error) {
                    outstandingOperation.completionBlock = ^{
                        NSLog(@"Resume modify records success!");
                    };
                    [CKContainer.defaultContainer addOperation:outstandingOperation];
                }];
            }
        }];
    } else {
        // Fallback on earlier versions
    }
}

#pragma mark -

- (void)createCustomZones {
    
}

#pragma mark - Public Method

- (void)syncRecordsToCloudKit:(NSArray *)recordsToStore recordIDsToDelete:(NSArray *)recordIDsToDelete {
    CKModifyRecordsOperation *operation = [[CKModifyRecordsOperation alloc] initWithRecordsToSave:recordsToStore recordIDsToDelete:recordIDsToDelete];
    if (@available(iOS 11.0, *)) {
        CKOperationConfiguration *config = [[CKOperationConfiguration alloc] init];
        config.longLived = YES;
        operation.configuration = config;
    } else {
        // Fallback on earlier versions
        if (@available(iOS 9.3, *)) {
            operation.longLived = YES;
        } else {
            // Fallback on earlier versions
        }
    }
    operation.savePolicy = CKRecordSaveChangedKeys;
    operation.atomic = YES;
    operation.modifyRecordsCompletionBlock = ^(NSArray<CKRecord *> * _Nullable savedRecords, NSArray<CKRecordID *> * _Nullable deletedRecordIDs, NSError * _Nullable operationError) {
        if (operationError == nil) {
            if ([self subscriptionIsLocallyCached]) {
                return;
            }
            [self createDatabaseSubscription];
        }
    };
    [_database addOperation:operation];
}

- (BOOL)subscriptionIsLocallyCached {
    return YES;
}

@end
