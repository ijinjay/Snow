//
//  FirstViewController.h
//  Snow
//
//  Created by 靳杰 on 14-4-25.
//  Copyright (c) 2014年 JinJay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphKit.h"
#import "MBProgressHUD.h"

@interface FirstViewController : UIViewController<GKBarGraphDataSource>
@property IBOutlet UIButton * updateButton;
@property (nonatomic,retain) MBProgressHUD *hud;
+ (id)getInstance;
- (void)showInformation;
- (IBAction)updateDate:(id)sender;
- (void)showWarring;
@end
