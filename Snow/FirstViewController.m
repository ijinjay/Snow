//
//  FirstViewController.m
//  Snow
//
//  Created by 靳杰 on 14-4-25.
//  Copyright (c) 2014年 JinJay. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property IBOutlet UITextView *todayInfo;
@property IBOutlet UILabel *city;
@property IBOutlet UILabel *temperature;
@property IBOutlet UIImageView *weather;
@end

@implementation FirstViewController
@synthesize todayInfo, city, temperature, weather;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [todayInfo setText:@"今日指数：\n\t紫外线强\n\t洗车指数适宜"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
