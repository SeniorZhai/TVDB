//
//  PostViewController.m
//  STDG
//
//  Created by 翟涛 on 14-3-24.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "PostViewController.h"
#import "STClient.h"

@interface PostViewController ()

@property(nonatomic,strong)NSMutableString* str;

@end

@implementation PostViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _str = [[NSMutableString alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIColor *bgcolor = [UIColor colorWithRed:0x0e*1.0/0xff green:0x7c*1.0/0xff blue:0xd3*1.0/0xff alpha:1.0f];
    self.navigationController.navigationBar.barTintColor = bgcolor;
    CGSize size = [UIScreen mainScreen].bounds.size;

    [[RACObserve([STClient sharedClient],newcontent)
      deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(NSArray *newArray){
        if (newArray) {
            UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 70, size.width, size.height - 135)];
            NSMutableString *str = [[NSMutableString alloc]init];
            NSString* content = [STClient sharedClient].newcontent;
            [str appendString:@"<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">"];
            [str appendString:@"<html lang=\"zh-cn\"><body><div align=\"center\"><p style=\"font-size:24px\">"];
            [str appendString:[[[STClient sharedClient].news objectAtIndex:[STClient sharedClient].index] objectForKey:@"title"]];
            [str appendString:@"</p></div>"];
            [str appendString:@"<div align=\"right\">"];
            
            NSDate *date= [NSDate dateWithTimeIntervalSince1970:
                           [[[[STClient sharedClient].news objectAtIndex:[STClient sharedClient].index] objectForKey:@"time"]floatValue]];
            NSDateFormatter *df = [[NSDateFormatter alloc] init];
            [df setDateStyle:NSDateFormatterShortStyle];
            [df setTimeStyle:NSDateFormatterShortStyle];
            [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
            [str appendString:[df stringFromDate:date]];
            [str appendString:@"</div>"];
            [str appendString:@"<div align=\"right\">来源："];
            [str appendString:[[[STClient sharedClient].news objectAtIndex:[STClient sharedClient].index] objectForKey:@"from"]];
            [str appendString:@"</div><br>"];
            [str appendString:content];
            [str appendString:@"</body><ml>"];
            [webView loadHTMLString:str  baseURL:[NSURL fileURLWithPath: [[NSBundle mainBundle]  bundlePath]]];
            [self.view addSubview:webView];

        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
