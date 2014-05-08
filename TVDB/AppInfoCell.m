//
//  AppInfoCell.m
//  STDG
//
//  Created by 翟涛 on 14-3-27.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "AppInfoCell.h"

@implementation AppInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 100, 50)];
        _nameLabel.font = [UIFont boldSystemFontOfSize:30];
        
        _price = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth - 80, 5, 60, 20)];
        _price.font = [UIFont boldSystemFontOfSize:12];
        
        _version = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth - 80, 30, 60, 20)];
        _version.font = [UIFont boldSystemFontOfSize:12];
       
        [self.contentView addSubview:_nameLabel];
        [self.contentView addSubview:_price];
        [self.contentView addSubview:_version];
    }
    return self;
}

@end
