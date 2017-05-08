//
//  searchResultsModel.h
//  lection14
//
//  Created by iOS-School-1 on 04.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkManager.h"
#import "Item.h"

@interface SearchResultsModel : NSObject

@property (copy,nonatomic) NSArray *items;
@property (strong,nonatomic) NSMutableArray *activeDownloads;
@property (strong,nonatomic,readonly) NetworkManager *networkManager;

- (void)getItemsForRequest:(NSString *)request withCompletionHandler: (void (^)(void))completionHandler;
- (void)downloadThumbnailForItem:(NSIndexPath *)itemIndexPath withCompletionHandler:(void (^)(NSIndexPath *indexpath))completionHandler;

@end
