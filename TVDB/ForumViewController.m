//
//  ForumViewController.m
//  AKTabBar
//
//  Created by 翟涛 on 14-3-12.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "ForumViewController.h"
#import "STClient.h"
#import "SubjectViewController.h"

@interface ForumViewController ()

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation ForumViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"论坛";
    }
    return self;
}

#pragma mark setTabBar image and title

- (NSString *)tabImageName
{
	return @"tabbar_forum_normal";
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
    CGSize size = [UIScreen mainScreen].bounds.size;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height - 70)];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.separatorColor = [UIColor colorWithWhite:1 alpha:0.2]; 
    self.tableView.pagingEnabled = YES;
    [self.view addSubview:self.tableView];
}
#pragma mark DataSource
// 显示多少分区
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return [STClient sharedClient].forumArray.count;
}
// 显示每个分区包含多少个元素
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = [[[STClient sharedClient].forumArray objectAtIndex:section] objectForKey:@"subForums"];
    return array.count;
}
// 返回单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.layer.masksToBounds = YES;
    NSArray *array = [[[STClient sharedClient].forumArray objectAtIndex:indexPath.section] objectForKey:@"subForums"];
    cell.textLabel.text = [[array objectAtIndex:indexPath.row]objectForKey:@"name"];
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[[STClient sharedClient].forumArray objectAtIndex:section] objectForKey:@"name"];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString * str = [[[[[STClient sharedClient].forumArray objectAtIndex:indexPath.section] objectForKey:@"subForums"] objectAtIndex:indexPath.row] objectForKey:@"id"];
    [[STClient sharedClient] fetchWebForumPosts:[str intValue]];
    SubjectViewController *subVC = [[SubjectViewController alloc] init];
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:[str integerValue] forKey:@"fid"];
    [self.navigationController pushViewController:subVC animated:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
