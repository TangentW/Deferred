//
//  AppDelegate.m
//  Deferred
//
//  Created by Tan on 14/12/2017.
//  Copyright © 2017 Tangent. All rights reserved.
//

#import "AppDelegate.h"
#import "DemoView.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    window.rootViewController = [[DemoView alloc]init];
    self.window = window;
    [window makeKeyAndVisible];
    return YES;
}

@end
