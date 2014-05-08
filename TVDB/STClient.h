//
//  STClient.h
//  STDG
//
//  Created by 翟涛 on 14-3-10.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa/ReactiveCocoa.h>
#import "STGategory.h"

@interface STClient : NSObject

@property (nonatomic,strong,readonly) NSArray *forumArray;
@property (nonatomic,strong,readonly) NSArray *category;
@property (nonatomic,strong,readonly) NSArray *postTitles;
@property (nonatomic,strong,readonly) NSArray *news;
@property (nonatomic,strong,readonly) NSArray *appInfos;
@property (nonatomic,strong,readonly) NSArray *fourum;

@property (nonatomic,strong) NSString *newcontent;
@property (nonatomic) NSInteger index;

+(instancetype) sharedClient;

- (void)fetchWebForum;
- (void)fetchWebCategory;
- (void)fetchWebForumPosts:(int)fid;
- (void)fetchWebNews:(int)fid;
- (void)fetchWebNewContent:(int)aid;
- (void)appInfos:(int)did;
- (NSDictionary*)login:(NSString*)username withPassword:(NSString*)password;
- (void)fourumPosts:(int)tid withPage:(int)count;
@end
