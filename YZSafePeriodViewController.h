//
//  YZSafePeriodViewController.h
//  dateWork
//
//  Created by 黄桂源 on 14-1-13.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZSonViewToPresentViewDelegate.h"
#import "YZCalculateSafePerioDelegate.h"

@interface YZSafePeriodViewController : UIViewController
@property (nonatomic,weak)id<YZSonViewToPresentViewDelegate> myDelegate;
@property (nonatomic,weak)id<YZCalculateSafePerioDelegate> myCalculateSafePerioDelegate;
@end
