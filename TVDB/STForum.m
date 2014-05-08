//
//  STForum.m
//  STDG
//
//  Created by 翟涛 on 14-3-18.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "STForum.h"

@implementation STForum
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"subForums":@"subForums",
             @"aid":@"id",
             };
}
@end
