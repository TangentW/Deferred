//
//  DemoViewModel.h
//  Deferred
//
//  Created by Tan on 15/12/2017.
//  Copyright © 2017 Tangent. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Deferred;

@interface DemoViewModel : NSObject

@property(nonatomic, readonly, strong) Deferred *output;

- (instancetype)initWithActionDeferred:(Deferred *)input;

@end
