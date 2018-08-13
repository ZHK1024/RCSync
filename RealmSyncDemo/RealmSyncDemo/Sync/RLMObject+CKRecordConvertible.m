//
//  RLMObject+CKRecordConvertible.m
//  RealmSyncDemo
//
//  Created by ZHK on 2018/8/13.
//Copyright © 2018年 ZHK. All rights reserved.
//

#import "RLMObject+CKRecordConvertible.h"
#import <objc/runtime.h>

@interface RLMObject ()

@end

@implementation RLMObject (CKRecordConvertible)

+ (NSString *)recordType {
    return NSStringFromClass(self);
}

+ (CKRecordZoneID *)customZoneID {
    NSString *zoneName = [NSString stringWithFormat:@"%@sZone", [self recordType]];
    if (@available(iOS 10.0, *)) {
        return [[CKRecordZoneID alloc] initWithZoneName:zoneName ownerName:CKCurrentUserDefaultName];
    } else {
        return [[CKRecordZoneID alloc] initWithZoneName:zoneName ownerName:CKOwnerDefaultName];
    }
}

- (CKRecord *)record {
    NSString *type = [self.superclass recordType];
    CKRecord *record = [[CKRecord alloc] initWithRecordType:type recordID:[self recordId]];
    unsigned int count = 0;
    objc_property_t *list = class_copyPropertyList(self.superclass, &count);
    for (NSInteger i = 0; i < count; i++) {
        [self record:record value:list[i]];
    }
    return record;
}

- (void)record:(CKRecord *)record value:(objc_property_t)property {
    NSString *name = [NSString stringWithFormat:@"%s", property_getName(property)];
    property_getAttributes(property);

//    NSDictionary *table = @{@"T@\"NSString\"" : @0,
//                            @"T@\"NSDate\""   : @1,
//                            @"TB"             : @2,
//                            @"T@\"RLMArray\"" : @3
//                            };
//    record setva
    NSLog(@"%@ => %@", name, [self valueForKey:name]);
}

- (CKRecordID *)recordId {
    return [[CKRecordID alloc] initWithRecordName:[self valueForKey:[[self class] primaryKey]] zoneID:[[self class] customZoneID]];
}

- (BOOL)isdelete {
    return YES;
}

@end
