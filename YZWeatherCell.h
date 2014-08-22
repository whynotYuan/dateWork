//
//  YZWeatherCell.h
//  dateWork
//
//  Created by 黄桂源 on 14-1-18.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZWeatherModel.h"
@interface YZWeatherCell : UITableViewCell
-(void)refreshDate:(YZWeatherModel*)myModel andDay:(int)day;
@end
