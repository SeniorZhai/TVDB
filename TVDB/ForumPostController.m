//
//  ForumPostController.m
//  STDG
//
//  Created by 翟涛 on 14-4-1.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "ForumPostController.h"
#import "ForumCell.h"
#import "InputBar.h"
#import "AppMacro.h"
#import "STClient.h"
@interface ForumPostController ()<InputBarDelegate>

@property (nonatomic,strong) NSURL* url;
@property (nonatomic,strong) NSURLConnection* connection;
@property (nonatomic,strong) NSMutableData* data;
@property (nonatomic,strong) NSMutableArray* posts;
@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,strong) UIActivityIndicatorView* activityIndicatorView;

@end

@implementation ForumPostController

- (id)initWithURL:(NSURL *)url
{
    self = [super init];
    if (self) {
        _data = [[NSMutableData alloc] initWithCapacity:5];
        _posts = [[NSMutableArray alloc] initWithCapacity:5];
        self.url = url;
    }
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight-70)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicatorView.frame = CGRectMake(kDeviceWidth/2 - CGRectGetWidth(_activityIndicatorView.frame)/2, KDeviceHeight/2 - CGRectGetHeight(_activityIndicatorView.frame)/2, CGRectGetWidth(_activityIndicatorView.frame), CGRectGetHeight(_activityIndicatorView.frame));
    [self.view addSubview:_activityIndicatorView];
    
    InputBar *inputBar = [[InputBar alloc]initWithFrame:CGRectMake(0, KDeviceHeight - 70, kDeviceWidth, 70)];
    
    inputBar.backgroundColor = [UIColor colorWithRed:0x0e*1.0/0xff green:0x7c*1.0/0xff blue:0xd3*1.0/0xff alpha:1.0f];
    
    inputBar.delegate = self;
    inputBar.clearInputWhenSend = YES;
    inputBar.resignFirstResponderWhenSend = YES;
    
    [self.view addSubview:inputBar];
    
    NSURLRequest *requrst = [NSURLRequest requestWithURL:self.url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    //step 3：创建链接
    _connection = [[NSURLConnection alloc] initWithRequest:requrst delegate:self];
    if (_connection) {
        // NSLog(@"链接成功");
    }else {
        // NSLog(@"链接失败");
    }
}
-(void)inputBar:(InputBar *)inputBar sendBtnPress:(UIButton *)sendBtn withInputString:(NSString *)str
{
    NSDictionary* login;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    bool isLogin = [userDefaults boolForKey:@"isLogin"];
    if (!isLogin)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请登入" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alert.alertViewStyle = UIAlertViewStyleDefault;
        [alert show];
        return;
    }
    if ([str length]!= 0) {
        [self.view addSubview:_activityIndicatorView];
        [_activityIndicatorView startAnimating];
        NSURL *url = [NSURL URLWithString:STCLIENT_FORUM_REPLY];
        NSInteger fid = [userDefaults integerForKey:@"fid"];
        NSInteger tid = [userDefaults integerForKey:@"tid"];
        NSString* author = [userDefaults objectForKey:@"username"];
        NSInteger uid = [userDefaults integerForKey:@"uid"];
        NSString* message = str;
        //第二步，创建请求
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];

        [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
        
        NSString *string = [NSString stringWithFormat:@"fid=%ld&tid=%ld&author=%@&message=%@&authorid=%ld",fid,tid,author,message,uid];//设置参数

        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        
        NSData *data = [string dataUsingEncoding:enc];
        
        [request setHTTPBody:data];
        NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        NSError *jsonError = nil;
        login  = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableLeaves error:&jsonError];
        NSLog(@"%@",login);
        
        NSURLRequest *requrst = [NSURLRequest requestWithURL:self.url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
        _connection = [[NSURLConnection alloc] initWithRequest:requrst delegate:self];
        if (_connection) {
            // NSLog(@"链接成功");
        }else {
            // NSLog(@"链接失败");
        }
        
        [_activityIndicatorView stopAnimating];
        
    }
  }

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [((UIView*)obj) resignFirstResponder];
    }];
}

#pragma mark NSUrlConnectionDelegate methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //接受一个服务端回话，再次一般初始化接受数据的对象
    [_data resetBytesInRange:NSMakeRange(0, [_data length])];
    [_data setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    _posts =[NSJSONSerialization JSONObjectWithData:_data options:kNilOptions error:nil];
    NSLog(@"%@",_posts);
   [_tableView reloadData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //链接错误
}

#pragma mark UITableViewDataSource methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    double height = 20;
    static NSString *CellIdentifier = @"AppInfo";
    ForumCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (! cell) {
        cell = [[ForumCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.author.text = [[_posts objectAtIndex:indexPath.row] objectForKey:@"author"];
    cell.author.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
    [cell.author sizeToFit];
    cell.author.frame = CGRectMake(20, height, cell.author.frame.size.width, cell.author.frame.size.height);
    height += cell.author.frame.size.height +5;
    
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:[[[_posts objectAtIndex:indexPath.row] objectForKey:@"time"] doubleValue]];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterShortStyle];
    [df setTimeStyle:NSDateFormatterShortStyle];
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSString* dateStr = [df stringFromDate:date];
    cell.time.text = dateStr;
    cell.time.font = [UIFont fontWithName:@"Helvetica" size:14];
    [cell.time sizeToFit];
    cell.time.frame = CGRectMake(20, height, cell.time.frame.size.width, cell.time.frame.size.height);
    

    height += cell.time.frame.size.height + 10;
    
    
    NSString* message = [[_posts objectAtIndex:indexPath.row] objectForKey:@"message"];
    cell.message.text = message;
    cell.message.numberOfLines = 0;
    cell.message.font = [UIFont fontWithName:@"Helvetica" size:18];
    cell.message.lineBreakMode = NSLineBreakByWordWrapping;
    //设置一个行高上限
    CGSize size = CGSizeMake(kDeviceWidth-80,2000);
    //计算实际frame大小，并将label的frame变成实际大小
    [@"10" sizeWithAttributes: @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:10]}];
    CGSize labelsize = [message sizeWithFont:[UIFont fontWithName:@"Helvetica" size:18] constrainedToSize:size];
    cell.message.frame = CGRectMake(40, height, labelsize.width    , labelsize.height);
    height += cell.message.frame.size.height +20;
    
    cell.frame = CGRectMake(0, 0, kDeviceWidth, height);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _posts.count;
}
@end
