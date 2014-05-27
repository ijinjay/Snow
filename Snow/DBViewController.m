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
@property (nonatomic, weak) IBOutlet GKLineGraph *lineGraph;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSArray *labels;
-(IBAction)editFinished:(id)sender;
-(void)drawLine;
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
    [self drawLine];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.data = @[
                  @[@20, @40, @20, @60, @40, @140, @80],
                  @[@40, @20, @60, @100, @60, @20, @60],
                  @[@80, @60, @40, @160, @100, @40, @110]
                  ];
    
    self.labels = @[@"2001", @"2002", @"2003", @"2004", @"2005", @"2006", @"2007"];
    
    self.lineGraph.dataSource = self;
    self.lineGraph.lineWidth = 3.0;
    
    [self.lineGraph draw];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 解析天气数据，供drawLine调用
- (NSString *)parseData:(NSString *)str{
    NSCharacterSet *characterSet1 = [NSCharacterSet characterSetWithCharactersInString:@"℃"];
    NSArray *array1 = [str componentsSeparatedByCharactersInSet:characterSet1];
    NSString *s1 = [array1 objectAtIndex:0];
    NSString *s2 = [[array1 objectAtIndex:1] substringFromIndex:1];
    NSString * returnStr = [NSString stringWithFormat:@"%d", ([s1 intValue] + [s2 intValue]) / 2];
    return [NSString stringWithFormat:@"%@,%@,%@", s1, s2, returnStr];
}

- (void)drawLine{
    // 温度平均值处理
    [self.lineGraph reset];
    WeatherModel *w = [WeatherModel getInstance];
    NSString *t1 = [self parseData:[w temp1]];
    NSString *t2 = [self parseData:[w temp2]];
    NSString *t3 = [self parseData:[w temp3]];
    NSString *t4 = [self parseData:[w temp4]];
    NSString *t5 = [self parseData:[w temp5]];
    NSString *t6 = [self parseData:[w temp6]];
    NSCharacterSet *ch = [NSCharacterSet characterSetWithCharactersInString:@","];
    NSArray *array1 = [t1 componentsSeparatedByCharactersInSet:ch];
    NSArray *array2 = [t2 componentsSeparatedByCharactersInSet:ch];
    NSArray *array3 = [t3 componentsSeparatedByCharactersInSet:ch];
    NSArray *array4 = [t4 componentsSeparatedByCharactersInSet:ch];
    NSArray *array5 = [t5 componentsSeparatedByCharactersInSet:ch];
    NSArray *array6 = [t6 componentsSeparatedByCharactersInSet:ch];
//    NSLog(@"1-0:%@\n2-1:%@\n3-2:%@\n4-0:%@\n5-1:%@\n6-2:%@", [array1 objectAtIndex:0], [array2 objectAtIndex:1], [array3 objectAtIndex:2], [array4 objectAtIndex:0], [array5 objectAtIndex:1], [array6 objectAtIndex:2]);
    self.data = @[
                  @[[array1 objectAtIndex:0], [array2 objectAtIndex:0], [array3 objectAtIndex:0], [array4 objectAtIndex:0], [array5 objectAtIndex:0], [array6 objectAtIndex:0]],
                  @[[array1 objectAtIndex:2], [array2 objectAtIndex:2], [array3 objectAtIndex:2], [array4 objectAtIndex:2], [array5 objectAtIndex:2], [array6 objectAtIndex:2]],
                  @[[array1 objectAtIndex:1], [array2 objectAtIndex:1], [array3 objectAtIndex:1], [array4 objectAtIndex:1], [array5 objectAtIndex:1], [array6 objectAtIndex:1]]
                  ];
    self.labels = @[@"1",@"2",@"3",@"4",@"5",@"6"];
    self.lineGraph.dataSource = self;
    self.lineGraph.lineWidth = 3.0;
    self.lineGraph.startFromZero = false;
    self.lineGraph.valueLabelCount = 5;
    
    [self.lineGraph draw];
}

#pragma mark - GKLineGraphDataSource
- (NSInteger)numberOfLines {
    return [self.data count];
}

- (UIColor *)colorForLineAtIndex:(NSInteger)index {
    id colors = @[[UIColor gk_turquoiseColor],
                  [UIColor gk_peterRiverColor],
                  [UIColor gk_alizarinColor]
                  ];
    return [colors objectAtIndex:index];
}

- (NSArray *)valuesForLineAtIndex:(NSInteger)index {
    return [self.data objectAtIndex:index];
}

- (CFTimeInterval)animationDurationForLineAtIndex:(NSInteger)index {
    return [[@[@1, @1.6, @2.2] objectAtIndex:index] doubleValue];
}

- (NSString *)titleForLineAtIndex:(NSInteger)index {
    return [self.labels objectAtIndex:index];
}
@end
