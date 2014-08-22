//
//  YZDateWorkDatabase.m
//  dateWork
//
//  Created by 黄桂源 on 14-1-18.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "YZDateWorkDatabase.h"

@implementation YZDateWorkDatabase{
    FMDatabase* newDB;
}
+(YZDateWorkDatabase *)shareDatabase{
    static YZDateWorkDatabase *myDatabase;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (myDatabase ==nil) {
            myDatabase = [[YZDateWorkDatabase alloc] init];
        }
    });
    return myDatabase;
}

//初始化数据库
- (id)init{
    self = [super init];
    if (self) {
        //创建数据库
        newDB = [[FMDatabase alloc] initWithPath:[self getFilePath:@"cityCode.db"]];
        if ([newDB open]) {
            NSLog(@"数据库打开");
            //创建表
            [self createTable];
        }
    }
    return self;
}

#pragma 数据库操作
- (void) createTable{
    //城市代码表
    NSString *createTableCityCodeSql = @"create table if not exists CityCode(id integer primary key autoincrement , CityName,CityCode);";
    if ([newDB executeUpdate:createTableCityCodeSql]) {
        NSLog(@"创建城市代码表");
    }
    else{
        NSLog(@"城市代码表 Error= %@", [newDB lastError]);
    }
    
}

#pragma 数据库 表格 插入表
- (BOOL)insertIntoTableCityCodeWithCityName:(NSString *)cityName andCityCode:(NSString *)cityCode{
    
    NSString * insertIntoTableCityCodeSql = [NSString stringWithFormat:@"replace into CityCode(CityName,CityCode) values('%@','%@')", cityName, cityCode];
    if ([newDB executeUpdate:insertIntoTableCityCodeSql]) {
        NSLog(@"城市编码插入成功");
    }
    else{
        NSLog(@"城市编码插入失败");
        return NO;
    }
    return YES;
    
}

#pragma 数据表查询
- (NSMutableArray *)selectFromCityCodeWithSeachText:(NSString *)seachText{
    if ([seachText isEqualToString:@""]) {
        return nil;
    }
    NSMutableArray *cityNameArray = [NSMutableArray array];
    NSString *selectFromTableCityCodeSql = [NSString stringWithFormat:@"select * from CityCode where CityName like '%%%@%%'", seachText];
    NSLog(@"++++++=%@", selectFromTableCityCodeSql);
    FMResultSet *queryResult = [newDB executeQuery:selectFromTableCityCodeSql];
    while ([queryResult next]) {
        NSString *seach = [queryResult stringForColumn:@"CityName"];
        [cityNameArray addObject:seach];
    }
    return cityNameArray;
}

- (NSString *)selectFromCityCodeWithCityName:(NSString *)cityName{
    if ([cityName isEqualToString:@""]) {
        return nil;
    }
    //NSMutableArray *cityNameArray = [NSMutableArray array];
    NSString *selectFromTableCityCodeSql = [NSString stringWithFormat:@"select * from CityCode where CityName like '%%%@%%'", cityName];
    NSLog(@"利用城市名称搜索code=%@", selectFromTableCityCodeSql);
    FMResultSet *queryResult = [newDB executeQuery:selectFromTableCityCodeSql];
    //    while ([queryResult next]) {
    [queryResult next];
    NSString *cityCode= [queryResult stringForColumn:@"CityCode"];
    //        [cityNameArray addObject:seach];
    //    }
    NSLog(@"网址%@",cityCode);
    return cityCode;
}


//获取文件路径
- (NSString *)getFilePath:(NSString *)fileName{
    //沙盒路径NSHomeDirectory(),是一个字符串。
    //寻找沙盒路径下的Document文件夹路径
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    ////产生Document下的指定文件名的路径，并返回
    return [documentPath stringByAppendingPathComponent:fileName];
}

@end
