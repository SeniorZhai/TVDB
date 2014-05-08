//
//  ForumCell.m
//  STDG
//
//  Created by 翟涛 on 14-4-1.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "ForumCell.h"

@implementation ForumCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _message = [[UILabel alloc] init];
        _author = [[UILabel alloc] init];
        _time = [[UILabel alloc] init];
        
        [self.contentView addSubview:_message];
        [self.contentView addSubview:_author];
        [self.contentView addSubview:_time];
    }
    return self;
}


@end
