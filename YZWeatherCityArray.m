//
//  YZWeatherCityArray.m
//  dateWork
//
//  Created by 黄桂源 on 14-2-10.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "YZWeatherCityArray.h"

@implementation YZWeatherCityArray
+(YZWeatherCityArray *)shareWeatherCityArray{
    static YZWeatherCityArray*  myWeatherCityArray;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (myWeatherCityArray ==nil) {
            myWeatherCityArray= [[YZWeatherCityArray  alloc] init];
            myWeatherCityArray.cityArray=[NSMutableArray array];
        }
    });
    return myWeatherCityArray;
}
@end
