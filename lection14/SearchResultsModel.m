//
//  searchResultsModel.m
//  lection14
//
//  Created by iOS-School-1 on 04.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "SearchResultsModel.h"
#import "NetworkManager.h"
#import "Item.h"

@implementation SearchResultsModel

-(void)getItemsForRequest: (NSString*) request withCompletionHandler: (void (^)(void))completionHandler{
    NSString *normalizedRequest=[request stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString *urls =[NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@",normalizedRequest];
    NSURL *url =[NSURL URLWithString:urls];
    [NetworkManager getModelFromURL:url withCompletionHandler:^(NSData *data) {
        self.items=[self parseData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler();
        });
    }];
}

-(NSArray*)parseData:(NSData *)data{
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

@end
