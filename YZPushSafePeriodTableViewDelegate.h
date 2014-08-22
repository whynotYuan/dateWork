//
//  YZPushSafePeriodTableViewDelegate.h
//  dateWork
//
//  Created by 黄桂源 on 14-1-20.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YZSafePeriodModel2.h"
@protocol YZPushSafePeriodTableViewDelegate <NSObject>
-(void)pushSafePeriodTableViewByModel:(YZSafePeriodModel2*)myModel;
@end
