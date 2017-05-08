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
    self.tableView.rowHeight=56;
}

#pragma mark - Search Bar Delegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    self.searchRequest= searchBar.text;
    [searchBar endEditing:YES];
    if(self.searchRequest){
        self.model=nil;
        self.model = [SearchResultsModel new];
        __weak typeof(self) weakself=self;
        [self.model getItemsForRequest:self.searchRequest withCompletionHandler:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.tableView reloadData];
            });
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
    cell.trackName.text = currentItem.trackName;
    if (currentItem.albumName){
        cell.artistName.text = [NSString stringWithFormat:@"%@ [%@]",currentItem.artistName, currentItem.albumName];
    }else{
        cell.artistName.text = currentItem.artistName;
    }
    cell.price.text = currentItem.price;
    cell.price.adjustsFontSizeToFitWidth=YES;
    
    if(!currentItem.thumbnail){
        cell.thumbnail.image = [UIImage imageNamed:@"music"];
        __weak typeof(self) weakself=self;
        [self.model downloadThumbnailForItem:indexPath withCompletionHandler:^(NSIndexPath *indexpath){
            dispatch_async(dispatch_get_main_queue(), ^{
                TableViewCell * cell=[weakself.tableView cellForRowAtIndexPath:indexpath];
                cell.thumbnail.image = ((Item *)(weakself.model.items[indexPath.row])).thumbnail;
             //   cell.thumbnail.contentMode=UIViewContentModeScaleAspectFill;
            });
        }];
    }else{
        cell.thumbnail.image = currentItem.thumbnail;
    }
    return cell;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    [self.model.networkManager.lowPriorityTasks removeAllObjects];
    for (Item *item in self.model.items){
        item.thumbnail=nil;
    }
}



@end
