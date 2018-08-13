//
//  Dog.h
//  RealmSyncDemo
//
//  Created by ZHK on 2018/8/13.
//  Copyright © 2018年 ZHK. All rights reserved.
//

#import <Realm/Realm.h>
#import "Dish.h"

@interface Dog : RLMObject

@property NSString *did;
@property NSString *name;
@property NSDate   *created;
@property BOOL      isDelete;

@property (nonatomic, strong) RLMArray <Dish> *dishes;

@end

RLM_ARRAY_TYPE(Dog)
