//
//  FirstViewController.m
//  Snow
//
//  Created by 靳杰 on 14-4-25.
//  Copyright (c) 2014年 JinJay. All rights reserved.
//

#import "FirstViewController.h"
#import "CityTableViewController.h"
#import "CoreLocation/CoreLocation.h"
#import "WeatherModel.h"

@interface FirstViewController ()
@property IBOutlet UITextView *todayInfo;
@property IBOutlet UILabel *city;
@property IBOutlet UILabel *temperature;
@property IBOutlet UIImageView *weather;
@property IBOutlet UILabel *message;
@property WeatherModel *wM;
@property NSString *locateCity;
@end

@implementation FirstViewController
@synthesize todayInfo, city, temperature, weather;


- (IBAction)updateDate:(id)sender{
    NSString *currentCity = [CityTableViewController getCurrentCity];
    if (currentCity == NULL) {
        if (self.locateCity != NULL) {
            currentCity = [self.wM cityName];
            [self.message setText:@""];
        }
        else {
            currentCity = @"北京";
            [self.message setText:@"警告：未选择城市！"];
        }
    }
    else {
        [self.message setText:@""];
    }
    [self.wM startWithNum:[self.wM getCityNum:currentCity]];
    [self.city setText:[self.wM cityName]];
    [self.temperature setText:[self.wM temp1]];
    [self.todayInfo setText: [NSString stringWithFormat:@"今日指数：%@", [self.wM cityInfo]]];
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    [self updateButton];
    NSLog(@"进入FirstView");
}
- (void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray *)viewControllers{
    NSLog(@"will beginCUstom");
}
- (void)tabBarController:(UITabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed{
    NSLog(@"endCustom");
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //通过ip定位当前城市 获取城市天气代码
    
    UITabBarController *tabBarController = (UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController ;
    
    [tabBarController setDelegate:self];
    
    NSURL *url = [NSURL URLWithString:@"http://61.4.185.48:81/g/"];
    
    //    定义一个NSError对象，用于捕获错误信息
    NSError *error;
    NSString *jsonString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
//    NSLog(@"------------%@",jsonString);
    if (jsonString != NULL) {
        NSString *intString;
        NSString *Str;
        for (int i = 0; i<=[jsonString length]; i++) {
            for (int j = i+1; j <=[jsonString length]; j++) {
                Str = [jsonString substringWithRange:NSMakeRange(i, j-i)];
                if ([Str isEqualToString:@"id"]) {
                    if (![[jsonString substringWithRange:NSMakeRange(i+3, 1)] isEqualToString:@"c"]) {
                        intString = [jsonString substringWithRange:NSMakeRange(i+3, 9)];
//                        NSLog(@"***%@***", intString);
                    }
                }
            }
        }
        if (intString != NULL) {
            self.wM = [[WeatherModel alloc] init];
            [self.wM startWithNum:intString];
            [self.message setText:@"定位成功"];
//            [self.wM sqliteCheck:intString];
            
            [self.city setText:[self.wM cityName]];
            self.locateCity = intString;
//            NSLog(@"Locate City:%@\n",self.locateCity);
            [self.temperature setText:[self.wM temp1]];
            [self.todayInfo setText: [NSString stringWithFormat:@"今日指数：%@", [self.wM cityInfo]]];
        }
        else {
            NSLog(@"Cannot locate");
            [self.message setText:@"不能定位到当前所在城市"];
        }
    }
    else {
        self.wM = [[WeatherModel alloc] init];
        if (![self.wM sqliteCheck]) {
            [self.message setText:@"不能获取数据！"];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
