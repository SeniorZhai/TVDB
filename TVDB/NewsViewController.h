//
//  NewsViewController.h
//  AKTabBar
//
//  Created by 翟涛 on 14-3-12.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UISegmentedControl *segmentedControl;
@property (nonatomic,strong) UIView *segmentedBgView;
- (void)segmentAction:(UISegmentedControl *)Seg;

@end
