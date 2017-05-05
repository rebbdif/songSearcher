//
//  Item.h
//  lection14
//
//  Created by iOS-School-1 on 04.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject
@property(strong,nonatomic)NSString * artistName;
@property(strong,nonatomic)NSString * trackName;
+ (Item * )itemWithDictionary: (NSDictionary*) dict;

@end
