//
//  NetworkManager.m
//  lection14
//
//  Created by iOS-School-1 on 04.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "NetworkManager.h"

@interface NetworkManager()
@property (strong,nonatomic, readonly) NSURLSession *session;
@end

@implementation NetworkManager

-(instancetype)init{
    self=[super init];
    if(self){
        _session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        _highPriorityTasks = [NSMutableArray new];
        _lowPriorityTasks = [NSMutableArray new];
    }
    return self;
}

- (void)getModelFromURL: (NSURL *) url withCompletionHandler: (void (^)(NSData * data))completionHandler{
    NSURLSessionDataTask * task = [self.session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        completionHandler(data);
        if(error){
            NSLog(@"error while downloading data %@",error.userInfo);
        }
    }];
    task.priority=NSURLSessionTaskPriorityHigh;
    [task resume];
}

- (void)downloadImageFromURL: (NSURL *)url withCompletionHandler:(void (^)(NSData *data))completionHandler{
    NSURLSessionDataTask *task = [self.session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error){
            NSLog(@"error when loading images %@",error.userInfo);
        }
        completionHandler(data);
        [self.highPriorityTasks removeObject:task];
    }];
    task.priority=NSURLSessionTaskPriorityHigh;
    [self.highPriorityTasks addObject:task];
    [task resume];
}


@end
