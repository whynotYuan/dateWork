//
//  YZdownView.h
//  dateWork
//
//  Created by mac on 13-12-24.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZDatePickerDelegate.h"
#import "YZDairyViewDelegate.h"
#import "YZShowShareView.h"
#import "YZEveryPageTurningDelegate.h"
#import "YZSafePeriodDelegate.h"
#import "YZClickToWeaherDelegate.h"
#import "YZHideWeatherTable.h"
#import "YZSafePeriodModel.h"
#import "YZPushSafePeriodTableViewDelegate.h"

@interface YZdownView : UIView

@property(weak,nonatomic)id<YZDatePickerDelegate> myDatePickDelegate;
@property(weak,nonatomic)id<YZDairyViewDelegate> myDairyDelegate;
@property(weak,nonatomic)id<YZShowShareView> myShareDelegate;
@property(weak,nonatomic)id<YZEveryPageTurningDelegate> myEveryPageTurningDelegate;
@property(weak,nonatomic)id<YZSafePeriodDelegate> mySafePeriodDelegate;
@property(weak,nonatomic)id<YZClickToWeaherDelegate> myPushWeatherTableDelegate;
@property(weak,nonatomic)id<YZHideWeatherTable> myHideWeatherDelegate;
@property(weak,nonatomic)id<YZPushSafePeriodTableViewDelegate> myPushSafePeriodTableViewDelegate;
@property BOOL isAnimate;
@property BOOL isRightNow;
-(id)initWithData:(int)a;
-(void)toPresentPage;
-(void)changePageByPicker:(YZDate)myDate;
-(void)otherPageChangeByDate:(YZDate)mydate andPage:(int)Mypage andFirstWeekDay:(int)firstWeekDayThen;
-(void)setSafePeriodByPeriodModel:(YZSafePeriodModel*)mySafePeriod;
@end
