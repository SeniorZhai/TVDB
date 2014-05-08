//
//  SettingViewController.m
//  AKTabBar
//
//  Created by 翟涛 on 14-3-12.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"设置";
    }
    return self;
}

#pragma mark setTabBar image and title
- (NSString *)tabImageName
{
	return @"tabbar_configure_normal";
}

- (NSString *)tabTitle
{
    return self.title;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIColor *bgcolor = [UIColor colorWithRed:0x0e*1.0/0xff green:0x7c*1.0/0xff blue:0xd3*1.0/0xff alpha:1.0f];
    self.navigationController.navigationBar.barTintColor = bgcolor;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [[NSBundle mainBundle] loadNibNamed:@"SettingViewController~iPad" owner:self options:nil];
    }else{
        [[NSBundle mainBundle] loadNibNamed:@"SettingViewController~iPhone" owner:self options:nil];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
