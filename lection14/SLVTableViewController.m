//
//  TableViewController.m
//  lection14
//
//  Created by iOS-School-1 on 04.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "SLVTableViewController.h"
#import "SLVSearchResultsModel.h"
#import "SLVItem.h"
#import "SLVTableViewController.h"
#import "SLVTableViewCell.h"

@interface SLVTableViewController () <UISearchBarDelegate>

@property (strong, nonatomic) SLVSearchResultsModel *model;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (copy, nonatomic) NSString *searchRequest;

@end

@implementation SLVTableViewController

static NSString * const reuseID = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchBar = [UISearchBar new];
    self.searchBar.placeholder = @"Введите название песни";
    self.tableView.tableHeaderView = self.searchBar;
    self.searchBar.delegate = self;
    [self.searchBar becomeFirstResponder];
    [self.tableView setContentInset:UIEdgeInsetsMake(20, 0, 0, 0)];
    [self.searchBar sizeToFit];
    
    [self.tableView registerClass:[SLVTableViewCell class] forCellReuseIdentifier:reuseID];
    self.tableView.rowHeight = 56;
}

#pragma mark - Search Bar Delegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    self.searchRequest = searchBar.text;
    [searchBar endEditing:YES];
    if (self.searchRequest) {
        self.model=nil;
        self.model = [SLVSearchResultsModel new];
        __weak typeof(self) weakself = self;
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
    SLVTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: reuseID forIndexPath:indexPath];
    SLVItem *currentItem = self.model.items[indexPath.row];
    cell.trackName.text = currentItem.trackName;
    if (currentItem.albumName) {
        cell.artistName.text = [NSString stringWithFormat:@"%@ [%@]",currentItem.artistName, currentItem.albumName];
    } else {
        cell.artistName.text = currentItem.artistName;
    }
    
    if ([currentItem.price isEqualToString:@"-1"] || [currentItem.price isEqualToString:@"0"]){
        cell.price.text = @"free";
    } else {
        cell.price.text = currentItem.price;
    }
    cell.price.adjustsFontSizeToFitWidth = YES;
    
    if(!currentItem.thumbnail) {
        cell.thumbnail.image = [UIImage imageNamed:@"music"];
        __weak typeof(self) weakself = self;
        [self.model downloadThumbnailForItem:indexPath withCompletionHandler:^(NSIndexPath *indexpath) {
            dispatch_async(dispatch_get_main_queue(), ^{
                SLVTableViewCell * cell = [weakself.tableView cellForRowAtIndexPath:indexpath];
                cell.thumbnail.image = (weakself.model.items[indexPath.row]).thumbnail;
            });
        }];
    } else {
        cell.thumbnail.image = currentItem.thumbnail;
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self.model.networkManager.lowPriorityTasks removeAllObjects];
    for (SLVItem *item in self.model.items) {
        item.thumbnail = nil;
    }
}



@end
