//
//  NetworkManager.m
//  lection14
//
//  Created by iOS-School-1 on 04.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "NetworkManager.h"

@interface NetworkManager()

@end

@implementation NetworkManager

+ (void)getModelFromURL: (NSURL *) url withCompletionHandler: (void (^)(NSData * data))completionHandler{
    NSURLSession * session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask * task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        completionHandler(data);
        if(error){
            NSLog(@"error while downloading data %@",error.userInfo);
        }
    }];
    [task resume];
}

@end
