//
//  YZViewController.h
//  dateWork
//
//  Created by mac on 13-12-24.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZDatePickerDelegate.h"
#import "YZDairyViewDelegate.h"
#import "YZSonViewToPresentViewDelegate.h"
#import "YZEveryPageTurningDelegate.h"
#import "YZShowShareView.h"
#import "YZMenuViewDelegete.h"
#import "YZdownView.h"
#import "YZChangeModeViewDelegate.h"
#import "YZScrollToPresentViewDelegate.h"
#import "YZSafePeriodDelegate.h"
#import "YZCalculateSafePerioDelegate.h"
#import "YZWeatherViewDelegate.h"
#import "YZClickToWeaherDelegate.h"
#import "YZHideWeatherTable.h"
#import "YZPushSafePeriodTableViewDelegate.h"


@interface YZViewController : UIViewController<YZDatePickerDelegate,YZDairyViewDelegate,YZShowShareView,YZEveryPageTurningDelegate,YZSonViewToPresentViewDelegate,YZMenuViewDelegete,YZChangeModeViewDelegate,YZScrollToPresentViewDelegate,YZSafePeriodDelegate,YZCalculateSafePerioDelegate,YZWeatherViewDelegate,YZClickToWeaherDelegate,YZHideWeatherTable,YZPushSafePeriodTableViewDelegate>

@end
