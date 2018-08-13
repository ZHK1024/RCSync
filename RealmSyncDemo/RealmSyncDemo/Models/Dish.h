//
//  Dish.h
//  RealmSyncDemo
//
//  Created by ZHK on 2018/8/13.
//  Copyright © 2018年 ZHK. All rights reserved.
//

#import <Realm/Realm.h>

@interface Dish : RLMObject

@property NSString *did;
@property NSDate   *created;
@property BOOL      isDelete;

@property NSInteger index;

@end

RLM_ARRAY_TYPE(Dish)
