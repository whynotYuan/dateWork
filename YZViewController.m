//
//  YZViewController.m
//  dateWork
//
//  Created by mac on 13-12-24.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "YZViewController.h"
#import "YZupView.h"
#import "YZDairyViewController.h"
#import "YZMenuViewController.h"
#import "YZChangeModeViewController.h"
#import "YZSafePeriodViewController.h"
#import "YZWeatherViewController.h"

@interface YZViewController ()

@end

@implementation YZViewController{
    UIScrollView* myScrollView;
    UIView* myDateView;
    UIDatePicker* myDatePicker;
    UIView* shareView;
    YZdownView* downView[8];
    YZupView* upView[8];
    UINavigationController* navMenu;
    YZMenuViewController* myMenuView;
    YZChangeModeViewController* myChangeView;
    YZSafePeriodViewController* mySafePeriodView;
    YZWeatherViewController* myWeatherView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addScrollView];
    [self adddownView1];
    [self addupView];
    [self addDatePicker];
    [self addShareView];
    myMenuView=[[YZMenuViewController alloc]init];
    myMenuView.myDelegate=self;
    myChangeView=[[YZChangeModeViewController alloc]init];
    myChangeView.myDelegate=self;
    myChangeView.myScrollToPresentViewDelegate=self;
    mySafePeriodView=[[YZSafePeriodViewController alloc]init];
    mySafePeriodView.myDelegate=self;
    mySafePeriodView.myCalculateSafePerioDelegate=self;
    myWeatherView=[[YZWeatherViewController alloc]init];
    myWeatherView.myDelegate=self;
}

//添加ScrollView
-(void)addScrollView{
    myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    for (int i=0; i<9; ++i) {
        UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(320*i, 0, 320, 480)];
        imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%03d.jpg",i]];
        [myScrollView addSubview:imageView];
    }
    UIImageView* twoimageView=[[UIImageView alloc]initWithFrame:CGRectMake(320*2, 0, 320, 480)];
    twoimageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"002.png"]];
    [myScrollView addSubview:twoimageView];
    
    [myScrollView setContentOffset:CGPointMake(320, 0)];
    myScrollView.contentSize=CGSizeMake(320*9, 480);
    myScrollView.showsHorizontalScrollIndicator=NO;
    myScrollView.pagingEnabled=YES;
    myScrollView.bounces=NO;
    [self.view addSubview:myScrollView];

}

-(void)addupView{
    for (int i=0; i<8; ++i) {
        upView[i]=[[YZupView alloc]initWithData:i+1];
        [myScrollView addSubview:upView[i]];
        upView[i].myMenuDelegate=self;
        upView[i].myChangeModeDelegate=self;
    }
    upView[0].myWeatherViewDelegate=self;
}

-(void)adddownView1{

    for (int i=0; i<8; ++i) {
        downView[i]=[[YZdownView alloc]initWithData:i+1];
        [myScrollView addSubview:downView[i]];
        downView[i].myDatePickDelegate=self;
        downView[i].myDairyDelegate=self;
        downView[i].myShareDelegate=self;
        downView[i].myEveryPageTurningDelegate=self;
    }
    downView[0].myPushWeatherTableDelegate=self;
    downView[0].myHideWeatherDelegate=self;
    downView[3].myPushSafePeriodTableViewDelegate=self;
    downView[3].mySafePeriodDelegate=self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addDatePicker{
    myDateView=[[UIView alloc]initWithFrame:CGRectMake(0, 0 , 320, 480)];
    UIView* dateBackgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    UILabel* dateLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 120, 100, 30)];
    dateLabel.text=@"请选择日期:";
    dateLabel.textColor=[UIColor whiteColor];
    dateLabel.backgroundColor=[UIColor clearColor];
    UIButton* cancelButton=[UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame=CGRectMake(205, 120, 30, 30);
    [cancelButton setImage:[UIImage imageNamed:@"picker_negative"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(onCancel) forControlEvents:UIControlEventTouchUpInside];
    UIButton* clickButton=[UIButton buttonWithType:UIButtonTypeCustom];
    clickButton.frame=CGRectMake(255, 120, 30, 30);
    [clickButton setImage:[UIImage imageNamed:@"picker_positive"] forState:UIControlStateNormal];
    [clickButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    
    dateBackgroundView.backgroundColor=[UIColor grayColor];
    dateBackgroundView.alpha=0.5;
    myDatePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 150, 320, 160)];
    myDatePicker.datePickerMode=UIDatePickerModeDate;
    [myDateView addSubview:dateBackgroundView];
    [myDateView addSubview:dateLabel];
    [myDateView addSubview:cancelButton];
    [myDateView addSubview:clickButton];
    [myDateView addSubview:myDatePicker];
    [self.view addSubview:myDateView];
    myDateView.hidden=YES;
}

