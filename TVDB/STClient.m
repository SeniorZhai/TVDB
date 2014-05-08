//
//  STClient.m
//  STDG
//
//  Created by 翟涛 on 14-3-10.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "STClient.h"
#import "AppMacro.h"
#import <Mantle.h>

@interface STClient()

@property (nonatomic,strong)NSURLSession *session;

@property (nonatomic, strong, readwrite) NSArray *category;
@property (nonatomic, strong, readwrite) NSArray *postTitles;
@property (nonatomic, strong, readwrite) NSArray *forumArray;
@property (nonatomic, strong, readwrite) NSArray *news;
@property (nonatomic, strong, readwrite) NSArray *appInfos;
@end

@implementation STClient

+ (instancetype)sharedClient {
    static id _sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] init];
    });
    
    return _sharedClient;
}


- (id)init{
    if (self = [super init]) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config];
    }
    return self;
}



- (void)fetchWebCategory{
    NSURL *url = [NSURL URLWithString:STCLIENT_CATEGORY];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (! error) {
     
            NSError *jsonError = nil;
            NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
            RACSequence * list = [array rac_sequence];
            self.category = [[list map:^(NSDictionary *item) {
                return [MTLJSONAdapter modelOfClass:[STGategory class] fromJSONDictionary:item error:nil];
            }] array];
            if (! jsonError) {
                
            }else{
                
            }
        }
        else{
            
        }}];
    [dataTask resume];
}


- (void)fetchWebForum{
    NSURL *url = [NSURL URLWithString:STCLIENT_FORUM];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (! error) {
            NSError *jsonError = nil;
            NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
            if (! jsonError) {
                self.forumArray = array;
            }else{
                
            }
        }
        else{
            
        }}];
    [dataTask resume];
}

- (void)fetchWebForumPosts:(int)fid{
    NSURL *url = [NSURL URLWithString:[[NSString alloc]initWithFormat:STCLIENT_FORUM_POSTS_TITLE,fid,0,5]];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (! error) {
            NSError *jsonError = nil;
            self.postTitles = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
            if (! jsonError) {
                
            }else{
                
            }
        }
        else{
            
        }}];
    [dataTask resume];
}

- (void)fetchWebNews:(int)fid{
    NSURL *url = [NSURL URLWithString:[[NSString alloc]initWithFormat:STCLIENT_CATEGORY_NEWS,fid,0,20]];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (! error) {
            NSError *jsonError = nil;
            self.news = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
            
            if (! jsonError) {
                
            }else{

            }
        }
        else{
            
        }}];
    [dataTask resume];
}

- (void)fetchWebNewContent:(int)aid{
    NSURL *url = [NSURL URLWithString:[[NSString alloc]initWithFormat:STCLIENT_CATEGOPY_NEWS_CONTENT,aid]];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (! error) {
            self.newcontent = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        }
        else{
            
        }}];
    [dataTask resume];
}

- (NSDictionary*)login:(NSString*)username withPassword:(NSString*)password{
    NSDictionary* login;
    NSURL *url = [NSURL URLWithString:STCLIENT_LOGIN];
   
    //第二步，创建请求
 
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
  
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    
    NSString *str = [NSString stringWithFormat:@"username=%@&password=%@",username,password];//设置参数
     NSLog(@"%@",str);
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
  
    [request setHTTPBody:data];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];

    NSError *jsonError = nil;
    login  = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableLeaves error:&jsonError];
    return login;
}
- (void)appInfos:(int)did
{
    NSURL *url = [NSURL URLWithString:[[NSString alloc]initWithFormat:STCLIENT_APPINFOS,did]];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (! error) {
            NSError *jsonError = nil;

            self.appInfos = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
           
        }
        else{
            
        }}];
    [dataTask resume];
}

@end
