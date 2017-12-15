//
//  Deferred.m
//  Deferred
//
//  Created by Tan on 14/12/2017.
//  Copyright © 2017 Tangent. All rights reserved.
//

#import "Deferred.h"

@interface Deferred () {
    @private
    NSRecursiveLock * _Nonnull _lock;
    NSMutableArray<DeferredItem *> * _Nullable _missions;
}

@property(nonatomic, strong, nullable) id value;

@end

@implementation Deferred

- (instancetype)init {
    if (self = [super init]) {
        _lock = [[NSRecursiveLock alloc]init];
        _missions = [NSMutableArray array];
        _value = nil;
    }
    return self;
}

+ (nonnull instancetype)deferred {
    Deferred *deferred = [[Deferred alloc]init];
    return deferred;
}

+ (nonnull instancetype)just:(nonnull id)initializedValue {
    Deferred *deferred = [Deferred deferred];
    deferred -> _value = initializedValue;
    return deferred;
}

- (void)fill:(nullable id)value {
    [_lock lock];
    _value = value;
    [self _invoke];
    [_lock unlock];
}

- (void)_invoke {
    [_lock lock];
    for (DeferredItem *obj in _missions)
        [obj.queue invoke:^{ obj.mission(_value); }];
    [_lock unlock];
}

- (void)subscribeOn:(id<DeferredQueueProtocol>)queue with:(DeferredMission)mission {
    [_lock lock];
    DeferredItem *item = [[DeferredItem alloc]initWithQueue:queue mission:mission];
    [_missions addObject:item];
    if (_value) [self _invoke];
    [_lock unlock];
}

- (void)subscribe:(nonnull DeferredMission)mission {
    [self subscribeOn:[SyncQueue shared] with:mission];
}

#pragma mark - Monad
- (nonnull Deferred *)flatMapOn:(nonnull id<DeferredQueueProtocol>)queue with:(DeferredFlatMapBlock)block {
    Deferred *newOne = [Deferred deferred];
    [self subscribeOn:queue with:^(id  _Nullable value) {
        Deferred *resultOne = block(value);
        [resultOne subscribeOn:[SyncQueue shared] with:^(id  _Nullable value) {
            [newOne fill:value];
        }];
    }];
    return newOne;
}

- (nonnull Deferred *)mapOn:(nonnull id<DeferredQueueProtocol>)queue with:(DeferredMapBlock)block {
    return [self flatMapOn:queue with:^Deferred * _Nonnull(id  _Nullable value) {
        return [Deferred just:block(value)];
    }];
}

- (nonnull Deferred *)flatMap:(nonnull DeferredFlatMapBlock)block {
    return [self flatMapOn:[SyncQueue shared] with:block];
}

- (nonnull Deferred *)map:(nonnull DeferredMapBlock)block {
    return [self mapOn:[SyncQueue shared] with:block];
}

@end
