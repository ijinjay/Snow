//
//  WeatherModel.m
//  Snow
//
//  Created by 靳杰 on 14-4-27.
//  Copyright (c) 2014年 JinJay. All rights reserved.
//

#import "WeatherModel.h"
#import "CityTableViewController.h"
#import "/usr/include/sqlite3.h"
#import "FirstViewController.h"

@interface WeatherModel ()
- (NSString *) dataFilePath;// 查找文件路径
- (void) sqliteOpen; // 更新数据库
- (BOOL) sqliteCheck; // 查找数据库
- (BOOL) sqliteCheck:(NSString *)theCityNum; // 通过城市编号查找数据库
@end

@implementation WeatherModel
@synthesize cityName,cityInfo,cityNum,date,week,temp1,temp2,temp3,temp4,temp5,temp6,weather1,weather6,weather5,weather4,weather2,weather3,img1,img2,img3,img4,img5,img6;
// 单例模式
static WeatherModel *instance = nil;
+ (id)getInstance{
    if (instance == nil) {
        instance = [[WeatherModel alloc] init];
    }
    return instance;
}
// 获取app内文件路径函数
-(NSString *) dataFilePath{
    NSArray *path =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *document = [path objectAtIndex:0];
    return [document stringByAppendingPathComponent:@"weather.sqlite"];
}
// 更新数据
- (void) sqliteOpen{
    sqlite3 *database;
    if (sqlite3_open([[self dataFilePath] UTF8String], &database)!=SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"open database faid!");
        NSLog(@"数据库创建失败！");
    }
    else{
        NSString *ceateSQL = @"CREATE TABLE IF NOT EXISTS weather(cityName TEXT primary key,cityNum TEXT,cityInfo TEXT, date TEXT, week TEXT, temp1 TEXT, temp2 TEXT, temp3 TEXT, temp4 TEXT, temp5 TEXT, temp6 TEXT, weather1 TEXT, weather2 TEXT, weather3 TEXT, weather4 TEXT, weather5 TEXT, weather6 TEXT, img1 TEXT, img2 TEXT, img3 TEXT, img4 TEXT, img5 TEXT, img6 TEXT)";
        
        char *ERROR;
        
        if (sqlite3_exec(database, [ceateSQL UTF8String], NULL, NULL, &ERROR)!=SQLITE_OK){
            sqlite3_close(database);
            NSAssert(0, @"ceate table faild!");
            NSLog(@"表创建失败");
        }
        else {
            char *saveSQL = "INSERT OR REPLACE INTO weather(cityName ,cityNum ,cityInfo , date , week , temp1 , temp2 , temp3 , temp4 , temp5 , temp6 , weather1 , weather2 , weather3 , weather4 , weather5 , weather6 , img1, img2, img3, img4, img5, img6)""VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);";
            
            char *errorMsg = NULL;
            sqlite3_stmt *stmt;
            
            if (sqlite3_prepare_v2(database, saveSQL, -1, &stmt, nil) == SQLITE_OK) {
                
                sqlite3_bind_text(stmt, 1, [self.cityName UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 2, [self.cityNum UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 3, [self.cityInfo UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 4, [self.date UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 5, [self.week UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 6, [self.temp1 UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 7, [self.temp2 UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 8, [self.temp3 UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 9, [self.temp4 UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 10, [self.temp5 UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 11, [self.temp6 UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 12, [self.weather1 UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 13, [self.weather2 UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 14, [self.weather3 UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 15, [self.weather4 UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 16, [self.weather5 UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 17, [self.weather6 UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 18, [self.img1 UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 19, [self.img2 UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 20, [self.img3 UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 21, [self.img4 UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 22, [self.img5 UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 23, [self.img6 UTF8String], -1, NULL);
            }
            if (sqlite3_step(stmt) != SQLITE_DONE) {
                NSLog(@"数据更新失败");
                NSAssert(0, @"error updating :%s",errorMsg);
            }
            sqlite3_finalize(stmt);
            sqlite3_close(database);
        }
    }
    
}
// 查找数据库
-(BOOL) sqliteCheck{
    sqlite3 *database;
    BOOL returnValue = YES;
    if (sqlite3_open([[self dataFilePath] UTF8String], &database)!=SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"open database failed!");
        NSLog(@"数据库查找失败！");
        return false;
    }
    else{
        NSString *query= [NSString stringWithFormat:@"select * from weather where cityName = '%@'", [CityTableViewController getCurrentCity]];
        sqlite3_stmt *stmt;
        NSLog(@"查询语句：%@\n%s", query, [query UTF8String]);
        if (sqlite3_prepare_v2(database, [query UTF8String], -1, &stmt, nil) == SQLITE_OK) {
            returnValue = false;
            while (sqlite3_step(stmt)==SQLITE_ROW) {
                self.cityName = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 1-1)];
                self.cityNum = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 2-1)];
                self.cityInfo = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 3-1)];
                self.date = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 4-1)];
                self.week = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 5-1)];
                self.temp1 = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 6-1)];
                self.temp2 = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 7-1)];
                self.temp3 = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 8-1)];
                self.temp4 = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 9-1)];
                self.temp5 = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 10-1)];
                self.temp6 = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 11-1)];
                self.weather1 = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 12-1)];
                self.weather2 = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 13-1)];
                self.weather3 = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 14-1)];
                self.weather4 = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 15-1)];
                self.weather5 = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 16-1)];
                self.weather6 = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 17-1)];
                self.img1 = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 18-1)];
                self.img2 = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 19-1)];
                self.img3 = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 20-1)];
                self.img4 = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 21-1)];
                self.img5 = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 22-1)];
                self.img6 = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 23-1)];
                returnValue = true;
            }
            NSLog(@"check success");
        }
        else{
            NSLog(@"check failed");
            NSLog(@"%s",sqlite3_errmsg(database));
            returnValue = false;
        }
        sqlite3_finalize(stmt);
    }
    //用完了一定记得关闭，释放内存
    sqlite3_close(database);
    return returnValue;
}
// 通过城市编号查找数据库
-(BOOL) sqliteCheck:(NSString *)theCityNum{
    sqlite3 *database;
    BOOL returnValue = YES;
    if (sqlite3_open([[self dataFilePath] UTF8String], &database)!=SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"open database failed!");
        NSLog(@"数据库查找失败！");
        return false;
    }
    else{
        NSString *query= [NSString stringWithFormat:@"select * from weather where cityNum = '%@'", theCityNum];
        sqlite3_stmt *stmt;
        NSLog(@"Select statement:%@",query);
        if (sqlite3_prepare_v2(database, [query UTF8String], -1, &stmt, nil) == SQLITE_OK) {
            NSLog(@"Entered the if condition");
            while (sqlite3_step(stmt)==SQLITE_ROW) {
                self.cityName = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 1-1)];
                self.cityNum = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 2-1)];
                self.cityInfo = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 3-1)];
                self.date = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 4-1)];
                self.week = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 5-1)];
                self.temp1 = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 6-1)];
                self.temp2 = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 7-1)];
                self.temp3 = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 8-1)];
                self.temp4 = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 9-1)];
                self.temp5 = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 10-1)];
                self.temp6 = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 11-1)];
                self.weather1 = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 12-1)];
                self.weather2 = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 13-1)];
                self.weather3 = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 14-1)];
                self.weather4 = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 15-1)];
                self.weather5 = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 16-1)];
                self.weather6 = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 17-1)];
                self.img1 = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 18-1)];
                self.img2 = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 19-1)];
                self.img3 = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 20-1)];
                self.img4 = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 21-1)];
                self.img5 = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 22-1)];
                self.img6 = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 23-1)];
            }
        }
        else {
            NSLog(@"Failed to load data");
            returnValue = false;
            NSLog(@"%s",sqlite3_errmsg(database));
        }
        sqlite3_finalize(stmt);
    }
    //用完了一定记得关闭，释放内存
    sqlite3_close(database);
    return returnValue;
}

