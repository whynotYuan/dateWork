//
//  YZWeatherModel.h
//  dateWork
//
//  Created by 黄桂源 on 14-1-16.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZWeatherModel : NSObject
@property(nonatomic,retain)NSMutableArray* tempArray;
@property(nonatomic,retain)NSMutableArray* dayTempArray;
@property(nonatomic,retain)NSMutableArray* nightTempArray;
@property(nonatomic,retain)NSMutableArray* windArray;
@property(nonatomic,retain)NSMutableArray* flArray;
@property(nonatomic,retain)NSMutableArray* weatherArray;
@property(nonatomic,retain)NSMutableArray* imgArray;
@property(nonatomic,copy)NSString* cityName;
-(void)acquairDataFromNet:(NSDictionary*)weatherDictionary;
-(id)init;
@end
