//
//  Item.h
//  lection14
//
//  Created by iOS-School-1 on 04.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@interface SLVItem : NSObject

@property (copy, nonatomic) NSString *artistName;
@property (copy, nonatomic) NSString *albumName;
@property (copy, nonatomic) NSString *trackName;
@property (copy, nonatomic) NSString *price;
@property (strong, nonatomic) UIImage *thumbnail;
@property (copy, nonatomic) NSString *thumbnailURL;

+ (instancetype)itemWithDictionary:(NSDictionary *)dict;

@end
