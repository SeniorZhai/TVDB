//
//  ForumCell.h
//  STDG
//
//  Created by 翟涛 on 14-4-1.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForumCell : UITableViewCell

@property (nonatomic,strong) UILabel* message;
@property (nonatomic,strong) UILabel* author;
@property (nonatomic,strong) UILabel* time;

@end
