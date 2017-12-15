//
//  Queues.h
//  Deferred
//
//  Created by Tan on 14/12/2017.
//  Copyright © 2017 Tangent. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^EmptyBlock)(void);
@protocol DeferredQueueProtocol
- (void)invoke:(nonnull EmptyBlock)block;
@end

// 主线程队列
@interface MainQueue : NSObject<DeferredQueueProtocol>
+ (nonnull instancetype)shared;
@end

// 同步队列
@interface SyncQueue : NSObject<DeferredQueueProtocol>
+ (nonnull instancetype)shared;
@end

// 异步线程队列
@interface AsyncQueue : NSObject<DeferredQueueProtocol>
+ (nonnull instancetype)shared;
@end

// 自定义队列
@interface CustomQueue : NSObject<DeferredQueueProtocol>
- (nonnull instancetype)initWithGCDQueue:(nonnull dispatch_queue_t)queue;
@end