- (void)addShareView{
    shareView=[[UIView alloc]initWithFrame:CGRectMake(0, 185, 320, 480)];
    UIView* gestureView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 295)];
    UITapGestureRecognizer* hideShareGR=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideShareView)];
    [gestureView addGestureRecognizer:hideShareGR];
    
    UIView* shareViewSonView=[[UIView alloc]initWithFrame:CGRectMake(0, 295, 320, 185)];
    UIImageView* backgroundImageView=[[UIImageView alloc]initWithFrame:CGRectMake(-1, 0, 321, 227)];
    backgroundImageView.image=[UIImage imageNamed:@"share_bg"];
    
    UILabel* myTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, 320, 40)];
    myTitleLabel.text=@"分享这个日历到";
    myTitleLabel.textColor=[UIColor whiteColor];
    myTitleLabel.font=[UIFont systemFontOfSize:18];
    myTitleLabel.textAlignment=NSTextAlignmentCenter;
    
    UIView* buttonView=[[UIView alloc]initWithFrame:CGRectMake(0, 50, 320, 80)];
    UIButton* sinaButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [sinaButton setImage:[UIImage imageNamed:@"share_sina"] forState:UIControlStateNormal];
    sinaButton.frame=CGRectMake(39, 0, 54, 54);
    UILabel* sinaLabel=[[UILabel alloc]initWithFrame:CGRectMake(39, 59, 54, 13)];
    sinaLabel.textColor=[UIColor whiteColor];
    sinaLabel.font=[UIFont systemFontOfSize:13];
    sinaLabel.text=@"新浪微博";
    sinaLabel.textAlignment=NSTextAlignmentCenter;
    
    UIButton* weixinButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [weixinButton setImage:[UIImage imageNamed:@"share_wx"] forState:UIControlStateNormal];
    weixinButton.frame=CGRectMake(133, 0, 54, 54);
    UILabel* weixinLabel=[[UILabel alloc]initWithFrame:CGRectMake(133, 59, 54, 13)];
    weixinLabel.textColor=[UIColor whiteColor];
    weixinLabel.font=[UIFont systemFontOfSize:13];
    weixinLabel.text=@"微信";
    weixinLabel.textAlignment=NSTextAlignmentCenter;
    
    UIButton* qqButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [qqButton setImage:[UIImage imageNamed:@"share_qq"] forState:UIControlStateNormal];
    qqButton.frame=CGRectMake(227, 0, 54, 54);
    UILabel* qqLabel=[[UILabel alloc]initWithFrame:CGRectMake(227, 59, 54, 13)];
    qqLabel.textColor=[UIColor whiteColor];
    qqLabel.font=[UIFont systemFontOfSize:13];
    qqLabel.text=@"QQ";
    qqLabel.textAlignment=NSTextAlignmentCenter;
    [qqButton addTarget:self action:@selector(lala) forControlEvents:UIControlEventTouchUpInside];
    
    [buttonView addSubview:sinaButton];
    [buttonView addSubview:sinaLabel];
    [buttonView addSubview:weixinButton];
    [buttonView addSubview:weixinLabel];
    [buttonView addSubview:qqButton];
    [buttonView addSubview:qqLabel];
    
    UIButton* cancelButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setImage:[UIImage imageNamed:@"share_cancel"] forState:UIControlStateNormal];
    [cancelButton setImage:[UIImage imageNamed:@"share_cancel_click"] forState:UIControlStateHighlighted];
    [cancelButton addTarget:self action:@selector(hideShareView) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.frame=CGRectMake(38, 135, 244, 40);
    UILabel* cancelLabel=[[UILabel alloc]initWithFrame:CGRectMake(102, 10, 40, 20)];
    cancelLabel.text=@"取消";
    cancelLabel.font=[UIFont systemFontOfSize:15];
    cancelLabel.textAlignment=NSTextAlignmentCenter;
    [cancelButton addSubview:cancelLabel];
    
    [shareViewSonView addSubview:backgroundImageView];
    [shareViewSonView addSubview:myTitleLabel];
    [shareViewSonView addSubview:buttonView];
    [shareViewSonView addSubview:cancelButton];
    [shareView addSubview:gestureView];
    [shareView addSubview:shareViewSonView];
    [self.view addSubview:shareView];
    shareView.hidden=YES;
}



