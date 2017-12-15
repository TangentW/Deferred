//
//  UILabel+Deferred.h
//  Deferred
//
//  Created by Tan on 15/12/2017.
//  Copyright © 2017 Tangent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deferred.h"

@interface UILabel (Deferred)
- (void)displayBy:(Deferred *)deferred;
@end

@implementation UILabel (Deferred)
- (void)displayBy:(Deferred *)deferred {
    __weak typeof(self) weakSelf = self;
    [deferred subscribe:^(id  _Nullable value) {
        weakSelf.text = value;
    }];
}
@end

