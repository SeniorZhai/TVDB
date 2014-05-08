//
//  AppDelegate.m
//  TVDB
//
//  Created by 翟涛 on 14-4-28.
//  Copyright (c) 2014年 翟涛. All rights reserved.
//

#import "AppDelegate.h"
#import "NewsViewController.h"
#import "ForumViewController.h"
#import "PersonalViewController.h"
#import "SettingViewController.h"
#import "STClient.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:NO forKey:@"isLogin"];
    [[STClient sharedClient] fetchWebCategory];
    [[STClient sharedClient] fetchWebForum];
    [[STClient sharedClient] fetchWebNews:1];
    
    _tabBarController = [[AKTabBarController alloc]initWithTabBarHeight:(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)?70:50];
    
    NewsViewController * newsViewController = [[NewsViewController alloc]init];
    
    UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:newsViewController];
    navigationController1.navigationBar.tintColor = [UIColor darkGrayColor];
    
    ForumViewController *forumViewController      = [[ForumViewController alloc]init];
    UINavigationController *navigationController2 = [[UINavigationController alloc] initWithRootViewController:forumViewController];
    navigationController2.navigationBar.tintColor = [UIColor darkGrayColor];
    
    PersonalViewController *personalViewController = [[PersonalViewController alloc]init];
    UINavigationController *navigationController3  = [[UINavigationController alloc] initWithRootViewController:personalViewController];
    navigationController3.navigationBar.tintColor  = [UIColor darkGrayColor];
    
    SettingViewController *settingViewController  = [[SettingViewController alloc]init];
    UINavigationController *navigationController4 = [[UINavigationController alloc] initWithRootViewController:settingViewController];
    navigationController4.navigationBar.tintColor = [UIColor darkGrayColor];
    [_tabBarController setViewControllers:[NSMutableArray arrayWithObjects:
                                           navigationController1,
                                           navigationController2,
                                           navigationController3,
                                           navigationController4,nil]];
    [_window setRootViewController:_tabBarController];
    _window.backgroundColor                       = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    return YES;

}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}
@end
