//
//  CityTableViewController.h
//  Snow
//
//  Created by 靳杰 on 14-4-27.
//  Copyright (c) 2014年 JinJay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityTableViewController : UITableViewController<UITabBarControllerDelegate>
// 设置当前城市
+ (void)setCurrentCity:(NSString *)cityName;
// 获取当前城市
+ (NSString *)getCurrentCity;
// 单例模式
+ (id)getInstance;
@end
