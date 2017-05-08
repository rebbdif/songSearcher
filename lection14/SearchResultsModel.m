//
//  searchResultsModel.m
//  lection14
//
//  Created by iOS-School-1 on 04.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "SearchResultsModel.h"

@implementation SearchResultsModel

- (instancetype)init{
    self=[super init];
    if(self){
        _networkManager=[NetworkManager new];
    }
    return self;
}

- (void)getItemsForRequest: (NSString*) request withCompletionHandler: (void (^)(void))completionHandler{
    NSString *normalizedRequest=[request stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString *escapedString = [normalizedRequest stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *urls =[NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@",escapedString];
    NSURL *url =[NSURL URLWithString:urls];
    [self.networkManager getModelFromURL:url withCompletionHandler:^(NSData *data) {
        self.items=[self parseData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler();
        });
    }];
}

- (NSArray *)parseData:(NSData *)data{
    if (!data){
        return nil;
    }else{
    NSError *error=nil;
    NSDictionary* json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if(error){
        NSLog(@"ERROR PARSING JSON %@",error.userInfo);
    }
    
    NSMutableArray *parsingResults =[NSMutableArray new];
    for (NSDictionary * dict in json[@"results"]) {
        [parsingResults addObject:[Item itemWithDictionary:dict]];
    }
    return [parsingResults copy];
    }
}

- (void)downloadThumbnailForItem:(NSIndexPath *)itemIndexPath withCompletionHandler:(void (^)(NSIndexPath *indexpath))completionHandler{
    Item *currentItem = self.items[itemIndexPath.row];
    if (!currentItem.thumbnail){
        [self.networkManager downloadImageFromURL:[NSURL URLWithString:currentItem.thumbnailURL] withCompletionHandler:^(NSData *data) {
            currentItem.thumbnail=[UIImage imageWithData:data];
            completionHandler(itemIndexPath);
        }];
    }
}

-(void)dealloc{
    _networkManager=nil;
}

@end
