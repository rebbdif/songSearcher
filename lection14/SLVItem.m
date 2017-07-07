//
//  Item.m
//  lection14
//
//  Created by iOS-School-1 on 04.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "SLVItem.h"

@implementation SLVItem

+ (instancetype)itemWithDictionary:(NSDictionary *)dict {
    SLVItem *item = [SLVItem new];
    item.artistName = dict[@"artistName"];
    item.trackName = dict[@"trackName"];
    item.albumName = dict[@"collectionName"];
    item.price = [NSString stringWithFormat:@"%@", dict[@"trackPrice"]];
    item.thumbnailURL = dict[@"artworkUrl60"];
    return item;
}

@end
