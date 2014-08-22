//
//  YZDateWorkDatabase.h
//  dateWork
//
//  Created by 黄桂源 on 14-1-18.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface YZDateWorkDatabase : NSObject
+(YZDateWorkDatabase*) shareDatabase;
- (BOOL)insertIntoTableCityCodeWithCityName:(NSString *)cityName andCityCode:(NSString *)cityCodej;
- (NSMutableArray *)selectFromCityCodeWithSeachText:(NSString *)seachText;
- (NSString *)selectFromCityCodeWithCityName:(NSString *)cityName;
@end
