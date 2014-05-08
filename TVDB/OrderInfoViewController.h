//
//  OrderInfoViewController.h
//  STDG
//
//  Created by 翟涛 on 14-3-27.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderInfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *appName;
@property (weak, nonatomic) IBOutlet UILabel *pirceLabe;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UITableView *dataView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePickerInput;
- (IBAction)bn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *left;
@property (weak, nonatomic) IBOutlet UITextField *right;
- (IBAction)dateChanged:(id)sender;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePickerInput2;
- (IBAction)dateChanged2:(id)sender;

- (id)initWithId:(int)aid;

@end
