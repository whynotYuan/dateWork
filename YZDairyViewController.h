//
//  YZDairyViewController.h
//  dateWork
//
//  Created by mac on 14-1-3.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZSonViewToPresentViewDelegate.h"
@interface YZDairyViewController : UIViewController
@property(nonatomic,weak)id<YZSonViewToPresentViewDelegate> mydelegate;
-(id)initWithDate:(YZDate)myDate;
@end
