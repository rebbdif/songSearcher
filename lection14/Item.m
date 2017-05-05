//
//  Item.m
//  lection14
//
//  Created by iOS-School-1 on 04.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "Item.h"

@implementation Item
+ (Item * )itemWithDictionary: (NSDictionary*) dict{
    Item *item=[Item new];
    item.artistName=dict[@"artistName"];
    item.trackName=dict[@"trackName"];
    
    return item;
}
@end
