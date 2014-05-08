//
//  OrderInfoViewController.m
//  STDG
//
//  Created by 翟涛 on 14-3-27.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "OrderInfoViewController.h"
#import "AppMacro.h"
#import "OderInfoCell.h"

@interface OrderInfoViewController ()
@property (nonatomic,strong) NSDateFormatter * myFormatter;
@property (nonatomic,strong) NSMutableArray* infos;
@property (nonatomic,strong) NSURLConnection* connection;

@property (nonatomic,assign) int aid;
@end

@implementation OrderInfoViewController
@synthesize myFormatter;
- (id)initWithId:(int)aid
{
    if([super init])
    {
        self.aid = aid;
        self.infos = [[NSMutableArray alloc]init];
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        myFormatter = [[NSDateFormatter alloc]init];
        myFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        [myFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    return self;
}
#pragma mark
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [((UIView*)obj) resignFirstResponder];
    }];
}

#pragma mark

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.left.inputView = self.datePickerInput;
    self.right.inputView = self.datePickerInput2;
    self.right.text = [myFormatter stringFromDate:[NSDate date]];
    self.left.text = [myFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:-3600*24*7]] ;
    self.dataView.dataSource = self;
    self.dataView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)bn:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [userDefaults stringForKey:@"username"];
    NSString *urlStr = [NSString stringWithFormat:STCLIENT_ORDERINFO,self.aid,userName,[self.right.text stringByReplacingOccurrencesOfString:@" "withString:@""],[self.left.text stringByReplacingOccurrencesOfString:@" " withString:@""],1];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
  
    // 状态请求
    NSURLResponse *response;
    
    // 链接一个请求
   
    NSData *resultData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
   
    // 返回数据转为字符串
    
//    NSString *dataString = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:resultData options:kNilOptions error:nil];
    _infos = [json objectForKey:@"orderlist"];
    NSLog(@"%@",_infos);
    [self.dataView reloadData];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AppInfo";

    OderInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (! cell) {
        cell = [[OderInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    id item = [_infos objectAtIndex:indexPath.row];
    cell.name.text = [item objectForKey:@"app_name"];
    cell.version.text = [item objectForKey:@"versioncode"];
    cell.created.text = [item objectForKey:@"created"];
    switch ([[item objectForKey:@"order_status"] intValue]) {
        case 1:
            cell.order_status.text = @"等待付款";
            break;
        case 2:
            cell.order_status.text = @"已付款";
            break;
        case 3:
            cell.order_status.text = @"下载中";
            break;
        case 4:
            cell.order_status.text = @"交易完成";
            break;
        default:
            cell.order_status.text = @"未知状态";
            break;
    }
    cell.price.text = [item objectForKey:@"price"];
    cell.discount_fee.text = [item objectForKey:@"discount_fee"];
    
    cell.frame = CGRectMake(0, 0, kDeviceWidth, 190);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _infos.count;
}


- (IBAction)dateChanged:(id)sender {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterShortStyle];
    [df setTimeStyle:NSDateFormatterShortStyle];
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    self.left.text = [myFormatter stringFromDate:self.datePickerInput.date];
}
- (IBAction)dateChanged2:(id)sender {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterShortStyle];
    [df setTimeStyle:NSDateFormatterShortStyle];
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    self.right.text = [myFormatter stringFromDate:self.datePickerInput.date];
}
@end
