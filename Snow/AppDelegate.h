//
//  AppDelegate.h
//  Snow
//
//  Created by 靳杰 on 14-4-25.
//  Copyright (c) 2014年 JinJay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstViewController.h"
#import "CityTableViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain) FirstViewController *firstViewController;
@property (nonatomic,retain) CityTableViewController *cityTableViewController;
@property (nonatomic,retain) UITabBarController *tabBarController;
@end
