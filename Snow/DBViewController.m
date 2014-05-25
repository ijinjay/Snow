//
//  DBViewController.m
//  Snow
//
//  Created by 靳杰 on 14-5-22.
//  Copyright (c) 2014年 JinJay. All rights reserved.
//

#import "DBViewController.h"
#import "WeatherModel.h"
#import "CityTableViewController.h"

@interface DBViewController ()
@property IBOutlet UITextField* cityName;
@property IBOutlet UITextView* cityInfo;
-(IBAction)editFinished:(id)sender;
@end

@implementation DBViewController
// 单例模式
static DBViewController *instance = nil;
+ (id)getInstance{
    if (instance == nil) {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        instance = (DBViewController *)[storyboard instantiateViewControllerWithIdentifier:@"DBViewController"];
    }
    return instance;
}
// 点击键盘return消失键盘
- (IBAction)editFinished:(id)sender {
    [sender resignFirstResponder];
    [self checkDB];
}

- (void)checkDB{
    NSString *str = self.cityName.text;
    WeatherModel *w = [WeatherModel getInstance];
    NSString *originalCityName = [CityTableViewController getCurrentCity];
    [CityTableViewController setCurrentCity:str];
    NSLog(@"%@-----%@-----%@",str,originalCityName,[CityTableViewController getCurrentCity]);
    if (![w sqliteCheck]) {
        [[self cityInfo] setText:@"城市输入错误或城市数据未缓存在本地"];
    }
    else {
        [[self cityInfo] setText:[NSString stringWithFormat:@"%@\n%@", w.cityName, w.cityInfo]];
    }
    [CityTableViewController setCurrentCity:originalCityName];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
