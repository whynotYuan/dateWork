//
//  YZMenuViewController.h
//  dateWork
//
//  Created by 黄桂源 on 14-1-8.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZSonViewToPresentViewDelegate.h"
@interface YZMenuViewController : UIViewController
@property (nonatomic,weak)id<YZSonViewToPresentViewDelegate> myDelegate;
@end
