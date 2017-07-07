//
//  TableViewCell.h
//  lection14
//
//  Created by iOS-School-1 on 04.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLVTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *trackName;
@property (strong, nonatomic) UILabel *artistName;
@property (strong, nonatomic) UILabel *album;
@property (strong, nonatomic) UILabel *price;
@property (strong, nonatomic) UIImageView *thumbnail;

@end
