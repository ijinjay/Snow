//
//  CityTableViewController.h
//  Snow
//
//  Created by 靳杰 on 14-4-27.
//  Copyright (c) 2014年 JinJay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "CommonHelper.h"

@interface CityTableViewController : UITableViewController<UISearchDisplayDelegate,MBProgressHUDDelegate >
@property(nonatomic,retain)NSMutableArray *citylist;
@property(nonatomic,retain)NSMutableArray *savedCitylist;
@property(nonatomic,retain)NSArray *resultCitylist;
@property(nonatomic,retain)UISearchBar *searchBar;
@property(nonatomic,retain)UISearchDisplayController *searchDC;
@property(nonatomic,assign)MBProgressHUD *hud;
// 设置当前城市
+ (void)setCurrentCity:(NSString *)cityName;
// 获取当前城市
+ (NSString *)getCurrentCity;
// 单例模式
+ (id)getInstance;
@end
