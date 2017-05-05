//
//  NetworkManager.h
//  lection14
//
//  Created by iOS-School-1 on 04.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject
+ (void)getModelFromURL: (NSURL *) url withCompletionHandler: (void (^)(NSData * data))completionHandler;
@end
