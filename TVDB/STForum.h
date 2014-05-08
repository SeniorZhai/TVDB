//
//  STForum.h
//  STDG
//
//  Created by 翟涛 on 14-3-18.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import <Mantle.h>

@interface STForum : MTLModel <MTLJSONSerializing>

@property (nonatomic,strong) NSString *aid;
@property (nonatomic,strong) NSString *subForums;

@end
