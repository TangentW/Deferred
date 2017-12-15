//
//  DeferredItem.m
//  Deferred
//
//  Created by Tan on 14/12/2017.
//  Copyright © 2017 Tangent. All rights reserved.
//

#import "DeferredItem.h"

@interface DeferredItem ()
@property(nonatomic, strong, nonnull) id<DeferredQueueProtocol> queue;
@property(nonatomic, copy, nonnull) DeferredMission mission;
@end

@implementation DeferredItem

- (nonnull instancetype)initWithQueue:(nonnull id<DeferredQueueProtocol>)queue mission:(nonnull DeferredMission)mission {
    if (self = [super init]) {
        _queue = queue;
        _mission = mission;
    }
    return self;
}

@end