//实现推出共享页面的协议
-(void)showShareView{
    shareView.hidden=NO;
    [UIView animateWithDuration:0.3 animations:^{
        shareView.frame=CGRectMake(0, 0, 320, 480);
    }];
}

-(void)hideShareView{
    shareView.hidden=YES;
    shareView.frame=CGRectMake(0, 185, 320, 480);
}

-(void)onCancel{
    myDateView.hidden=YES;
}

//实现弹出DatePicker协议
-(void)showDatePicker{
    myDateView.hidden=NO;
}

//对日历返回翻到pickView选择的页面
-(void)onClick:(id)sender{
    [upView[0] hideWeatherTable];
    myDateView.hidden=YES;
    YZDate myDate;
    NSDateFormatter* dateFormatter=[[NSDateFormatter alloc]init];
    dateFormatter.dateFormat=@"yyyy";
    myDate.year=[[dateFormatter stringFromDate:myDatePicker.date] intValue];
    dateFormatter.dateFormat=@"MM";
    myDate.month=[[dateFormatter stringFromDate:myDatePicker.date] intValue];
    dateFormatter.dateFormat=@"dd";
    myDate.day=[[dateFormatter stringFromDate:myDatePicker.date] intValue];
    dateFormatter.dateFormat=@"e";
    myDate.week=[[dateFormatter stringFromDate:myDatePicker.date] intValue]-1;
    if (myDate.week==0) {
        myDate.week=7;
    }

    for (int i=0; i<8; ++i) {
        downView[i].isRightNow=YES;
        [downView[i] changePageByPicker:myDate];
    }
}

//实现弹出选中日子日志
-(void)presentDairyView:(YZDate)myDate{
    YZDairyViewController* myDairyView=[[YZDairyViewController alloc]initWithDate:myDate];
    myDairyView.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    myDairyView.mydelegate=self;
    [self presentViewController:myDairyView animated:YES completion:nil];
}

//实现日志页面对日历画面返回选择那天的协议
-(void)toPresentView{
    for (int i=0; i<8; ++i) {
        downView[i].isAnimate=NO;
        [downView[i] toPresentPage];
    }
}


//实现推出菜单页面协议
-(void)presentMenuView{
    myMenuView.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:myMenuView animated:YES completion:nil];
}

//实现推出主页面转换协议
-(void)presentChangeModeView{
    myChangeView.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    [self presentViewController:myChangeView animated:NO completion:nil];
}

//实现推出安全期计算协议
-(void)presentSafePeriod{
    [self presentViewController:mySafePeriodView animated:YES completion:nil];
}

//实现推出安全期TableView协议
-(void)pushSafePeriodTableViewByModel:(YZSafePeriodModel2 *)myModel{
    [upView[3] clickSafePeriodByModel:myModel];
}

//实现推出天气TableView协议
-(void)pushWeatherTableByDay:(int)day{
    [upView[0] clickWeatherByDay:day];
}

//实现隐藏天气TableView协议
-(void)hideWeatherTable{
    [upView[0] hideWeatherTable];
}

//实现推出天气页面协议
-(void)presentWeatherViewByPage:(int)page{
    [self presentViewController:myWeatherView animated:YES completion:nil];
    [myWeatherView creatWeatherScrollScrollToPage:page];
}

//实现通过安全期计算页面返回的数据，从新布局日历的协议
-(void)calculateSafePerioByPeriodDateModel:(YZSafePeriodModel *)myPeriodDateModel{
    [downView[3] setSafePeriodByPeriodModel:myPeriodDateModel];
}

//实现每一个页面的同步滚动
-(void)everyPageTurningByDate:(YZDate)myDate andPage:(int)page andFirstWeekDay:(int)firstWeekDay{
    [upView[0] hideWeatherTable];
    for (int i=0; i<8; ++i) {
        [downView[i] otherPageChangeByDate:myDate andPage:page andFirstWeekDay:firstWeekDay];
    }
}

//实现选择日历页面对主页面视图滚动的代理
-(void)scrollToPresentView:(int)mode{
    [myScrollView setContentOffset:CGPointMake(320*mode, 0)];
}


@end
