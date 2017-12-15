//
//  UIControl+Deferred.h
//  Deferred
//
//  Created by Tan on 14/12/2017.
//  Copyright © 2017 Tangent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "UIControlTarget.h"
#import "Deferred.h"

@interface UIControl (Deferred)
- (void)listen:(UIControlEvents)events action:(ActionBlock)action;
@end

@implementation UIControl (Deferred)
- (void)listen:(UIControlEvents)events action:(ActionBlock)action {
    NSMutableDictionary *store = objc_getAssociatedObject(self, @selector(action:));
    if (!store) {
        store = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, @selector(action:),
                                 store, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    UIControlTarget *target = [[UIControlTarget alloc]initWithActionBlock:action];
    [self addTarget:target action:@selector(action:) forControlEvents:events];
    store[@(events)] = target;
}

- (Deferred *)deferredWithEvents:(UIControlEvents)events {
    Deferred *deferred = [Deferred deferred];
    [self listen:events action:^(UIControl *control) {
        [deferred fill:nil];
    }];
    return deferred;
}
@end
