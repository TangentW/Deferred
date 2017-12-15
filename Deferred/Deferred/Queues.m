//
//  Queues.m
//  Deferred
//
//  Created by Tan on 14/12/2017.
//  Copyright © 2017 Tangent. All rights reserved.
//

#import "Queues.h"

@implementation MainQueue
- (void)invoke:(EmptyBlock)block {
    dispatch_async(dispatch_get_main_queue(), ^{
        block();
    });
}

+ (instancetype)shared {
    static MainQueue *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance)
            instance = [[MainQueue alloc]init];
    });
    return instance;
}
@end

// ---
@implementation SyncQueue
- (void)invoke:(EmptyBlock)block {
    block();
}

+ (nonnull instancetype)shared {
    static SyncQueue *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance)
            instance = [[SyncQueue alloc]init];
    });
    return instance;
}
@end

// ---
@implementation AsyncQueue
- (void)invoke:(EmptyBlock)block {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        block();
    });
}

+ (instancetype)shared {
    static AsyncQueue *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance)
            instance = [[AsyncQueue alloc]init];
    });
    return instance;
}
@end

// ---
@interface CustomQueue () {
    dispatch_queue_t _Nonnull _queue;
}
@end

@implementation CustomQueue
- (instancetype)initWithGCDQueue:(nonnull dispatch_queue_t)queue {
    if (self = [super init]) {
        _queue = queue;
    }
    return self;
}

- (void)invoke:(EmptyBlock)block {
    dispatch_async(_queue, ^{
        block();
    });
}
@end
