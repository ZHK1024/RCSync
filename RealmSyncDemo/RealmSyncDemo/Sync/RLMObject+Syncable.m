//
//  RLMObject+Syncable.m
//  RealmSyncDemo
//
//  Created by ZHK on 2018/8/14.
//Copyright © 2018年 ZHK. All rights reserved.
//

#import "RLMObject+Syncable.h"
#import <Realm/Realm.h>
#import "RLMObject+CKRecordRecoverable.h"
#import "RLMObject+CKRecordConvertible.h"

@interface RLMObject ()

@property (nonatomic, strong) CKNotification *a;

@end

@implementation RLMObject (Syncable)

- (void)addRecord:(CKRecord *)record {
    dispatch_async(dispatch_get_main_queue(), ^{
        RLMRealm *realm = [RLMRealm defaultRealm];
        RLMObject *obj = [self parseFromRecord:record realm:realm];
        [realm beginWriteTransaction];
        [realm addOrUpdateObject:obj];
//        if (self.no) {
//            <#statements#>
//        }
//        nsnotificationt
//        [self object]
//        [self.superclass allObjects];
        [realm commitWriteTransaction];
        [realm commitWriteTransactionWithoutNotifying:nil error:nil];
    });
}

- (void)deleteReocrd:(CKRecord *)record {
    
}

- (void)registerLocalDatabase {
    
}

- (void)cleanUp {
    
}

#pragma mark - ZoneChangesToken

- (void)setZoneChangesToken:(CKServerChangeToken *)zoneChangesToken {
    if (zoneChangesToken == nil) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:[self zoneChangesTokenKey]];
        return;
    }
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:zoneChangesToken];
    [[NSUserDefaults standardUserDefaults] setValue:data forKey:[self zoneChangesTokenKey]];
}

- (CKServerChangeToken *)zoneChangesToken {
    NSData *data = [[NSUserDefaults standardUserDefaults] valueForKey:[self zoneChangesTokenKey]];
    if (data == nil) { return nil; }
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

- (NSString *)zoneChangesTokenKey {
    return [NSString stringWithFormat:@"%@_zoneChangesTokenKey", NSStringFromClass(self.superclass)];
}

#pragma mark - CustomZoneCreated

- (void)setCustomZoneCreated:(BOOL)customZoneCreated {
    [[NSUserDefaults standardUserDefaults] setValue:@(customZoneCreated) forKey:[self customZoneCreatedKey]];
}

- (BOOL)isCustomZoneCreated {
    return [[[NSUserDefaults standardUserDefaults] valueForKey:[self customZoneCreatedKey]] boolValue];
}

- (NSString *)customZoneCreatedKey {
    return [NSString stringWithFormat:@"%@_customZoneCreatedKey", NSStringFromClass(self.superclass)];
}

@end
