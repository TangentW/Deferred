//
//  DemoViewModel.m
//  Deferred
//
//  Created by Tan on 15/12/2017.
//  Copyright © 2017 Tangent. All rights reserved.
//

#import "DemoViewModel.h"
#import "Deferred.h"
#import "WeaterInfo.h"

@interface DemoViewModel () {
    @private
    Deferred *_actionDeferred;
}
@property(nonatomic, strong) Deferred *output;
@end

@implementation DemoViewModel
- (Deferred *)output {
    if (!_output) {
        __weak typeof(self) weakSelf = self;
        _output = [[[_actionDeferred flatMap:^Deferred * _Nonnull(id  _Nullable value) {
            return [weakSelf _remoteDeferred];
        }] flatMap:^Deferred * _Nonnull(id  _Nullable value) {
            return [weakSelf _jsonToModel:value];
        }] mapOn:[MainQueue shared] with:^id _Nullable(id  _Nullable value) {
            // 需要在主队列中进行map操作，否则UI的相关设置则发生在非主线程
            WeaterInfo *info = value;
            return [NSString stringWithFormat:@"请求成功！城市：%@ 温度：%ld摄氏度，风向：%@", info.city, (long)info.temp, info.WD];
        }];
    }
    return _output;
}

- (instancetype)initWithActionDeferred:(Deferred *)input {
    if (self = [super init]) {
        _actionDeferred = input;
    }
    return self;
}

// 异步请求
- (Deferred *)_remoteDeferred {
    Deferred *ret = [Deferred deferred];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:@"http://www.weather.com.cn/data/sk/101010100.html"];
    NSURLSessionTask *task = [session dataTaskWithURL:url
                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                        id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                        [ret fill:json];
                                    }];
    [task resume];
    return ret;
}

// 异步数据解析
- (Deferred *)_jsonToModel:(id)json {
    Deferred *ret = [Deferred deferred];
    [AsyncQueue.shared invoke:^{
        id weatherinfo = json[@"weatherinfo"];
        WeaterInfo *info = [[WeaterInfo alloc]init];
        info.city = weatherinfo[@"city"];
        info.temp = [weatherinfo[@"temp"] integerValue];
        info.WD = weatherinfo[@"WD"];
        [ret fill:info];
    }];
    return ret;
}

@end
