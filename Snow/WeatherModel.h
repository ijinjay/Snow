//
//  WeatherModel.h
//  Snow
//
//  Created by 靳杰 on 14-4-27.
//  Copyright (c) 2014年 JinJay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherModel : NSObject
@property (nonatomic, retain) NSData *m_JsonData;
@property (nonatomic, retain) NSString *cityName;
@property (nonatomic, retain) NSString *cityNum;
@property (nonatomic, retain) NSString *cityInfo;
@property (nonatomic, retain) NSString *date;
@property (nonatomic, retain) NSString *week;
@property (nonatomic, retain) NSString *temp1;
@property (nonatomic, retain) NSString *temp2;
@property (nonatomic, retain) NSString *temp3;
@property (nonatomic, retain) NSString *temp4;
@property (nonatomic, retain) NSString *temp5;
@property (nonatomic, retain) NSString *temp6;
@property (nonatomic, retain) NSString *weather1;
@property (nonatomic, retain) NSString *weather2;
@property (nonatomic, retain) NSString *weather3;
@property (nonatomic, retain) NSString *weather4;
@property (nonatomic, retain) NSString *weather5;
@property (nonatomic, retain) NSString *weather6;
@property (nonatomic, retain) NSString *img1;
@property (nonatomic, retain) NSString *img2;
@property (nonatomic, retain) NSString *img3;
@property (nonatomic, retain) NSString *img4;
@property (nonatomic, retain) NSString *img5;
@property (nonatomic, retain) NSString *img6;
- (void)startWithNum:(NSString *)thecityNum;
- (NSString *)getCityNum:(NSString *)thecityName;
- (void) sqliteOpen; // 更新数据库
- (BOOL) sqliteCheck; // 查找数据库
- (BOOL) sqliteCheck:(NSString *)theCityNum; // 通过城市编号查找数据库
+ (id) getInstance; // 单例模式
@end
