//
//  OderInfoCell.m
//  STDG
//
//  Created by 翟涛 on 14-4-4.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "OderInfoCell.h"

@implementation OderInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _bigfont = [UIFont fontWithName:@"Helvetica-Bold" size:22];
        _font = [UIFont fontWithName:@"Helvetica" size:14];
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 80, 30)];
        name.font = _bigfont;
        _name = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame), 20, 150, 30)];
        _name.font = _bigfont;
        
        UILabel *version = [[UILabel alloc] initWithFrame:CGRectMake(30, 70, 100, 20)];
        _version = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(version.frame), 70, 100, 20)];
        
        UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(30, 90, 100, 20)];
        _price = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(price.frame), 90, 100, 20)];
        
        UILabel *discount_fee = [[UILabel alloc] initWithFrame:CGRectMake(30, 110, 100, 20)];
        _discount_fee = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(discount_fee.frame), 110, 100, 20)];
        
        UILabel *order_status = [[UILabel alloc] initWithFrame:CGRectMake(30, 130, 100, 20)];
        _order_status = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(order_status.frame), 130, 100, 20)];
       
        UILabel *created = [[UILabel alloc] initWithFrame:CGRectMake(30, 150, 100, 20)];
        _created = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(created.frame), 150, 180, 20)];
        
        

        name.text = @"名称：";
        version.text = @"版本：";
        order_status.text = @"订单状态：";
        created.text = @"创建时间：";
        price.text = @"售价：";
        discount_fee.text = @"折扣：";
        
        [self.contentView addSubview:name];
        [self.contentView addSubview:version];
        [self.contentView addSubview:order_status];
        [self.contentView addSubview:created];
        [self.contentView addSubview:price];
        [self.contentView addSubview:discount_fee];
        
        [self.contentView addSubview:_name];
        [self.contentView addSubview:_version];
        [self.contentView addSubview:_order_status];
        [self.contentView addSubview:_created];
        [self.contentView addSubview:_price];
        [self.contentView addSubview:_discount_fee];
    }
    return self;
}

@end
