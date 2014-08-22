//
//  YZEveryPageTurningDelegate.h
//  dateWork
//
//  Created by 黄桂源 on 14-1-10.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YZEveryPageTurningDelegate <NSObject>
-(void)everyPageTurningByDate:(YZDate)myDate andPage:(int)page andFirstWeekDay:(int)firstWeekDay;
@end
