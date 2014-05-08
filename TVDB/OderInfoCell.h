//
//  OderInfoCell.h
//  STDG
//
//  Created by 翟涛 on 14-4-4.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OderInfoCell : UITableViewCell

@property (nonatomic,strong) UILabel* name;
@property (nonatomic,strong) UILabel* version;
@property (nonatomic,strong) UILabel* order_status;
@property (nonatomic,strong) UILabel* created;
@property (nonatomic,strong) UILabel* price;
@property (nonatomic,strong) UILabel* discount_fee;

@property (nonatomic,strong) UIFont* bigfont;
@property (nonatomic,strong) UIFont* font;

@end
