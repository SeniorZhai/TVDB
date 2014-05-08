//
//  STForum.h
//  STDG
//
//  Created by 翟涛 on 14-3-13.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import <Mantle.h>

@interface STGategory : MTLModel <MTLJSONSerializing>

@property (nonatomic,strong) NSNumber *id;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSArray *catname;

@end

