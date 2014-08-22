//
//  YZLunarCalendar.h
//  dateWork
//
//  Created by 黄桂源 on 14-1-6.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZLunarCalendar : NSObject
//根据阳历获得农历
-(YZDate)solar_to_lunar:(YZDate)mydate;
//得到农历月份对应字符串
- (NSString *)getMoonMonthStringWithNSInteger:(NSInteger)month;
//得到农历日期对应字符串
- (NSString *)getMoonDayStringWithNSInteger:(NSInteger)day;
//通过农历日期获得传统节日
-(NSString*)getFestivalOFLunarWithDate:(YZDate)date andwhithString:(NSString*)formalString;
//通过新历日期获得24节气
-(NSString*)getSolarTermWithDate:(YZDate)date andwihtString:(NSString*)formalString;
//通过新历日期获取节日
-(NSString*)getFestivalWithDate:(YZDate)date andWithString:(NSString*)formalString;
//计算两天间的时间差
-(int)getTwoDaysIntervalFromDay:(YZDate)fromDate toDate:(YZDate)toDate;
-(int)isHolidayOrWorkdayWithDate:(YZDate)date;
@end
