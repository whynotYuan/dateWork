//
//  YZClickToWeaherDelegate.h
//  dateWork
//
//  Created by 黄桂源 on 14-1-18.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YZClickToWeaherDelegate <NSObject>
-(void)pushWeatherTableByDay:(int)day;
@end
