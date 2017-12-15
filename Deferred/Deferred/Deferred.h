//
//  Deferred.h
//  Deferred
//
//  Created by Tan on 14/12/2017.
//  Copyright © 2017 Tangent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Queues.h"
#import "DeferredItem.h"
@class Deferred;

typedef Deferred * _Nonnull (^DeferredFlatMapBlock)(id _Nullable value);
typedef id _Nullable (^DeferredMapBlock)(id _Nullable value);

@interface Deferred : NSObject

@property(nonatomic, strong, readonly, nullable) id value;

+ (nonnull instancetype)deferred;
+ (nonnull instancetype)just:(nonnull id)initializedValue;

- (void)fill:(nullable id)value;
- (void)subscribeOn:(nonnull id<DeferredQueueProtocol>)queue with:(nonnull DeferredMission)mission;
- (void)subscribe:(nonnull DeferredMission)mission;

- (nonnull Deferred *)flatMapOn:(nonnull id<DeferredQueueProtocol>)queue with:(nonnull DeferredFlatMapBlock)block;
- (nonnull Deferred *)mapOn:(nonnull id<DeferredQueueProtocol>)queue with:(nonnull DeferredMapBlock)block;
- (nonnull Deferred *)flatMap:(nonnull DeferredFlatMapBlock)block;
- (nonnull Deferred *)map:(nonnull DeferredMapBlock)block;

@end
