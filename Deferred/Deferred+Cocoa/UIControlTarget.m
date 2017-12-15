//
//  UIControlTarget.m
//  Deferred
//
//  Created by Tan on 14/12/2017.
//  Copyright © 2017 Tangent. All rights reserved.
//

#import "UIControlTarget.h"

@interface UIControlTarget () {
    @private
    ActionBlock _action;
}

@end

@implementation UIControlTarget

- (instancetype)initWithActionBlock:(ActionBlock)action {
    if (self = [super init]) {
        _action = action;
    }
    return self;
}

- (void)action:(UIControl *)control {
    _action(control);
}

@end
