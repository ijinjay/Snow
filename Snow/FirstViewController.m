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
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSArray *labels;
@property (nonatomic, weak) IBOutlet GKBarGraph *graphView;
@property IBOutlet UILabel *t1;
@property IBOutlet UILabel *t2;
@property IBOutlet UILabel *t3;
@property IBOutlet UILabel *t4;
@property IBOutlet UILabel *t5;
@property IBOutlet UILabel *t6;
@end

@implementation FirstViewController
@synthesize todayInfo, city, temperature, weather;


// 单例模式
static FirstViewController *instance = nil;
+ (id)getInstance{
    if (instance == nil) {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        instance = (FirstViewController *)[storyboard instantiateViewControllerWithIdentifier:@"FirstViewController"];
    }
    return instance;
}

// 显示获得的信息
- (void)showInformation{
    [self.city setText:[self.wM cityName]];
    [CityTableViewController setCurrentCity:[self.wM cityName]];
    NSLog(@"%@", [self.wM cityName]);
    [self.temperature setText:[self.wM temp1]];
    [self.todayInfo setText: [NSString stringWithFormat:@"今日指数：%@", [self.wM cityInfo]]];
    UIImage *oneImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [self.wM img1]]];
    [self.weather setImage:oneImage];
    if ([self.wM weather1] != NULL) {
        [self drawBar];
    }
}
// 更新按钮
- (IBAction)updateDate:(id)sender{
//    self.hud = [[FirstViewController getInstance] showHud:self title:@"正在更新数据" selector:@selector() arg:nil targetView:appDelegate.window];
    NSString *currentCity = [CityTableViewController getCurrentCity];
    if (currentCity == NULL) {
        if (self.locateCity != NULL) {
            currentCity = [self.wM cityName];
            [self.message setText:@" "];
        }
        else {
            currentCity = @"北京";
            [self.message setText:@"警告：未选择城市！"];
        }
    }
    else {
        [self.message setText:@" "];
    }
    [self.wM startWithNum:[self.wM getCityNum:currentCity]];
    
}
// 控制器实现的协议方法，视图加载后运行的初始化方法
- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //通过ip定位当前城市 获取城市天气代码
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.hud hide:YES];
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
                    }
                }
            }
        }
        self.wM = [WeatherModel getInstance];
        [self.wM startWithNum:intString];
        [self.message setText:@"定位成功！"];
        
        // 设置cityTableViewController 的城市名为当前城市
        
    }
    else {
        self.wM = [[WeatherModel alloc] init];
        NSLog(@"Cannot locate");
        [self.message setText:@"不能定位到当前所在城市"];
        if (![self.wM sqliteCheck]) {
            [self.message setText:@"不能获取数据！"];
        }
    }
}

// 解析天气数据，供drawBar调用
- (NSString *)parseData:(NSString *)str{
    NSCharacterSet *characterSet1 = [NSCharacterSet characterSetWithCharactersInString:@"℃"];
    NSArray *array1 = [str componentsSeparatedByCharactersInSet:characterSet1];
    NSString *s1 = [array1 objectAtIndex:0];
    NSString *s2 = [[array1 objectAtIndex:1] substringFromIndex:1];
    NSString * returnStr = [NSString stringWithFormat:@"%d", ([s1 intValue] + [s2 intValue]) / 2 + 50];
    return returnStr;
}

// 绘制条形图
- (void)drawBar{
    // 温度平均值处理
    NSString *t1 = [self parseData:[self.wM temp1]];
    NSString *t2 = [self parseData:[self.wM temp2]];
    NSString *t3 = [self parseData:[self.wM temp3]];
    NSString *t4 = [self parseData:[self.wM temp4]];
    NSString *t5 = [self parseData:[self.wM temp5]];
    NSString *t6 = [self parseData:[self.wM temp6]];
    // 设置温度值
    [self.t1 setText: [NSString stringWithFormat:@"%d", [t1 intValue] - 50]];
    [self.t2 setText: [NSString stringWithFormat:@"%d", [t2 intValue] - 50]];
    [self.t3 setText: [NSString stringWithFormat:@"%d", [t3 intValue] - 50]];
    [self.t4 setText: [NSString stringWithFormat:@"%d", [t4 intValue] - 50]];
    [self.t5 setText: [NSString stringWithFormat:@"%d", [t5 intValue] - 50]];
    [self.t6 setText: [NSString stringWithFormat:@"%d", [t6 intValue] - 50]];
    
    self.data =@[t1,t2,t3,t4,t5,t6];
    // 设置温度条标签
    self.labels = @[[self.wM weather1], [self.wM weather2], [self.wM weather3], [self.wM weather4], [self.wM weather5], [self.wM weather6]];
    self.graphView.dataSource = self;
    [self.graphView draw];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 限制自动旋转
- (BOOL)shouldAutorotate{
    return NO;
}
// 视图在此进入时，如果不是与当前选择的城市相同就自动刷新天气
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSString *oldCity = self.city.text;
    NSLog(@"--->%@\t%@<---",oldCity,[CityTableViewController getCurrentCity]);
    if (![oldCity isEqualToString:[CityTableViewController getCurrentCity]]) {
        [self updateButton];
        NSLog(@"自动更新成功");
    }
}

// barGraph 要求实现的协议方法
#pragma mark - GKBarGraphDataSource
// barGraph中条形图的条数
- (NSInteger)numberOfBars {
    return [self.data count];
}
// 每一个条形的值
- (NSNumber *)valueForBarAtIndex:(NSInteger)index {
    return [self.data objectAtIndex:index];
}
// 每一个条形的颜色
- (UIColor *)colorForBarAtIndex:(NSInteger)index {
    id colors = @[[UIColor gk_turquoiseColor],
                  [UIColor gk_peterRiverColor],
                  [UIColor gk_alizarinColor],
                  [UIColor gk_amethystColor],
                  [UIColor gk_emerlandColor],
                  [UIColor gk_sunflowerColor]
                  ];
    return [colors objectAtIndex:index];
}
// 动画
- (CFTimeInterval)animationDurationForBarAtIndex:(NSInteger)index {
    CGFloat percentage = [[self valueForBarAtIndex:index] doubleValue];
    percentage = (percentage / 100);
    return (self.graphView.animationDuration * percentage);
}
// 标题
- (NSString *)titleForBarAtIndex:(NSInteger)index {
    return [self.labels objectAtIndex:index];
}
// reload
@end
