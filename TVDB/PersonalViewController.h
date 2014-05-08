//
//  PersonalViewController.h
//  AKTabBar
//
//  Created by 翟涛 on 14-3-12.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalViewController : UIViewController<UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroud1;
@property (weak, nonatomic) IBOutlet UIImageView *backgroud;



@property (weak, nonatomic) IBOutlet UIImageView *credit_icon;
@property (weak, nonatomic) IBOutlet UIImageView *credit_icon1;

@property (weak, nonatomic) IBOutlet UIImageView *email_icon1;
@property (weak, nonatomic) IBOutlet UIImageView *email_icon;

@property (weak, nonatomic) IBOutlet UIImageView *user_icon1;
@property (weak, nonatomic) IBOutlet UIImageView *user_icon;

@property (weak, nonatomic) IBOutlet UILabel *user_label1;
@property (weak, nonatomic) IBOutlet UILabel *user_label;

@property (weak, nonatomic) IBOutlet UILabel *email_label1;
@property (weak, nonatomic) IBOutlet UILabel *email_label;

@property (weak, nonatomic) IBOutlet UILabel *credit_label1;
@property (weak, nonatomic) IBOutlet UILabel *credit_label;

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *tableView1;

@property (nonatomic,strong) NSDictionary* uesrInfo;

- (IBAction)onClick1:(id)sender;
- (IBAction)onClick:(id)sender;

@end
