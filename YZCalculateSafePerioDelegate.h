//
//  YZCalculateSafePerioDelegate.h
//  dateWork
//
//  Created by 黄桂源 on 14-1-15.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YZSafePeriodModel.h"

@protocol YZCalculateSafePerioDelegate <NSObject>
-(void)calculateSafePerioByPeriodDateModel:(YZSafePeriodModel*)myPeriodDateModel;
@end