#pragma mark - NSURLConnectionDataDelegate methods
// 获取数据失败后显示网络连接失败
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    UIAlertView * alertV = [[UIAlertView alloc] initWithTitle:@"网络连接失败" message:[NSString  stringWithFormat:@"%@",error] delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alertV show];
}
// 获取数据后存入数据库
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    // 网络返回的 JSON 数据 data
    NSLog(@"\n+++++++++拿到了数据\n");
    self.m_JsonData = data;
    NSError *error = nil;
    NSDictionary *dict  = [NSJSONSerialization JSONObjectWithData:self.m_JsonData options:NSJSONReadingMutableLeaves error:&error];
    id weatherInfo = [dict objectForKey:@"weatherinfo"];
    
    self.cityName = [weatherInfo objectForKey:@"city"];
    self.cityNum = [weatherInfo objectForKey:@"cityid"];
    self.cityInfo = [weatherInfo objectForKey:@"index_d"];
    self.date = [weatherInfo objectForKey:@"date_y"];
    NSLog(@"%@",self.date);
    self.week = [weatherInfo objectForKey:@"week"];
    self.temp1 = [weatherInfo objectForKey:@"temp1"];
    self.temp2 = [weatherInfo objectForKey:@"temp2"];
    self.temp3 = [weatherInfo objectForKey:@"temp3"];
    self.temp4 = [weatherInfo objectForKey:@"temp4"];
    self.temp5 = [weatherInfo objectForKey:@"temp5"];
    self.temp6 = [weatherInfo objectForKey:@"temp6"];
    self.weather1 = [weatherInfo objectForKey:@"weather1"];
    self.weather2 = [weatherInfo objectForKey:@"weather2"];
    self.weather3 = [weatherInfo objectForKey:@"weather3"];
    self.weather4 = [weatherInfo objectForKey:@"weather4"];
    self.weather5 = [weatherInfo objectForKey:@"weather5"];
    self.weather6 = [weatherInfo objectForKey:@"weather6"];
    self.img1 = [weatherInfo objectForKey:@"img1"];
    self.img2 = [weatherInfo objectForKey:@"img3"];
    self.img3 = [weatherInfo objectForKey:@"img5"];
    self.img4 = [weatherInfo objectForKey:@"img7"];
    self.img5 = [weatherInfo objectForKey:@"img9"];
    self.img6 = [weatherInfo objectForKey:@"img11"];
    
    [self sqliteOpen];
    NSLog(@"Success get %@ data",self.cityName);
    NSLog(@"weatherInfo:%@", self.cityInfo);
    [[FirstViewController getInstance] showInformation];
}
// 通过城市编号开始获取数据
- (void)startWithNum:(NSString *)thecityNum{
    //向开源的地址发送连接请求
    //这里使用的是异步的请求
    NSString *urlString = [NSString stringWithFormat:@"http://m.weather.com.cn/data/%@.html", thecityNum];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest    *urlRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30];
    NSURLConnection *urlConnection = [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    [urlConnection start];
}

// 通过城市名称获取城市编号
- (NSString *)getCityNum:(NSString *)thecityName{
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSString *plistPath;
//    文件路径
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    plistPath = [rootPath stringByAppendingPathComponent:@"City.plist"];
//    没有通过rootPath找到时使用NSBundle方法查找文件
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle mainBundle] pathForResource:@"City" ofType:@"plist"];
        NSLog(@"Here");
    }
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                          propertyListFromData:plistXML
                                          mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                          format:&format
                                          errorDescription:&errorDesc];
    if (!temp) {
        NSLog(@"Error reading plist: %@, format: %lu", errorDesc, format);
    }
    return [[temp objectForKey:@"City"] objectForKey:thecityName];
}
@end

