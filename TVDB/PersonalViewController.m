//
//  PersonalViewController.m
//  AKTabBar
//
//  Created by 翟涛 on 14-3-12.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "PersonalViewController.h"
#import "STClient.h"
#import "AppInfoCell.h"
#import "OrderInfoViewController.h"
@interface PersonalViewController ()
@end

@implementation PersonalViewController
@synthesize uesrInfo;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"个人";
    }
    return self;
}

#pragma mark setTabBar image and title
- (NSString *)tabImageName
{
	return @"tabbar_userinfo_normal";
}

- (NSString *)tabTitle
{
    return self.title;
}

- (void)viewDidLoad
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [[NSBundle mainBundle] loadNibNamed:@"PersonalViewController~iPad" owner:self options:nil];
        [super viewDidLoad];
        UIColor *bgcolor = [UIColor colorWithRed:0x0e*1.0/0xff green:0x7c*1.0/0xff blue:0xd3*1.0/0xff alpha:1.0f];
        self.navigationController.navigationBar.barTintColor = bgcolor;
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        [[RACObserve([STClient sharedClient],appInfos)
          deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(NSArray *newForecast){
            [self.tableView reloadData];
        }];

    }
    else
    {
        [[NSBundle mainBundle] loadNibNamed:@"PersonalViewController~iPhone" owner:self options:nil];
        [super viewDidLoad];
        UIColor *bgcolor = [UIColor colorWithRed:0x0e*1.0/0xff green:0x7c*1.0/0xff blue:0xd3*1.0/0xff alpha:1.0f];
        self.navigationController.navigationBar.barTintColor = bgcolor;
        self.tableView1.dataSource = self;
        self.tableView1.delegate = self;
        [[RACObserve([STClient sharedClient],appInfos)
          deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(NSArray *newForecast){
            [self.tableView1 reloadData];
        }];

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [STClient sharedClient].appInfos.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderInfoViewController *orderInfoViewController = [[OrderInfoViewController alloc] init];
    [self.navigationController pushViewController:orderInfoViewController animated:YES];
}
// 返回单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([STClient sharedClient].appInfos) {
        static NSString *CellIdentifier = @"AppInfo";
        AppInfoCell *cell           = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (! cell) {
            cell = [[AppInfoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.layer.masksToBounds  = YES;
        NSString *name            = [[[STClient sharedClient].appInfos objectAtIndex:indexPath.row] objectForKey:@"name"];
        cell.nameLabel.text       = name;
        id price                  = [[[STClient sharedClient].appInfos objectAtIndex:indexPath.row] objectForKey:@"price"];
        
        cell.price.text = [NSString stringWithFormat:@"售价：%@",price];
        id version                  = [[[STClient sharedClient].appInfos objectAtIndex:indexPath.row] objectForKey:@"version"];
        cell.version.text = [NSString stringWithFormat:@"版本：%@",version];
        cell.layer.cornerRadius   = 12;
        cell.layer.masksToBounds  = YES;
        return cell;
    }
    return nil;
}

- (IBAction)onClick1:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登入" message:@"请输入用户名和密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [alert textFieldAtIndex:0].text = [userDefaults objectForKey:@"username"];
    [alert textFieldAtIndex:1].text = [userDefaults objectForKey:@"password"];
    [userDefaults setBool:NO forKey:@"isLogin"];
    [alert show];
}

- (IBAction)onClick:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登入" message:@"请输入用户名和密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [alert textFieldAtIndex:0].text = [userDefaults objectForKey:@"username"];
    [alert textFieldAtIndex:1].text = [userDefaults objectForKey:@"password"];
    [userDefaults setBool:NO forKey:@"isLogin"];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if (buttonIndex == 1) {
            UITextField* nameField = [alertView textFieldAtIndex:0];
            UITextField* passwordField = [alertView textFieldAtIndex:1];
        
            uesrInfo = [[STClient sharedClient] login:nameField.text withPassword:passwordField.text];
            int flag = [[uesrInfo objectForKey:@"code"] intValue];
            if (flag == 3) {
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:nameField.text forKey:@"username"];
                [userDefaults setObject:passwordField.text forKey:@"password"];
                [userDefaults setInteger:[[uesrInfo objectForKey:@"uid"]integerValue] forKey:@"uid"];
                [userDefaults setBool:YES forKey:@"isLogin"];
                self.credit_icon.hidden = NO;
                self.email_icon.hidden = NO;
                self.user_icon.hidden = NO;
                self.credit_label.hidden = NO;
                self.user_label.hidden = NO;
                self.email_label.hidden = NO;
                if ([[uesrInfo objectForKey:@"state"] intValue] == -1) {
                    self.credit_label.text = @"未申请";
                }else if ([[uesrInfo objectForKey:@"state"] intValue] == 0){
                    self.credit_label.text = @"未审核";
                }else{
                    self.credit_label.text = @"已认证";
                }
                self.user_label.text = nameField.text;
                self.email_label.text = [uesrInfo objectForKey:@"email"];
                self.button.hidden = YES;
                [[STClient sharedClient]appInfos:[[uesrInfo objectForKey:@"uid"] intValue]];
                [self.tableView reloadData];
            }else if(flag == 2){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                alert.alertViewStyle = UIAlertViewStyleDefault;
                [alert show];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户不存在" delegate:self    cancelButtonTitle:@"确定" otherButtonTitles:nil];
                alert.alertViewStyle = UIAlertViewStyleDefault;
                [alert show];
            }
        }
    }else{
        if (buttonIndex == 1) {
            UITextField* nameField = [alertView textFieldAtIndex:0];
            UITextField* passwordField = [alertView textFieldAtIndex:1];
            
            uesrInfo = [[STClient sharedClient] login:nameField.text withPassword:passwordField.text];
            int flag = [[uesrInfo objectForKey:@"code"] intValue];
            if (flag == 3) {
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:nameField.text forKey:@"username"];
                [userDefaults setObject:passwordField.text forKey:@"password"];
                [userDefaults setInteger:[[uesrInfo objectForKey:@"uid"]integerValue] forKey:@"uid"];
                [userDefaults setBool:YES forKey:@"isLogin"];
                self.credit_icon1.hidden = NO;
                self.email_icon1.hidden = NO;
                self.user_icon1.hidden = NO;
                self.credit_label1.hidden = NO;
                self.user_label1.hidden = NO;
                self.email_label1.hidden = NO;
                if ([[uesrInfo objectForKey:@"state"] intValue] == -1) {
                    self.credit_label1.text = @"未申请";
                }else if ([[uesrInfo objectForKey:@"state"] intValue] == 0){
                    self.credit_label1.text = @"未审核";
                }else{
                    self.credit_label1.text = @"已认证";
                }
                self.user_label1.text = nameField.text;
                self.email_label1.text = [uesrInfo objectForKey:@"email"];
                self.button1.hidden = YES;
                [[STClient sharedClient]appInfos:[[uesrInfo objectForKey:@"uid"] intValue]];
                [self.tableView1 reloadData];
            }else if(flag == 2){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                alert.alertViewStyle = UIAlertViewStyleDefault;
                [alert show];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户不存在" delegate:self    cancelButtonTitle:@"确定" otherButtonTitles:nil];
                alert.alertViewStyle = UIAlertViewStyleDefault;
                [alert show];
            }
        }
    }
}
@end
