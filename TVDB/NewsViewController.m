//
//  NewsViewController.m
//  AKTabBar
//
//  Created by 翟涛 on 14-3-12.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "NewsViewController.h"
#import "PostViewController.h"
#import "STClient.h"
#import "STGategory.h"
#import <ReactiveCocoa/ReactiveCocoa/ReactiveCocoa.h>

@interface NewsViewController ()

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation NewsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"资讯";
    }
    return self;
}

#pragma mark setTabBar image and title
- (NSString *)tabImageName
{
	return @"tabbar_article_normal";
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
    
    CGSize size                    = [UIScreen mainScreen].bounds.size;

    self.tableView                 = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)?[[UITableView alloc] initWithFrame:CGRectMake(0, 60, size.width, size.height - 130)]:[[UITableView alloc] initWithFrame:CGRectMake(0, 55, size.width, size.height - 120)];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate        = self;
    self.tableView.dataSource      = self;

    self.tableView.pagingEnabled   = YES;
    [self.view addSubview:self.tableView];
    
    self.segmentedBgView = [[UIView alloc] init];
    self.segmentedBgView.backgroundColor = [UIColor whiteColor];
    self.segmentedBgView.frame = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)?CGRectMake(0, 44 + 20, size.width, 55.0):CGRectMake(0, 44 + 20, size.width, 45.0);
    [self.view addSubview:self.segmentedBgView];

    
    [[RACObserve([STClient sharedClient],news)
      deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(NSArray *newForecast){
        [self.tableView reloadData];
    }];


    [[RACObserve([STClient sharedClient], category)
        deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(NSArray *newarray){
        NSMutableArray * array = [[NSMutableArray alloc]init];
        for (int i = 0; i < newarray.count; i++) {
            STGategory * gategory = [newarray objectAtIndex:i];
            [array addObject:gategory.catname];
        }
        _segmentedControl       = [[UISegmentedControl alloc] initWithItems:array];
        _segmentedControl.frame = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)?CGRectMake(100, 44 + 25, size.width - 200, 50.0):CGRectMake(25, 44 + 25, size.width - 50, 40.0);
        _segmentedControl.selectedSegmentIndex = 0;//设置默认选择项索引
        [_segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:(UIControlEventValueChanged)];
        [self.view addSubview:_segmentedControl];
    }];
}

-(void)segmentAction:(UISegmentedControl *)Seg
{
    NSInteger index = Seg.selectedSegmentIndex;
 
    switch (index) {
        case 0:
            [[STClient sharedClient] fetchWebNews:1];
            break;
        case 1:
            [[STClient sharedClient] fetchWebNews:2];
            break;
        case 2:
            [[STClient sharedClient] fetchWebNews:3];
            break;
        case 3:
            [[STClient sharedClient] fetchWebNews:4];
            break;
    }

}
#pragma mark DataSource
#pragma mark DataSource

// 返回单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"News";
    UITableViewCell *cell           = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.layer.masksToBounds  = YES;
    NSString *title           = [[[STClient sharedClient].news objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.textLabel.text       = title;
    NSString *summary         = [[[STClient sharedClient].news objectAtIndex:indexPath.row] objectForKey:@"summary"];
    cell.detailTextLabel.text = summary;
    cell.layer.cornerRadius   = 12;
    cell.layer.masksToBounds  = YES;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [STClient sharedClient].news.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int aid = [[[[STClient sharedClient].news objectAtIndex:indexPath.row] objectForKey:@"aid"] intValue];
    [[STClient sharedClient] fetchWebNewContent:(aid)];
    [STClient sharedClient].index = indexPath.row;
    PostViewController *postViewController = [[PostViewController alloc] init];
    [self.navigationController pushViewController:postViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
