//
//  AppDelegate.m
//  Snow
//
//  Created by 靳杰 on 14-4-25.
//  Copyright (c) 2014年 JinJay. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "CityTableViewController.h"

@implementation AppDelegate
@synthesize window = _window;
@synthesize firstViewController = _firstViewController;
@synthesize tabBarController;
@synthesize cityTableViewController = _cityTableViewController;
@synthesize dbViewController = _dbViewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // 实例化第一个视图控制器和第二个城市视图器,第三个数据库视图器
    _firstViewController = [FirstViewController getInstance];
    _cityTableViewController = [CityTableViewController getInstance];
    _dbViewController = [DBViewController getInstance];
    
    // 设置第二个城市视图控制器的导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_cityTableViewController];

    // 实例化tabBar控制器
    self.tabBarController = [[UITabBarController alloc] init];
    // 将first 和 nav 控制器加入到主控制器tabBarController
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:_firstViewController, nav,_dbViewController,nil];
    
    // 将tabBarcontroller绑定为rootViewController
    self.window.rootViewController = self.tabBarController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // 设置图标数字提示
    [UIApplication sharedApplication].applicationIconBadgeNumber = 1;
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)changeToFirst{
    [self.tabBarController setSelectedIndex:0];
}
@end
