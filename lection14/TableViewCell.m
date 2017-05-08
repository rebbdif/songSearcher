//
//  TableViewCell.m
//  lection14
//
//  Created by iOS-School-1 on 04.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "TableViewCell.h"
#import "Masonry/Masonry.h"

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if(self){
        _trackName=[UILabel new];
        _artistName=[UILabel new];
        _album=[UILabel new];
        _price=[UILabel new];
        _thumbnail=[UIImageView new];
        
        _thumbnail.backgroundColor=[UIColor colorWithRed:1 green:0 blue:0 alpha:0.5];
        _price.font=[UIFont systemFontOfSize:14];
        _price.layer.borderWidth=0.5;
        _price.layer.borderColor=[UIColor greenColor].CGColor;
        _price.textAlignment=NSTextAlignmentCenter;
        
        [self.contentView addSubview:_trackName];
        [self.contentView addSubview:_artistName];
        [self.contentView addSubview:_album];
        [self.contentView addSubview:_price];
        [self.contentView addSubview:_thumbnail];
    }
    return self;
}

+(BOOL)requiresConstraintBasedLayout{
    return YES;
}

-(void)updateConstraints{
    UIEdgeInsets padding =UIEdgeInsetsMake(6, 12, 6, 3);
    [_thumbnail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(8);
        make.top.equalTo(self.contentView.mas_top).with.offset(2);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-2);
        make.size.mas_equalTo(self.contentView.mas_height).sizeOffset(CGSizeMake(-4, -4));
        _thumbnail.layer.cornerRadius=self.contentView.frame.size.height/2 -2;
        _thumbnail.layer.masksToBounds = YES;
    }];
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).with.offset(-padding.right);
        make.width.equalTo(@40);
        make.height.equalTo(@18);
    }];
    [_trackName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(padding.top).priorityHigh();
        make.left.equalTo(_thumbnail.mas_right).with.offset(8);
        make.right.equalTo(_price.mas_left).with.offset(-padding.right);
        make.height.greaterThanOrEqualTo(@18).priorityMedium();
    }];
    [_artistName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(_trackName);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-padding.bottom).priorityHigh();
        make.top.mas_greaterThanOrEqualTo(_trackName.mas_bottom).with.offset(6);
        make.height.greaterThanOrEqualTo(@18).priorityLow();
    }];
    
    [super updateConstraints];
}


@end
