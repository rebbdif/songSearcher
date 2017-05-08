//
//  Item.h
//  lection14
//
//  Created by iOS-School-1 on 04.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@interface Item : NSObject

@property(strong,nonatomic)NSString *artistName;
@property(strong,nonatomic)NSString *albumName;
@property(strong,nonatomic)NSString *trackName;
@property(strong,nonatomic)NSString *price;
@property(strong,nonatomic)UIImage *thumbnail;
@property(strong,nonatomic)NSString *thumbnailURL;

+ (Item * )itemWithDictionary: (NSDictionary*) dict;

@end
