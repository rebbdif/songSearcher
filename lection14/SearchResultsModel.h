//
//  searchResultsModel.h
//  lection14
//
//  Created by iOS-School-1 on 04.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchResultsModel : NSObject
@property(copy,nonatomic) NSArray *items;
-(void)getItemsForRequest: (NSString*) request withCompletionHandler: (void (^)(void))completionHandler;
@end
