//
//  UIControlTarget.h
//  Deferred
//
//  Created by Tan on 14/12/2017.
//  Copyright © 2017 Tangent. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ActionBlock)(UIControl *control);

@interface UIControlTarget : NSObject

- (instancetype)initWithActionBlock:(ActionBlock)action;
- (void)action:(UIControl *)control;

@end
