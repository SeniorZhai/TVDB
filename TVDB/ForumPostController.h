//
//  ForumPostController.h
//  STDG
//
//  Created by 翟涛 on 14-4-1.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForumPostController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDelegate>

- (id)initWithURL:(NSURL *)url;

@end
