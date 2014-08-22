//
//  YZWeatherModel.m
//  dateWork
//
//  Created by 黄桂源 on 14-1-16.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "YZWeatherModel.h"

@implementation YZWeatherModel
-(void)acquairDataFromNet:(NSDictionary *)weatherDictionary{
    self.cityName=weatherDictionary[@"city"];
    NSString* wind1=weatherDictionary[@"wind1"];
    NSString* wind2=weatherDictionary[@"wind2"];
    NSString* wind3=weatherDictionary[@"wind3"];
    NSString* wind4=weatherDictionary[@"wind4"];
    NSString* wind5=weatherDictionary[@"wind5"];
    NSString* fl1=weatherDictionary[@"fl1"];
    NSString* fl2=weatherDictionary[@"fl2"];
    NSString* fl3=weatherDictionary[@"fl3"];
    NSString* fl4=weatherDictionary[@"fl4"];
    NSString* fl5=weatherDictionary[@"fl5"];
    wind1=[wind1 substringToIndex:2];
    wind2=[wind2 substringToIndex:2];
    wind3=[wind3 substringToIndex:2];
    wind4=[wind4 substringToIndex:2];
    wind5=[wind5 substringToIndex:2];
    fl1=[fl1 substringToIndex:3];
    fl2=[fl2 substringToIndex:3];
    fl3=[fl3 substringToIndex:3];
    fl4=[fl4 substringToIndex:3];
    fl5=[fl5 substringToIndex:3];
    self.windArray=[NSMutableArray arrayWithArray:@[wind1,wind2,wind3,wind4,wind5]];
    self.flArray=[NSMutableArray arrayWithArray:@[fl1,fl2,fl3,fl4,fl5]];
    self.weatherArray=[NSMutableArray arrayWithArray:@[weatherDictionary[@"weather1"],weatherDictionary[@"weather2"],weatherDictionary[@"weather3"],weatherDictionary[@"weather4"],weatherDictionary[@"weather5"],weatherDictionary[@"weather6"]]];
    self.imgArray=[NSMutableArray arrayWithArray:@[weatherDictionary[@"img1"],weatherDictionary[@"img3"],weatherDictionary[@"img5"],weatherDictionary[@"img7"],weatherDictionary[@"img9"],weatherDictionary[@"img11"],]];
    self.tempArray=[NSMutableArray arrayWithArray:@[weatherDictionary[@"temp1"],weatherDictionary[@"temp2"],weatherDictionary[@"temp3"],weatherDictionary[@"temp4"],weatherDictionary[@"temp5"],weatherDictionary[@"temp6"]]];

    for (int i=0; i<5; ++i) {
        NSString *temp = self.tempArray[i];
        NSRange range = [temp rangeOfString:@"℃"];
        NSString* DayTemp =[temp substringToIndex:range.location];
        range = [temp rangeOfString:@"~"];
        NSString *nightStr = [temp substringFromIndex:range.location + 1];
        range = [nightStr rangeOfString:@"℃"];
        NSString* nightTemp =[nightStr substringToIndex:range.location];
        if ([DayTemp intValue]<[nightTemp intValue]) {
            NSString* tmp=DayTemp;
            DayTemp=nightTemp;
            nightTemp=tmp;
        }
        [self.dayTempArray addObject:DayTemp];
        [self.nightTempArray addObject:nightTemp];
    }
    NSLog(@"success");

}
-(id)init{
    self=[super init];
    if (self) {
        self.tempArray=[NSMutableArray array];
        self.dayTempArray=[NSMutableArray array];
        self.nightTempArray=[NSMutableArray array];
        self.windArray=[NSMutableArray array];
        self.flArray=[NSMutableArray array];
        self.weatherArray=[NSMutableArray array];
        self.imgArray=[NSMutableArray array];
    }
    return self;
}
@end
