//
//  AppDelegate.m
//  lection14
//
//  Created by iOS-School-1 on 04.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "SLVAppDelegate.h"
#import "SLVTableViewController.h"

@interface SLVAppDelegate ()

@end

@implementation SLVAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    SLVTableViewController *tableViewController = [SLVTableViewController new];
    self.window.rootViewController = tableViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
