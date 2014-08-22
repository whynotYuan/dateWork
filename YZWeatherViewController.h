//
//  YZWeatherViewController.h
//  dateWork
//
//  Created by 黄桂源 on 14-1-15.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZSonViewToPresentViewDelegate.h"
#import "YZWeatherModel.h"
@interface YZWeatherViewController : UIViewController
@property (nonatomic,weak)id<YZSonViewToPresentViewDelegate> myDelegate;
-(void)creatWeatherScrollScrollToPage:(int)page;
@end
