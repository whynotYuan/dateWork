//
//  YZChangeModeViewController.h
//  dateWork
//
//  Created by 黄桂源 on 14-1-13.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZSonViewToPresentViewDelegate.h"
#import "YZScrollToPresentViewDelegate.h"

@interface YZChangeModeViewController : UIViewController
@property (nonatomic,weak)id<YZSonViewToPresentViewDelegate> myDelegate;
@property (nonatomic,weak)id<YZScrollToPresentViewDelegate> myScrollToPresentViewDelegate;
@end
