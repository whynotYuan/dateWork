//
//  YZWeatherCityArray.h
//  dateWork
//
//  Created by 黄桂源 on 14-2-10.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZWeatherCityArray : NSObject
@property NSMutableArray* cityArray;
+(YZWeatherCityArray*) shareWeatherCityArray;
@end
