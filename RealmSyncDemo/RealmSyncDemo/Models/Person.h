//
//  Person.h
//  RealmSyncDemo
//
//  Created by ZHK on 2018/8/13.
//  Copyright © 2018年 ZHK. All rights reserved.
//

#import <Realm/Realm.h>
#import "Dog.h"

@interface Person : RLMObject

@property NSString *pid;
@property NSString *name;
@property NSDate   *created;
@property BOOL      isDelete;

@property RLMArray <Dog> *dogs;

@end
