//
//  DeferredTests.m
//  DeferredTests
//
//  Created by Tan on 14/12/2017.
//  Copyright © 2017 Tangent. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Deferred.h"

@interface DeferredTests : XCTestCase

@end

@implementation DeferredTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Deferred Test"];
    Deferred *deferred = [Deferred deferred];
    [deferred subscribe:^(id  _Nullable value) {
        XCTAssertTrue([value isEqualToString:@"One"]);
    }];

    [[[[[deferred map:^id _Nullable(id  _Nullable value) {
        NSString *str = value;
        return [str stringByAppendingString:@" Two"];
    }] map:^id _Nullable(id  _Nullable value) {
        NSString *str = value;
        return [str stringByAppendingString:@" Three"];
    }]  mapOn:[AsyncQueue shared] with:^id _Nullable(id  _Nullable value) {
        NSString *str = value;
        return [str stringByAppendingString:@" Four"];
    }]  mapOn:[MainQueue shared] with:^id _Nullable(id  _Nullable value) {
        NSString *str = value;
        return [str stringByAppendingString:@" Five"];
    }] subscribe:^(id  _Nullable value) {
        XCTAssertTrue([value isEqualToString:@"One Two Three Four Five"]);
        XCTAssertTrue([NSThread isMainThread]);
    }];

    [[deferred flatMap:^Deferred * _Nonnull(id  _Nullable value) {
        return [Deferred just:[value stringByAppendingString:@" One"]];
    }] subscribeOn:[AsyncQueue shared] with:^(id  _Nullable value) {
        XCTAssertTrue([value isEqualToString:@"One One"]);
        XCTAssertFalse([NSThread isMainThread]);
    }];

    [deferred fill:@"One"];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [expectation fulfill];
    });
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {

    }];
}

@end
