//
//  DeferredItem.h
//  Deferred
//
//  Created by Tan on 14/12/2017.
//  Copyright © 2017 Tangent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Queues.h"

typedef void(^DeferredMission)(id _Nullable value);

@interface DeferredItem : NSObject

@property(nonatomic, strong, nonnull, readonly) id<DeferredQueueProtocol> queue;
@property(nonatomic, copy, nonnull, readonly) DeferredMission mission;

- (nonnull instancetype)initWithQueue:(nonnull id<DeferredQueueProtocol>)queue mission:(nonnull DeferredMission)mission;

@end
