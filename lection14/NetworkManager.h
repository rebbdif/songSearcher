//
//  NetworkManager.h
//  lection14
//
//  Created by iOS-School-1 on 04.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject

@property (strong,nonatomic) NSMutableArray *highPriorityTasks;
@property (strong,nonatomic) NSMutableArray *lowPriorityTasks;

- (void)getModelFromURL: (NSURL *) url withCompletionHandler: (void (^)(NSData * data))completionHandler;
- (void)downloadImageFromURL: (NSURL *)url withCompletionHandler:(void (^)(NSData *data))completionHandler;
@end
