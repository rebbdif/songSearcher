//
//  TableViewController.m
//  lection14
//
//  Created by iOS-School-1 on 04.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "TableViewController.h"
#import "SearchResultsModel.h"
#import "Item.h"
#import "TableViewController.h"
#import "TableViewCell.h"
@interface TableViewController () <UISearchBarDelegate>
@property(strong,nonatomic) SearchResultsModel *model;
@property(strong,nonatomic) UISearchBar *searchBar;
@property(strong,nonatomic) NSString *searchRequest;
@end

@implementation TableViewController

static  NSString * reuseID =@"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchBar=[UISearchBar new];
    self.searchBar.placeholder=@"Введите название песни";
    self.tableView.tableHeaderView=self.searchBar;
    self.searchBar.delegate=self;
    [self.searchBar becomeFirstResponder];
    [self.tableView setContentInset:UIEdgeInsetsMake(20, 0, 0, 0)];
    [self.searchBar sizeToFit];
    
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:reuseID];
    
   }

# pragma mark - Search Bar Delegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    self.searchRequest= searchBar.text;
    [searchBar endEditing:YES];
    if(self.searchRequest){
        self.model=nil;
        self.model = [SearchResultsModel new];
        [self.model getItemsForRequest:self.searchRequest WithCompletionHandler:^{
            [self.tableView reloadData];
        }];

    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: reuseID forIndexPath:indexPath];
    Item *currentItem= self.model.items[indexPath.row];
    
    cell.textLabel.text=currentItem.trackName;
    cell.detailTextLabel.text=currentItem.artistName;
    
    return cell;
}

@end
