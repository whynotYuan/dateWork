//
//  YZupView.h
//  dateWork
//
//  Created by mac on 13-12-30.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZMenuViewDelegete.h"
#import "YZChangeModeViewDelegate.h"
#import "YZWeatherViewDelegate.h"
#import "YZSafePeriodModel2.h"

@interface YZupView : UIView<NSURLConnectionDataDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak)id<YZMenuViewDelegete> myMenuDelegate;
@property(nonatomic,weak)id<YZChangeModeViewDelegate> myChangeModeDelegate;
@property(weak,nonatomic)id<YZWeatherViewDelegate> myWeatherViewDelegate;
-(id)initWithData:(int)a;
-(void)clickWeatherByDay:(int)day;
-(void)hideWeatherTable;
-(void)clickSafePeriodByModel:(YZSafePeriodModel2*)myModel;
@end
