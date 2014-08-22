//
//  YZLineDrawingView.h
//  dateWork
//
//  Created by 黄桂源 on 14-1-17.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZLineDrawingView : UIView
@property (nonatomic, strong) UIColor *aColor;
@property (nonatomic, strong)UIColor* linecolor;
- (void) setPointArray:(NSMutableArray *)pointArray withPointImageName:(NSString *)string withTempArray:(NSMutableArray *)array;
@end
