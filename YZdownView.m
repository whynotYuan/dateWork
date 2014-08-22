//
//  YZdownView.m
//  dateWork
//
//  Created by mac on 13-12-24.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "YZdownView.h"
#import "YZLunarCalendar.h"
#import "YZSafePeriodModel2.h"

@implementation YZdownView{
    NSArray* weekArray;//星期数组
    NSArray* monthpinArray;//平年月份数组
    NSMutableArray* pageArray;//记录出现过的页数
    YZDate nowDayDate;//今天的日期数据
    YZDate oneDayDate;//选中当天的日期数据
    YZDate LunarDay;//获取当天农历信息
    int firstDayWeek;
    UIScrollView* downScrollView;
    UIButton* dateLabel;
    NSInteger page;//模拟翻页
    BOOL isCreate;
    UIButton* todayButton;//返回当前日期日历按钮
    UIButton* nowTodayButton;
    UIView* shareView;//分享页面
    __weak UIButton* LastButton;//记录之前的button
    UIButton* nowDayButton;//记录当天的button
    YZLunarCalendar* oneDayLunar;//获取oneDay农历信息
    int mode;//记录每一大页
    NSString* pageString;
    UIView* newView;//新创页面
    __weak UIView* lastView;//记录上次创立的页面
    YZSafePeriodModel* mySafePeriodModel;
//    int safePeirod;
//    int safeDuration;
    int safeFirstDayTime;
//    YZDate safeDate;//安全期反馈日期数据记录
    NSMutableArray* weatherClickDateArray;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor=[UIColor clearColor];
    if (self) {
        monthpinArray=[NSArray array];
        monthpinArray=@[@"31",@"28",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31"];
        mySafePeriodModel=[[YZSafePeriodModel alloc]init];
        //生理期初始化模拟数据
        mySafePeriodModel.lastTimeYear=2013;
        mySafePeriodModel.lastTimeMonth=12;
        mySafePeriodModel.lastTimeDay=21;
        safeFirstDayTime=11;
        mySafePeriodModel.periodDate=35;
        mySafePeriodModel.durationDate=7;
        mySafePeriodModel.SafePicNum=3;
        mySafePeriodModel.DangerousNum=2;
        mySafePeriodModel.menstruationPicNum=1;
        mySafePeriodModel.ovulationPicNum=3;
        weatherClickDateArray=[NSMutableArray array];
        [self acquairDate];
        oneDayLunar=[[YZLunarCalendar alloc]init];
        self.isAnimate=YES;
        self.isRightNow=NO;
        isCreate=YES;
        page=0;
        oneDayDate=nowDayDate;
        firstDayWeek=(7+nowDayDate.week-(nowDayDate.day-1)%7)%7;
        if (firstDayWeek==0) {
            firstDayWeek=7;
        }
        pageArray=[NSMutableArray array];
        weekArray=[NSArray array];
        weekArray=@[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];

    }
    return self;
}
//down程序入口
-(id)initWithData:(int)a{
    self=[self initWithFrame:CGRectMake(a*320, 480-227-14-30, 320, 271)];
    
    if (self) {
        mode=a;
        downScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 271)];
        downScrollView.pagingEnabled=YES;
        downScrollView.scrollEnabled=NO;
        [self addnewView];
        self.backgroundColor=[UIColor clearColor];
        [self addSubview:downScrollView];
        UISwipeGestureRecognizer* upSHR=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(onUP:)];
        upSHR.direction=UISwipeGestureRecognizerDirectionUp;
        UISwipeGestureRecognizer* downSHR=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(onDown:)];
        downSHR.direction=UISwipeGestureRecognizerDirectionDown;
        [downScrollView addGestureRecognizer:upSHR];
        [downScrollView addGestureRecognizer:downSHR];
    }
    return self;
}

//添加新页面
-(void)addnewView{
//    NSLog(@"+++mode=%d",mode);
//    pageString=[NSString stringWithFormat:@"%d",page];
//    for (NSString* onePage in pageArray) {
//        if (![pageString compare:onePage] ) {
//            isCreate=NO;
//        }
//    }
//    if (isCreate) {
        switch (mode) {
            case 1:
                [self createFirstView];
                break;
            case 2:
                [self createSecondView];
                break;
            case 3:
                [self createThirdView];
                break;
            case 4:
                [self createForthView];
                break;
            case 5:
                [self createFifthView];
                break;
            case 6:
                [self createSixthView];
                break;
            case 7:
                [self createSevenView];
                break;
            case 8:
                [self createEighthView];
                break;
            default:
                break;
        }
//    }
    
    
    
    //滚动效果管理
//    isCreate=YES;
    if (self.isAnimate) {
        if (self.isRightNow) {
            [UIView animateWithDuration:0.1 animations:^{
                [downScrollView setContentOffset:CGPointMake(0, 271*page)];
                self.isRightNow=NO;
            } completion:^(BOOL finished) {
                [lastView removeFromSuperview];
                lastView=nil;
            }];
            
//            [UIView animateWithDuration:0.1 animations:^{
//                [downScrollView setContentOffset:CGPointMake(0, 271*page)];
//                self.isRightNow=NO;
//            }];
        }else{
            [UIView animateWithDuration:0.5 animations:^{
            [downScrollView setContentOffset:CGPointMake(0, 271*page)];
            } completion:^(BOOL finished) {
                [lastView removeFromSuperview];
                lastView=nil;
            }];
//        [UIView animateWithDuration:0.5 animations:^{
//            [downScrollView setContentOffset:CGPointMake(0, 271*page)];
//        }];
        }
    }else{
        [downScrollView setContentOffset:CGPointMake(0, 271*page)];
        self.isAnimate=YES;
        [lastView removeFromSuperview];
        lastView=nil;
    }
}

-(void)createFirstView{
    int count=[monthpinArray[oneDayDate.month-1] intValue];
    if (((oneDayDate.year%4==0&&oneDayDate.year%100!=0)||(oneDayDate.year%400==0))&&(oneDayDate.month==2)) {
        count=29;
    }
    newView=[[UIView alloc]initWithFrame:CGRectMake(0,page*271, 320, 271)];
    UIView* functionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    
    //日期栏
    dateLabel=[UIButton buttonWithType:UIButtonTypeCustom];
    dateLabel.frame=CGRectMake(10, 1, 100, 28);
    [dateLabel setTitle:[NSString stringWithFormat:@"%d-%02d-%02d",oneDayDate.year,oneDayDate.month,oneDayDate.day] forState:UIControlStateNormal];
    dateLabel.titleLabel.font=[UIFont systemFontOfSize:18];
    [dateLabel setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
    [dateLabel addTarget:self action:@selector(toDatePicker:) forControlEvents:UIControlEventTouchUpInside];
    
    todayButton=[UIButton buttonWithType:UIButtonTypeCustom];
    todayButton.frame=CGRectMake(130, 1, 28, 28);
    [todayButton setImage:[UIImage imageNamed:@"sch_lst_today_hl"] forState:UIControlStateNormal];
    UIImageView* todayImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"day_list_today"]];
    todayImageView.frame=CGRectMake(0, 0, 28, 28);
    [todayButton addSubview:todayImageView];
    [todayButton addTarget:self action:@selector(backToToday:) forControlEvents:UIControlEventTouchUpInside];
    if (oneDayDate.year==nowDayDate.year&&oneDayDate.month==nowDayDate.month)
        nowTodayButton=todayButton;
    
    UIButton* shareButton=[UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame=CGRectMake(240, 1, 28, 28);
    [shareButton setImage:[UIImage imageNamed:@"share3.png"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareMyself:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* addButton=[UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame=CGRectMake(285, 1, 28, 28);
    [addButton addTarget:self action:@selector(goToDairyView:) forControlEvents:UIControlEventTouchUpInside];
    [addButton setImage:[UIImage imageNamed:@"day_list_add.png"] forState:UIControlStateNormal];
    [functionView addSubview:dateLabel];
    [functionView addSubview:addButton];
    [functionView addSubview:shareButton];
    [functionView addSubview:todayButton];
    
    //星期显示效果
    UIView* weekView=[[UIView alloc]initWithFrame:CGRectMake(0, 0+30, 320, 14)];
    UIView* weekViewBackground=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 14)];
    weekViewBackground.backgroundColor=[UIColor blackColor];
    weekViewBackground.alpha=0.5;
    [weekView addSubview:weekViewBackground];
    weekView.backgroundColor=[UIColor clearColor];
    for (int i=0; i<7; ++i) {
        UILabel* weekLabel=[[UILabel alloc]initWithFrame:CGRectMake(i==0?0:45*i+3, 0, (i==0||i==6)?47:44, 14)];
        weekLabel.text=weekArray[i];
        weekLabel.textAlignment=NSTextAlignmentCenter;
        weekLabel.textColor=[UIColor whiteColor];
        weekLabel.backgroundColor=[UIColor clearColor];
        weekLabel.font=[UIFont systemFontOfSize:12];
        [weekView addSubview:weekLabel];
    }
    
    //日历栏
    UIView* dateView=[[UIView alloc]initWithFrame:CGRectMake(0, 0+14+30, 320, 227)];
    int num=0;
    for (int i=0; i<6; ++i) {
        for (int j=0; j<7; ++j) {
            UIView* sonView=[[UIView alloc]initWithFrame:CGRectMake(j==0?0:45*j+3, 38*i, (j==0||j==6)?47:44, 37)];
            sonView.backgroundColor=[UIColor whiteColor];
            sonView.alpha=0.05;
            [dateView addSubview:sonView];
            if ((!(i==0&&j<firstDayWeek-1))&&num++<count) {
                //新历排版
                UILabel* sonupLabel=[[UILabel alloc]initWithFrame:CGRectMake(sonView.frame.origin.x, sonView.frame.origin.y, sonView.frame.size.width, sonView.frame.size.height/2)];
                sonupLabel.text=[NSString stringWithFormat:@"%d",num];
                sonupLabel.backgroundColor=[UIColor clearColor];
                sonupLabel.font=[UIFont systemFontOfSize:18];
                sonupLabel.textColor=[UIColor whiteColor];
                sonupLabel.textAlignment=NSTextAlignmentRight;
                [dateView addSubview:sonupLabel];
                

                
                //农历排版
                UILabel* sonDownLabel=[[UILabel alloc]initWithFrame:CGRectMake(sonView.frame.origin.x, sonView.frame.origin.y+sonView.frame.size.height/2, sonView.frame.size.width, sonView.frame.size.height/2)];
                oneDayDate.day=num;
                oneDayDate.week=j+1;
                LunarDay=[oneDayLunar solar_to_lunar:oneDayDate];
                if (LunarDay.day==1) {
                    sonDownLabel.text=[oneDayLunar getMoonMonthStringWithNSInteger:LunarDay.month];
                }else{
                    sonDownLabel.text=[oneDayLunar getMoonDayStringWithNSInteger:LunarDay.day];
                }
                //加入传统节日
                sonDownLabel.text=[oneDayLunar getFestivalOFLunarWithDate:LunarDay andwhithString:sonDownLabel.text];
                //加入24节气
                sonDownLabel.text=[oneDayLunar getSolarTermWithDate:oneDayDate andwihtString:sonDownLabel.text];
                //获取新历节日
                sonDownLabel.text=[oneDayLunar getFestivalWithDate:oneDayDate andWithString:sonDownLabel.text];
                sonDownLabel.backgroundColor=[UIColor clearColor];
                sonDownLabel.font=[UIFont systemFontOfSize:12];
                sonDownLabel.textColor=[UIColor whiteColor];
                sonDownLabel.textAlignment=NSTextAlignmentRight;
                [dateView addSubview:sonDownLabel];
                
                //点击按钮
                UIButton* dateButton=[UIButton buttonWithType:UIButtonTypeCustom];
                dateButton.frame=CGRectMake(sonView.frame.origin.x, sonView.frame.origin.y, sonView.frame.size.width, sonView.frame.size.height);
                [dateButton setBackgroundImage:[YZdownView createImageWithColor:[UIColor blackColor]] forState:UIControlStateSelected];
                dateButton.tag=10000*oneDayDate.year+100*oneDayDate.month+oneDayDate.day;
                dateButton.alpha=0.3;
                [dateButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
                [dateView addSubview:dateButton];
                
                //导入节假日图片
                UIImageView* myImageView=[[UIImageView alloc]initWithFrame:sonView.frame];
                switch ([oneDayLunar isHolidayOrWorkdayWithDate:oneDayDate]) {
                    case 1:
                        myImageView.image=[UIImage imageNamed:@"grid_holiday_icon.png"];
                        [dateView addSubview:myImageView];
                        break;
                        
                    case 2:
                        myImageView.image=[UIImage imageNamed:@"grid_work_icon.png"];
                        [dateView addSubview:myImageView];
                        break;
                    default:
                        break;
                }
                
                if (oneDayDate.year==nowDayDate.year&&oneDayDate.month==nowDayDate.month&&num==nowDayDate.day) {
                    sonupLabel.textColor=[UIColor yellowColor];
                    sonDownLabel.textColor=[UIColor yellowColor];
                    nowDayButton=dateButton;
                }
            }else if (i==0){
                UIGestureRecognizer* toUpGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onDown:)];
                [sonView addGestureRecognizer:toUpGesture];
            }else if (i==4||i==5){
                UIGestureRecognizer* toDownGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onUP:)];
                [sonView addGestureRecognizer:toDownGesture];
            }
        }
    }
    [newView addSubview:functionView];
    [newView addSubview:weekView];
    [newView addSubview:dateView];
    [downScrollView addSubview:newView];
//    [pageArray addObject:pageString];
}

-(void)createSecondView{
    int count=[monthpinArray[oneDayDate.month-1] intValue];
    if (((oneDayDate.year%4==0&&oneDayDate.year%100!=0)||(oneDayDate.year%400==0))&&(oneDayDate.month==2)) {
        count=29;
    }
    newView=[[UIView alloc]initWithFrame:CGRectMake(0,page*271, 320, 271)];
    UIView* functionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    
    //日期栏
    dateLabel=[UIButton buttonWithType:UIButtonTypeCustom];
    dateLabel.frame=CGRectMake(10, 1, 100, 28);
    [dateLabel setTitle:[NSString stringWithFormat:@"%d-%02d-%02d",oneDayDate.year,oneDayDate.month,oneDayDate.day] forState:UIControlStateNormal];
    dateLabel.titleLabel.font=[UIFont systemFontOfSize:18];
    [dateLabel setTitleColor:[UIColor colorWithRed:0.8 green:0 blue:0 alpha:1] forState:UIControlStateNormal];
    [dateLabel setTitleColor:[UIColor colorWithRed:0.6 green:0 blue:0 alpha:1] forState:UIControlStateHighlighted];
    [dateLabel addTarget:self action:@selector(toDatePicker:) forControlEvents:UIControlEventTouchUpInside];
    
    todayButton=[UIButton buttonWithType:UIButtonTypeCustom];
    todayButton.frame=CGRectMake(130, 1, 28, 28);
    [todayButton setImage:[UIImage imageNamed:@"sch_lst_today_hl"] forState:UIControlStateNormal];
    UIImageView* todayImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"day_list_today"]];
    todayImageView.frame=CGRectMake(0, 0, 28, 28);
    [todayButton addSubview:todayImageView];
    [todayButton addTarget:self action:@selector(backToToday:) forControlEvents:UIControlEventTouchUpInside];
    if (oneDayDate.year==nowDayDate.year&&oneDayDate.month==nowDayDate.month)
        nowTodayButton=todayButton;
    
    UIButton* shareButton=[UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame=CGRectMake(285, 1, 28, 28);
    [shareButton setImage:[UIImage imageNamed:@"share3.png"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareMyself:) forControlEvents:UIControlEventTouchUpInside];
    
    [functionView addSubview:dateLabel];
    [functionView addSubview:shareButton];
    [functionView addSubview:todayButton];
    
    //星期显示效果
    UIView* weekView=[[UIView alloc]initWithFrame:CGRectMake(0, 0+30, 320, 14)];
    UIImageView* weekViewBackground=[[UIImageView alloc]initWithFrame:CGRectMake(-30, 0, 350, 14)];
    weekViewBackground.image=[UIImage imageNamed:@"lunar_flag_bg"];
    [weekView addSubview:weekViewBackground];
    weekView.backgroundColor=[UIColor clearColor];
    for (int i=0; i<7; ++i) {
        UILabel* weekLabel=[[UILabel alloc]initWithFrame:CGRectMake(i==0?0:45*i+3, 0, (i==0||i==6)?47:44, 14)];
        weekLabel.text=weekArray[i];
        weekLabel.textAlignment=NSTextAlignmentCenter;
        weekLabel.textColor=[UIColor whiteColor];
        weekLabel.backgroundColor=[UIColor clearColor];
        weekLabel.font=[UIFont boldSystemFontOfSize:12];
        [weekView addSubview:weekLabel];
    }
    
    //日历栏
    UIView* dateView=[[UIView alloc]initWithFrame:CGRectMake(0, 0+14+30, 320, 227)];
    int num=0;
    for (int i=0; i<6; ++i) {
        for (int j=0; j<7; ++j) {
            UIView* sonView=[[UIView alloc]initWithFrame:CGRectMake(j==0?0:45*j+3, 38*i, (j==0||j==6)?47:44, 37)];
            sonView.backgroundColor=[UIColor whiteColor];
            sonView.alpha=0.05;
            [dateView addSubview:sonView];
            if ((!(i==0&&j<firstDayWeek-1))&&num++<count) {
                //新历排版
                UILabel* sonupLabel=[[UILabel alloc]initWithFrame:CGRectMake(sonView.frame.origin.x, sonView.frame.origin.y, sonView.frame.size.width, sonView.frame.size.height/2)];
                sonupLabel.text=[NSString stringWithFormat:@"%d",num];
                sonupLabel.backgroundColor=[UIColor clearColor];
                sonupLabel.font=[UIFont systemFontOfSize:17];
                sonupLabel.textAlignment=NSTextAlignmentCenter;

                

                
                //农历排版
                UILabel* sonDownLabel=[[UILabel alloc]initWithFrame:CGRectMake(sonView.frame.origin.x, sonView.frame.origin.y+sonView.frame.size.height/2, sonView.frame.size.width, sonView.frame.size.height/2)];
                oneDayDate.week=j+1;
                oneDayDate.day=num;
                LunarDay=[oneDayLunar solar_to_lunar:oneDayDate];
                if (LunarDay.day==1) {
                    sonDownLabel.text=[oneDayLunar getMoonMonthStringWithNSInteger:LunarDay.month];
                }else{
                    sonDownLabel.text=[oneDayLunar getMoonDayStringWithNSInteger:LunarDay.day];
                }
                //加入传统节日
                sonDownLabel.text=[oneDayLunar getFestivalOFLunarWithDate:LunarDay andwhithString:sonDownLabel.text];
                //加入24节气
                sonDownLabel.text=[oneDayLunar getSolarTermWithDate:oneDayDate andwihtString:sonDownLabel.text];
                //获取新历节日
                sonDownLabel.text=[oneDayLunar getFestivalWithDate:oneDayDate andWithString:sonDownLabel.text];
                sonDownLabel.backgroundColor=[UIColor clearColor];
                sonDownLabel.font=[UIFont systemFontOfSize:12];
                sonDownLabel.textAlignment=NSTextAlignmentCenter;

                
                //点击按钮
                UIButton* dateButton=[UIButton buttonWithType:UIButtonTypeCustom];
                dateButton.frame=CGRectMake(sonView.frame.origin.x, sonView.frame.origin.y, sonView.frame.size.width, sonView.frame.size.height);
                [dateButton setBackgroundImage:[UIImage imageNamed:@"lunar_selday"] forState:UIControlStateSelected];
                dateButton.tag=num;
                [dateButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
                [dateView addSubview:dateButton];
                [dateView addSubview:sonupLabel];
                [dateView addSubview:sonDownLabel];
                
                //导入节假日图片
                UIImageView* myImageView=[[UIImageView alloc]initWithFrame:sonView.frame];
                
                switch ([oneDayLunar isHolidayOrWorkdayWithDate:oneDayDate]) {
                    case 1:
                        myImageView.image=[UIImage imageNamed:@"lunar_holiday.png"];
                        [dateView addSubview:myImageView];
                        break;
                        
                    case 2:
                        myImageView.image=[UIImage imageNamed:@"lunar_workday.png"];
                        [dateView addSubview:myImageView];
                        break;
                    default:
                        break;
                }
                
                if (![sonDownLabel.text isEqualToString:[oneDayLunar getMoonDayStringWithNSInteger:LunarDay.day]]) {
                    sonDownLabel.textColor=[UIColor redColor];
                    sonDownLabel.font=[UIFont boldSystemFontOfSize:12];
                }
                if (j==5||j==6) {
                    sonupLabel.textColor=[UIColor redColor];
                }
                if (oneDayDate.year==nowDayDate.year&&oneDayDate.month==nowDayDate.month&&num==nowDayDate.day) {
                    sonupLabel.textColor=[UIColor colorWithRed:0 green:0.7 blue:0 alpha:1];
                    nowDayButton=dateButton;
                }
            }else if (i==0){
                UIGestureRecognizer* toUpGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onDown:)];
                [sonView addGestureRecognizer:toUpGesture];
            }else if (i==4||i==5){
                UIGestureRecognizer* toDownGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onUP:)];
                [sonView addGestureRecognizer:toDownGesture];
            }
        }
    }
    [newView addSubview:functionView];
    [newView addSubview:weekView];
    [newView addSubview:dateView];
    [downScrollView addSubview:newView];
//    [pageArray addObject:pageString];
}

-(void)createThirdView{
    int count=[monthpinArray[oneDayDate.month-1] intValue];
    if (((oneDayDate.year%4==0&&oneDayDate.year%100!=0)||(oneDayDate.year%400==0))&&(oneDayDate.month==2)) {
        count=29;
    }
    newView=[[UIView alloc]initWithFrame:CGRectMake(0,page*271, 320, 271)];
    UIView* functionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    
    //日期栏
    dateLabel=[UIButton buttonWithType:UIButtonTypeCustom];
    dateLabel.frame=CGRectMake(10, 1, 100, 28);
    [dateLabel setTitle:[NSString stringWithFormat:@"%d-%02d-%02d",oneDayDate.year,oneDayDate.month,oneDayDate.day] forState:UIControlStateNormal];
    dateLabel.titleLabel.font=[UIFont systemFontOfSize:18];
    [dateLabel setTitleColor:[UIColor colorWithRed:1 green:0.3 blue:0.3 alpha:1] forState:UIControlStateNormal   ];
    [dateLabel setTitleColor:[UIColor colorWithRed:1 green:0.9 blue:0.9 alpha:1] forState:UIControlStateHighlighted];
    [dateLabel addTarget:self action:@selector(toDatePicker:) forControlEvents:UIControlEventTouchUpInside];
    
    todayButton=[UIButton buttonWithType:UIButtonTypeCustom];
    todayButton.frame=CGRectMake(130, 1, 28, 28);
    [todayButton setImage:[UIImage imageNamed:@"sch_lst_today_hl"] forState:UIControlStateNormal];
    UIImageView* todayImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"day_list_today"]];
    todayImageView.frame=CGRectMake(0, 0, 28, 28);
    [todayButton addSubview:todayImageView];
    [todayButton addTarget:self action:@selector(backToToday:) forControlEvents:UIControlEventTouchUpInside];
    if (oneDayDate.year==nowDayDate.year&&oneDayDate.month==nowDayDate.month)
        nowTodayButton=todayButton;
    
    UIButton* shareButton=[UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame=CGRectMake(240, 1, 28, 28);
    [shareButton setImage:[UIImage imageNamed:@"share3.png"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareMyself:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* addButton=[UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame=CGRectMake(285, 1, 28, 28);
    [addButton addTarget:self action:@selector(goToDairyView:) forControlEvents:UIControlEventTouchUpInside];
    [addButton setImage:[UIImage imageNamed:@"day_list_add.png"] forState:UIControlStateNormal];
    [functionView addSubview:dateLabel];
    [functionView addSubview:addButton];
    [functionView addSubview:shareButton];
    [functionView addSubview:todayButton];
    
    //星期显示效果
    UIView* weekView=[[UIView alloc]initWithFrame:CGRectMake(0, 0+30, 320, 14)];
    UIView* weekViewBackground=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 14)];
    weekViewBackground.backgroundColor=[UIColor whiteColor];
    [weekView addSubview:weekViewBackground];
    weekView.backgroundColor=[UIColor clearColor];
    for (int i=0; i<7; ++i) {
        UILabel* weekLabel=[[UILabel alloc]initWithFrame:CGRectMake(i==0?0:45*i+3, 0, (i==0||i==6)?47:44, 14)];
        weekLabel.text=weekArray[i];
        weekLabel.textAlignment=NSTextAlignmentCenter;
        weekLabel.backgroundColor=[UIColor clearColor];
        weekLabel.font=[UIFont systemFontOfSize:12];
        weekLabel.alpha=0.8;
        [weekView addSubview:weekLabel];
    }
    
    //日历栏
    UIView* dateView=[[UIView alloc]initWithFrame:CGRectMake(0, 0+14+30, 320, 227)];
    int num=0;
    for (int i=0; i<6; ++i) {
        for (int j=0; j<7; ++j) {
            UIView* sonView=[[UIView alloc]initWithFrame:CGRectMake(j==0?0:45*j+3, 38*i, (j==0||j==6)?47:44, 37)];
            sonView.backgroundColor=[UIColor whiteColor];
            sonView.alpha=0.05;
            [dateView addSubview:sonView];
            if ((!(i==0&&j<firstDayWeek-1))&&num++<count) {
                //新历排版
                UILabel* sonupLabel=[[UILabel alloc]initWithFrame:CGRectMake(sonView.frame.origin.x, sonView.frame.origin.y+3, sonView.frame.size.width, sonView.frame.size.height/2)];
                sonupLabel.text=[NSString stringWithFormat:@"%d",num];
                sonupLabel.backgroundColor=[UIColor clearColor];
                sonupLabel.font=[UIFont systemFontOfSize:15];
                sonupLabel.textColor=[UIColor whiteColor];
                sonupLabel.textAlignment=NSTextAlignmentCenter;
                
                //农历排版
                UILabel* sonDownLabel=[[UILabel alloc]initWithFrame:CGRectMake(sonView.frame.origin.x, sonView.frame.origin.y+sonView.frame.size.height/2, sonView.frame.size.width, sonView.frame.size.height/2)];
                oneDayDate.day=num;
                oneDayDate.week=j+1;
                LunarDay=[oneDayLunar solar_to_lunar:oneDayDate];
                if (LunarDay.day==1) {
                    sonDownLabel.text=[oneDayLunar getMoonMonthStringWithNSInteger:LunarDay.month];
                }else{
                    sonDownLabel.text=[oneDayLunar getMoonDayStringWithNSInteger:LunarDay.day];
                }
                //加入传统节日
                sonDownLabel.text=[oneDayLunar getFestivalOFLunarWithDate:LunarDay andwhithString:sonDownLabel.text];
                //加入24节气
                sonDownLabel.text=[oneDayLunar getSolarTermWithDate:oneDayDate andwihtString:sonDownLabel.text];
                //获取新历节日
                sonDownLabel.text=[oneDayLunar getFestivalWithDate:oneDayDate andWithString:sonDownLabel.text];
                sonDownLabel.backgroundColor=[UIColor clearColor];
                sonDownLabel.font=[UIFont systemFontOfSize:11];
                sonDownLabel.textColor=[UIColor whiteColor];
                sonDownLabel.textAlignment=NSTextAlignmentCenter;
                
                
                //点击按钮
                UIButton* dateButton=[UIButton buttonWithType:UIButtonTypeCustom];
                dateButton.frame=CGRectMake(sonView.frame.origin.x, sonView.frame.origin.y, sonView.frame.size.width, sonView.frame.size.height);
                [dateButton setBackgroundImage:[YZdownView createImageWithColor:[UIColor colorWithRed:1 green:0.2 blue:0.2 alpha:1]] forState:UIControlStateSelected];
                dateButton.tag=num;
                [dateButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
                [dateView addSubview:dateButton];
                [dateView addSubview:sonupLabel];
                [dateView addSubview:sonDownLabel];
                
                if (oneDayDate.year==nowDayDate.year&&oneDayDate.month==nowDayDate.month&&num==nowDayDate.day) {
                    [dateButton setBackgroundImage:[YZdownView createImageWithColor:[UIColor colorWithRed:0.1 green:0.9 blue:1 alpha:1]] forState:UIControlStateNormal];
                    nowDayButton=dateButton;
                }
            }else if (i==0){
                UIGestureRecognizer* toUpGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onDown:)];
                [sonView addGestureRecognizer:toUpGesture];
            }else if (i==4||i==5){
                UIGestureRecognizer* toDownGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onUP:)];
                [sonView addGestureRecognizer:toDownGesture];
            }
        }
    }
    [newView addSubview:functionView];
    [newView addSubview:weekView];
    [newView addSubview:dateView];
    [downScrollView addSubview:newView];
//    [pageArray addObject:pageString];

}

-(void)createForthView{
    [self acquairSafeFirstDay];
    int count=[monthpinArray[oneDayDate.month-1] intValue];
    if (((oneDayDate.year%4==0&&oneDayDate.year%100!=0)||(oneDayDate.year%400==0))&&(oneDayDate.month==2)) {
        count=29;
    }
    newView=[[UIView alloc]initWithFrame:CGRectMake(0,page*271, 320, 271)];
    UIView* functionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    
    //日期栏
    dateLabel=[UIButton buttonWithType:UIButtonTypeCustom];
    dateLabel.frame=CGRectMake(10, 1, 100, 28);
    [dateLabel setTitle:[NSString stringWithFormat:@"%d-%02d-%02d",oneDayDate.year,oneDayDate.month,oneDayDate.day] forState:UIControlStateNormal];
    dateLabel.titleLabel.font=[UIFont systemFontOfSize:18];
    [dateLabel setTitleColor:[UIColor colorWithRed:1 green:0.5 blue:0.55  alpha:1] forState:UIControlStateNormal];
    [dateLabel setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [dateLabel addTarget:self action:@selector(toDatePicker:) forControlEvents:UIControlEventTouchUpInside];
    
    todayButton=[UIButton buttonWithType:UIButtonTypeCustom];
    todayButton.frame=CGRectMake(130, 1, 28, 28);
    [todayButton setImage:[UIImage imageNamed:@"sch_lst_today_hl"] forState:UIControlStateNormal];
    UIImageView* todayImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"day_list_today"]];
    todayImageView.frame=CGRectMake(0, 0, 28, 28);
    [todayButton addSubview:todayImageView];
    [todayButton addTarget:self action:@selector(backToToday:) forControlEvents:UIControlEventTouchUpInside];
    if (oneDayDate.year==nowDayDate.year&&oneDayDate.month==nowDayDate.month)
        nowTodayButton=todayButton;
    
    UIButton* shareButton=[UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame=CGRectMake(240, 1, 28, 28);
    [shareButton setImage:[UIImage imageNamed:@"share3.png"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareMyself:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* editButton=[UIButton buttonWithType:UIButtonTypeCustom];
    editButton.frame=CGRectMake(285, 1, 28, 28);
    [editButton addTarget:self action:@selector(editSafeperiod) forControlEvents:UIControlEventTouchUpInside];
    [editButton setImage:[UIImage imageNamed:@"sch_lst_calendar_icon"] forState:UIControlStateNormal];
    [functionView addSubview:dateLabel];
    [functionView addSubview:editButton];
    [functionView addSubview:shareButton];
    [functionView addSubview:todayButton];
    
    //星期显示效果
    UIView* weekView=[[UIView alloc]initWithFrame:CGRectMake(0, 0+30-1, 320, 14)];
    UIView* weekViewBackground=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 14)];
    weekViewBackground.backgroundColor=[UIColor colorWithRed:1 green:0.45 blue:0.5  alpha:1];
    [weekView addSubview:weekViewBackground];
    weekView.backgroundColor=[UIColor clearColor];
    for (int i=0; i<7; ++i) {
        UILabel* weekLabel=[[UILabel alloc]initWithFrame:CGRectMake(i==0?0:45*i+3, 0, (i==0||i==6)?47:44, 14)];
        weekLabel.text=weekArray[i];
        weekLabel.textAlignment=NSTextAlignmentCenter;
        weekLabel.textColor=[UIColor whiteColor];
        weekLabel.backgroundColor=[UIColor clearColor];
        weekLabel.font=[UIFont systemFontOfSize:12];
        [weekView addSubview:weekLabel];
    }
    
    //日历栏
    UIView* dateView=[[UIView alloc]initWithFrame:CGRectMake(0, 0+14+30, 320, 227)];
    //特殊页面添加线条
    for (int i=1; i<6; ++i) {
        UIView* horizontalLineView=[[UIView alloc]initWithFrame:CGRectMake(0, 37*i+(i-1), 320, 1)];
        horizontalLineView.backgroundColor=[UIColor colorWithRed:1 green:0.7 blue:0.75 alpha:1];
        [dateView addSubview:horizontalLineView];
    }
    
    for (int i=1; i<7; ++i) {
        UIView* verticalLineView=[[UIView alloc]initWithFrame:CGRectMake(47+45*(i-1), -15, 1, 242)];
        verticalLineView.backgroundColor=[UIColor colorWithRed:1 green:0.7 blue:0.75 alpha:1];
        [dateView addSubview:verticalLineView];
    }
    
    int num=0;
    for (int i=0; i<6; ++i) {
        for (int j=0; j<7; ++j) {
            UIView* sonView=[[UIView alloc]initWithFrame:CGRectMake(j==0?0:45*j+3, 38*i, (j==0||j==6)?47:44, 37)];
            sonView.backgroundColor=[UIColor whiteColor];
            sonView.alpha=0.05;
            [dateView addSubview:sonView];
            if ((!(i==0&&j<firstDayWeek-1))&&num++<count) {
                //新历排版
                UILabel* sonupLabel=[[UILabel alloc]initWithFrame:CGRectMake(sonView.frame.origin.x-4, sonView.frame.origin.y+4, sonView.frame.size.width, sonView.frame.size.height/2)];
                sonupLabel.text=[NSString stringWithFormat:@"%d",num];
                sonupLabel.backgroundColor=[UIColor clearColor];
                sonupLabel.font=[UIFont systemFontOfSize:15];
                sonupLabel.textColor=[UIColor blackColor];
                sonupLabel.textAlignment=NSTextAlignmentRight;
                
                //点击按钮
                UIButton* dateButton=[UIButton buttonWithType:UIButtonTypeCustom];
                dateButton.frame=CGRectMake(sonView.frame.origin.x, sonView.frame.origin.y, sonView.frame.size.width, sonView.frame.size.height);
                [dateButton setBackgroundImage:[YZdownView createImageWithColor:[UIColor colorWithRed:1 green:0.45 blue:0.5  alpha:1]] forState:UIControlStateSelected];
                dateButton.tag=num;
                [dateButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
                
                //添加生理期图片
                UIImageView* safeImageView=[[UIImageView alloc]initWithFrame:CGRectMake(sonView.frame.origin.x, sonView.frame.origin.y, sonView.frame.size.width, sonView.frame.size.height)];
                safeImageView.image=[self accordingToSafeTime:(safeFirstDayTime+num-1)%mySafePeriodModel.periodDate];
                
                
                [dateView addSubview:dateButton];
                [dateView addSubview:sonupLabel];
                [dateView addSubview:safeImageView];
                
                if (oneDayDate.year==nowDayDate.year&&oneDayDate.month==nowDayDate.month&&num==nowDayDate.day) {
                    sonupLabel.textColor=[UIColor whiteColor];
                    [dateButton setBackgroundImage:[YZdownView createImageWithColor:[UIColor colorWithRed:1 green:0.7 blue:0.75 alpha:1]] forState:UIControlStateNormal];
                    nowDayButton=dateButton;
                }
            }else if (i==0){
                UIGestureRecognizer* toUpGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onDown:)];
                [sonView addGestureRecognizer:toUpGesture];
            }else if (i==4||i==5){
                UIGestureRecognizer* toDownGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onUP:)];
                [sonView addGestureRecognizer:toDownGesture];
            }
        }
    }
    [newView addSubview:functionView];
    [newView addSubview:weekView];
    [newView addSubview:dateView];
    [downScrollView addSubview:newView];
//    [pageArray addObject:pageString];
}

-(void)createFifthView{
    int count=[monthpinArray[oneDayDate.month-1] intValue];
    if (((oneDayDate.year%4==0&&oneDayDate.year%100!=0)||(oneDayDate.year%400==0))&&(oneDayDate.month==2)) {
        count=29;
    }
    newView=[[UIView alloc]initWithFrame:CGRectMake(0,page*271, 320, 271)];
    UIView* functionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    
    //日期栏
    dateLabel=[UIButton buttonWithType:UIButtonTypeCustom];
    dateLabel.frame=CGRectMake(10, 1, 100, 28);
    [dateLabel setTitle:[NSString stringWithFormat:@"%d-%02d-%02d",oneDayDate.year,oneDayDate.month,oneDayDate.day] forState:UIControlStateNormal];
    dateLabel.titleLabel.font=[UIFont systemFontOfSize:18];
    [dateLabel setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
    [dateLabel addTarget:self action:@selector(toDatePicker:) forControlEvents:UIControlEventTouchUpInside];
    
    todayButton=[UIButton buttonWithType:UIButtonTypeCustom];
    todayButton.frame=CGRectMake(130, 1, 28, 28);
    [todayButton setImage:[UIImage imageNamed:@"sch_lst_today_hl"] forState:UIControlStateNormal];
    UIImageView* todayImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"day_list_today"]];
    todayImageView.frame=CGRectMake(0, 0, 28, 28);
    [todayButton addSubview:todayImageView];
    [todayButton addTarget:self action:@selector(backToToday:) forControlEvents:UIControlEventTouchUpInside];
    if (oneDayDate.year==nowDayDate.year&&oneDayDate.month==nowDayDate.month)
        nowTodayButton=todayButton;
    
    UIButton* shareButton=[UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame=CGRectMake(285, 1, 28, 28);
    [shareButton setImage:[UIImage imageNamed:@"share3.png"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareMyself:) forControlEvents:UIControlEventTouchUpInside];
    
    [functionView addSubview:dateLabel];
    [functionView addSubview:shareButton];
    [functionView addSubview:todayButton];
    
    //星期显示效果
    UIView* weekView=[[UIView alloc]initWithFrame:CGRectMake(0, 0+30, 320, 14)];
    UIView* weekViewBackground=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 14)];
    weekViewBackground.backgroundColor=[UIColor colorWithRed:0.15 green:0.1 blue:0.1 alpha:1];
    [weekView addSubview:weekViewBackground];
    weekView.backgroundColor=[UIColor clearColor];
    for (int i=0; i<7; ++i) {
        UILabel* weekLabel=[[UILabel alloc]initWithFrame:CGRectMake(i==0?0:45*i+3, 0, (i==0||i==6)?47:44, 14)];
        weekLabel.text=weekArray[i];
        weekLabel.textAlignment=NSTextAlignmentCenter;
        weekLabel.textColor=[UIColor whiteColor];
        weekLabel.backgroundColor=[UIColor clearColor];
        weekLabel.font=[UIFont systemFontOfSize:12];
        [weekView addSubview:weekLabel];
    }
    
    //日历栏
    UIView* dateView=[[UIView alloc]initWithFrame:CGRectMake(0, 0+14+30, 320, 227)];
    int num=0;
    for (int i=0; i<6; ++i) {
        for (int j=0; j<7; ++j) {
            UIView* sonView=[[UIView alloc]initWithFrame:CGRectMake(j==0?0:45*j+3, 38*i, (j==0||j==6)?47:44, 37)];
            sonView.backgroundColor=[UIColor whiteColor];
            sonView.alpha=0.35;
            [dateView addSubview:sonView];
            if ((!(i==0&&j<firstDayWeek-1))&&num++<count) {
                //新历排版
                UILabel* sonupLabel=[[UILabel alloc]initWithFrame:CGRectMake(sonView.frame.origin.x, sonView.frame.origin.y, sonView.frame.size.width, sonView.frame.size.height/2)];
                sonupLabel.text=[NSString stringWithFormat:@"%d",num];
                sonupLabel.backgroundColor=[UIColor clearColor];
                sonupLabel.font=[UIFont systemFontOfSize:18];
                sonupLabel.textColor=[UIColor colorWithRed:0.15 green:0.1 blue:0.1 alpha:1];
                sonupLabel.textAlignment=NSTextAlignmentRight;

                
                //点击按钮
                UIButton* dateButton=[UIButton buttonWithType:UIButtonTypeCustom];
                dateButton.frame=CGRectMake(sonView.frame.origin.x, sonView.frame.origin.y, sonView.frame.size.width, sonView.frame.size.height);
                [dateButton setBackgroundImage:[YZdownView createImageWithColor:[UIColor yellowColor]] forState:UIControlStateSelected];
                dateButton.tag=num;
                dateButton.alpha=0.8;
                [dateButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
                [dateView addSubview:dateButton];
                [dateView addSubview:sonupLabel];
                
                if (oneDayDate.year==nowDayDate.year&&oneDayDate.month==nowDayDate.month&&num==nowDayDate.day) {
                    sonupLabel.textColor=[UIColor orangeColor];
                    nowDayButton=dateButton;
                }
            }else if (i==0){
                UIGestureRecognizer* toUpGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onDown:)];
                [sonView addGestureRecognizer:toUpGesture];
            }else if (i==4||i==5){
                UIGestureRecognizer* toDownGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onUP:)];
                [sonView addGestureRecognizer:toDownGesture];
            }
        }
    }
    [newView addSubview:functionView];
    [newView addSubview:weekView];
    [newView addSubview:dateView];
    [downScrollView addSubview:newView];
//    [pageArray addObject:pageString];
}

-(void)createSixthView{
    int count=[monthpinArray[oneDayDate.month-1] intValue];
    if (((oneDayDate.year%4==0&&oneDayDate.year%100!=0)||(oneDayDate.year%400==0))&&(oneDayDate.month==2)) {
        count=29;
    }
    newView=[[UIView alloc]initWithFrame:CGRectMake(0,page*271, 320, 271)];
    UIView* functionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    
    //日期栏
    dateLabel=[UIButton buttonWithType:UIButtonTypeCustom];
    dateLabel.frame=CGRectMake(10, 1, 100, 28);
    [dateLabel setTitle:[NSString stringWithFormat:@"%d-%02d-%02d",oneDayDate.year,oneDayDate.month,oneDayDate.day] forState:UIControlStateNormal];
    dateLabel.titleLabel.font=[UIFont systemFontOfSize:18];
    [dateLabel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [dateLabel setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [dateLabel addTarget:self action:@selector(toDatePicker:) forControlEvents:UIControlEventTouchUpInside];
    
    todayButton=[UIButton buttonWithType:UIButtonTypeCustom];
    todayButton.frame=CGRectMake(130, 1, 28, 28);
    [todayButton setImage:[UIImage imageNamed:@"sch_lst_today_hl"] forState:UIControlStateNormal];
    UIImageView* todayImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"day_list_today"]];
    todayImageView.frame=CGRectMake(0, 0, 28, 28);
    [todayButton addSubview:todayImageView];
    [todayButton addTarget:self action:@selector(backToToday:) forControlEvents:UIControlEventTouchUpInside];
    if (oneDayDate.year==nowDayDate.year&&oneDayDate.month==nowDayDate.month)
        nowTodayButton=todayButton;
    
    UIButton* shareButton=[UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame=CGRectMake(285, 1, 28, 28);
    [shareButton setImage:[UIImage imageNamed:@"share3.png"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareMyself:) forControlEvents:UIControlEventTouchUpInside];
    
    [functionView addSubview:dateLabel];
    [functionView addSubview:shareButton];
    [functionView addSubview:todayButton];
    
    //星期显示效果
    UIView* weekView=[[UIView alloc]initWithFrame:CGRectMake(0, 0+30, 320, 14)];
    UIView* weekViewBackground=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 14)];
    weekViewBackground.backgroundColor=[UIColor whiteColor];
    weekViewBackground.alpha=0.8;
    [weekView addSubview:weekViewBackground];
    weekView.backgroundColor=[UIColor clearColor];
    for (int i=0; i<7; ++i) {
        UILabel* weekLabel=[[UILabel alloc]initWithFrame:CGRectMake(i==0?0:45*i+3, 0, (i==0||i==6)?47:44, 14)];
        weekLabel.text=weekArray[i];
        weekLabel.textAlignment=NSTextAlignmentCenter;
        weekLabel.textColor=[UIColor orangeColor];
        weekLabel.backgroundColor=[UIColor clearColor];
        weekLabel.font=[UIFont boldSystemFontOfSize:12];
        [weekView addSubview:weekLabel];
    }
    
    //日历栏
    UIView* dateView=[[UIView alloc]initWithFrame:CGRectMake(0, 0+14+30, 320, 227)];
    //特殊页面添加线条
    for (int i=0; i<6; ++i) {
        UIView* horizontalLineView=[[UIView alloc]initWithFrame:CGRectMake(0, i==0?0:37*i+(i-1), 320, 1)];
        horizontalLineView.backgroundColor=[UIColor grayColor];
        horizontalLineView.alpha=0.6;
        [dateView addSubview:horizontalLineView];
    }
    
    for (int i=0; i<6; ++i) {
        UIView* verticalLineView=[[UIView alloc]initWithFrame:CGRectMake(47+45*i, 0, 1, 227)];
        verticalLineView.backgroundColor=[UIColor grayColor];
        verticalLineView.alpha=0.6;
        [dateView addSubview:verticalLineView];
    }
    int num=0;
    for (int i=0; i<6; ++i) {
        for (int j=0; j<7; ++j) {
            UIView* sonView=[[UIView alloc]initWithFrame:CGRectMake(j==0?0:45*j+3, 38*i, (j==0||j==6)?47:44, 37)];
            sonView.backgroundColor=[UIColor whiteColor];
            sonView.alpha=0.05;
            [dateView addSubview:sonView];
            if ((!(i==0&&j<firstDayWeek-1))&&num++<count) {
                //新历排版
                UILabel* sonupLabel=[[UILabel alloc]initWithFrame:CGRectMake(sonView.frame.origin.x-2, sonView.frame.origin.y+1, sonView.frame.size.width, sonView.frame.size.height/2)];
                sonupLabel.text=[NSString stringWithFormat:@"%d",num];
                sonupLabel.backgroundColor=[UIColor clearColor];
                sonupLabel.font=[UIFont systemFontOfSize:15];
                sonupLabel.textColor=[UIColor orangeColor];
                sonupLabel.textAlignment=NSTextAlignmentRight;
                
                
                //点击按钮
                UIButton* dateButton=[UIButton buttonWithType:UIButtonTypeCustom];
                dateButton.frame=CGRectMake(sonView.frame.origin.x, sonView.frame.origin.y, sonView.frame.size.width, sonView.frame.size.height);
                [dateButton setBackgroundImage:[YZdownView createImageWithColor:[UIColor blackColor]] forState:UIControlStateSelected];
                dateButton.tag=num;
                dateButton.alpha=0.8;
                [dateButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
                [dateView addSubview:dateButton];
                [dateView addSubview:sonupLabel];
                
                if (oneDayDate.year==nowDayDate.year&&oneDayDate.month==nowDayDate.month&&num==nowDayDate.day) {
                    sonupLabel.textColor=[UIColor colorWithRed:0.1 green:0.9 blue:1 alpha:1];
                    [dateButton setBackgroundImage:[YZdownView createImageWithColor:[UIColor orangeColor]] forState:UIControlStateNormal];
                }
            }else if (i==0){
                UIGestureRecognizer* toUpGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onDown:)];
                [sonView addGestureRecognizer:toUpGesture];
            }else if (i==4||i==5){
                UIGestureRecognizer* toDownGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onUP:)];
                [sonView addGestureRecognizer:toDownGesture];
            }
        }
    }
    [newView addSubview:functionView];
    [newView addSubview:weekView];
    [newView addSubview:dateView];
    [downScrollView addSubview:newView];
//    [pageArray addObject:pageString];
}

-(void)createSevenView{
    int count=[monthpinArray[oneDayDate.month-1] intValue];
    if (((oneDayDate.year%4==0&&oneDayDate.year%100!=0)||(oneDayDate.year%400==0))&&(oneDayDate.month==2)) {
        count=29;
    }
    newView=[[UIView alloc]initWithFrame:CGRectMake(0,page*271, 320, 271)];
    UIView* functionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    
    //日期栏
    dateLabel=[UIButton buttonWithType:UIButtonTypeCustom];
    dateLabel.frame=CGRectMake(10, 1, 100, 28);
    [dateLabel setTitle:[NSString stringWithFormat:@"%d-%02d-%02d",oneDayDate.year,oneDayDate.month,oneDayDate.day] forState:UIControlStateNormal];
    dateLabel.titleLabel.font=[UIFont systemFontOfSize:18];
    [dateLabel setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
    [dateLabel addTarget:self action:@selector(toDatePicker:) forControlEvents:UIControlEventTouchUpInside];
    
    todayButton=[UIButton buttonWithType:UIButtonTypeCustom];
    todayButton.frame=CGRectMake(130, 1, 28, 28);
    [todayButton setImage:[UIImage imageNamed:@"sch_lst_today_hl"] forState:UIControlStateNormal];
    UIImageView* todayImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"day_list_today"]];
    todayImageView.frame=CGRectMake(0, 0, 28, 28);
    [todayButton addSubview:todayImageView];
    [todayButton addTarget:self action:@selector(backToToday:) forControlEvents:UIControlEventTouchUpInside];
    if (oneDayDate.year==nowDayDate.year&&oneDayDate.month==nowDayDate.month)
        nowTodayButton=todayButton;
    
    UIButton* shareButton=[UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame=CGRectMake(285, 1, 28, 28);
    [shareButton setImage:[UIImage imageNamed:@"share3.png"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareMyself:) forControlEvents:UIControlEventTouchUpInside];
    

    [functionView addSubview:dateLabel];
    [functionView addSubview:shareButton];
    [functionView addSubview:todayButton];
    
    //星期显示效果
    UIView* weekView=[[UIView alloc]initWithFrame:CGRectMake(0, 0+30, 320, 14)];
    weekView.backgroundColor=[UIColor clearColor];
    for (int i=0; i<7; ++i) {
        UILabel* weekLabel=[[UILabel alloc]initWithFrame:CGRectMake(i==0?0:45*i+3, 0, (i==0||i==6)?47:44, 14)];
        weekLabel.text=weekArray[i];
        weekLabel.textAlignment=NSTextAlignmentCenter;
        weekLabel.textColor=[UIColor whiteColor];
        weekLabel.backgroundColor=[UIColor clearColor];
        weekLabel.font=[UIFont systemFontOfSize:11];
        [weekView addSubview:weekLabel];
    }
    
    //日历栏
    UIView* dateView=[[UIView alloc]initWithFrame:CGRectMake(0, 0+14+30, 320, 227)];
    int num=0;
    for (int i=0; i<6; ++i) {
        for (int j=0; j<7; ++j) {
            UIView* sonView=[[UIView alloc]initWithFrame:CGRectMake(j==0?0:45*j+3, 38*i, (j==0||j==6)?47:44, 37)];
            sonView.backgroundColor=[UIColor whiteColor];
            sonView.alpha=0.05;
            [dateView addSubview:sonView];
            if ((!(i==0&&j<firstDayWeek-1))&&num++<count) {
                //新历排版
                UILabel* sonupLabel=[[UILabel alloc]initWithFrame:CGRectMake(sonView.frame.origin.x-2, sonView.frame.origin.y+4, sonView.frame.size.width, sonView.frame.size.height/2)];
                sonupLabel.text=[NSString stringWithFormat:@"%d",num];
                sonupLabel.backgroundColor=[UIColor clearColor];
                sonupLabel.font=[UIFont systemFontOfSize:15];
                sonupLabel.textColor=[UIColor whiteColor];
                sonupLabel.textAlignment=NSTextAlignmentRight;
                

                
                //点击按钮
                UIButton* dateButton=[UIButton buttonWithType:UIButtonTypeCustom];
                dateButton.frame=CGRectMake(sonView.frame.origin.x, sonView.frame.origin.y, sonView.frame.size.width, sonView.frame.size.height);
                [dateButton setBackgroundImage:[YZdownView createImageWithColor:[UIColor blackColor]] forState:UIControlStateSelected];
                dateButton.tag=num;
                dateButton.alpha=0.3;
                [dateButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
                [dateView addSubview:dateButton];
                [dateView addSubview:sonupLabel];
                
                if (oneDayDate.year==nowDayDate.year&&oneDayDate.month==nowDayDate.month&&num==nowDayDate.day) {
                    sonupLabel.textColor=[UIColor yellowColor];
                    [dateButton setBackgroundImage:[YZdownView createImageWithColor:[UIColor colorWithRed:0.1 green:0.9 blue:1 alpha:1]] forState:UIControlStateNormal];
                    nowDayButton=dateButton;
                }
            }else if (i==0){
                UIGestureRecognizer* toUpGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onDown:)];
                [sonView addGestureRecognizer:toUpGesture];
            }else if (i==4||i==5){
                UIGestureRecognizer* toDownGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onUP:)];
                [sonView addGestureRecognizer:toDownGesture];
            }
        }
    }
    [newView addSubview:functionView];
    [newView addSubview:weekView];
    [newView addSubview:dateView];
    [downScrollView addSubview:newView];
//    [pageArray addObject:pageString];
}

-(void)createEighthView{
    int count=[monthpinArray[oneDayDate.month-1] intValue];
    if (((oneDayDate.year%4==0&&oneDayDate.year%100!=0)||(oneDayDate.year%400==0))&&(oneDayDate.month==2)) {
        count=29;
    }
    newView=[[UIView alloc]initWithFrame:CGRectMake(0,page*271, 320, 271)];
    UIView* functionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    
    //日期栏
    dateLabel=[UIButton buttonWithType:UIButtonTypeCustom];
    dateLabel.frame=CGRectMake(10, 1, 100, 28);
    [dateLabel setTitle:[NSString stringWithFormat:@"%d-%02d-%02d",oneDayDate.year,oneDayDate.month,oneDayDate.day] forState:UIControlStateNormal];
    dateLabel.titleLabel.font=[UIFont systemFontOfSize:18];
    [dateLabel setTitleColor:[UIColor colorWithRed:0.1 green:0.55 blue:0.69 alpha:1] forState:UIControlStateNormal];
    [dateLabel setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
    [dateLabel addTarget:self action:@selector(toDatePicker:) forControlEvents:UIControlEventTouchUpInside];
    
    todayButton=[UIButton buttonWithType:UIButtonTypeCustom];
    todayButton.frame=CGRectMake(130, 1, 28, 28);
    [todayButton setImage:[UIImage imageNamed:@"sch_lst_today_hl"] forState:UIControlStateNormal];
    UIImageView* todayImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"day_list_today"]];
    todayImageView.frame=CGRectMake(0, 0, 28, 28);
    [todayButton addSubview:todayImageView];
    [todayButton addTarget:self action:@selector(backToToday:) forControlEvents:UIControlEventTouchUpInside];
    if (oneDayDate.year==nowDayDate.year&&oneDayDate.month==nowDayDate.month)
        nowTodayButton=todayButton;
    
    UIButton* shareButton=[UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame=CGRectMake(285, 1, 28, 28);
    [shareButton setImage:[UIImage imageNamed:@"share3.png"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareMyself:) forControlEvents:UIControlEventTouchUpInside];
    

    [functionView addSubview:dateLabel];
    [functionView addSubview:shareButton];
    [functionView addSubview:todayButton];
    
    //星期显示效果
    UIView* weekView=[[UIView alloc]initWithFrame:CGRectMake(0, 0+30, 320, 14)];
    weekView.backgroundColor=[UIColor clearColor];
    for (int i=0; i<7; ++i) {
        UILabel* weekLabel=[[UILabel alloc]initWithFrame:CGRectMake(i==0?0:45*i+3, 0, (i==0||i==6)?47:44, 14)];
        weekLabel.text=weekArray[i];
        weekLabel.textAlignment=NSTextAlignmentCenter;
        weekLabel.textColor=[UIColor colorWithRed:0.1 green:0.55 blue:0.69 alpha:1];
        weekLabel.backgroundColor=[UIColor clearColor];
        weekLabel.font=[UIFont boldSystemFontOfSize:12];
        [weekView addSubview:weekLabel];
    }
    
    //日历栏
    UIView* dateView=[[UIView alloc]initWithFrame:CGRectMake(0, 0+14+30, 320, 227)];
    //特殊页面添加线条
    for (int i=0; i<6; ++i) {
        UIView* horizontalLineView=[[UIView alloc]initWithFrame:CGRectMake(0, i==0?0:37*i+(i-1), 320, 1)];
        horizontalLineView.backgroundColor=[UIColor colorWithRed:0.1 green:0.55 blue:0.69 alpha:1];
        [dateView addSubview:horizontalLineView];
    }
    
    for (int i=0; i<6; ++i) {
        UIView* verticalLineView=[[UIView alloc]initWithFrame:CGRectMake(47+45*i, 0, 1, 227)];
        verticalLineView.backgroundColor=[UIColor colorWithRed:0.1 green:0.55 blue:0.69 alpha:1];
        [dateView addSubview:verticalLineView];
    }
    int num=0;
    for (int i=0; i<6; ++i) {
        for (int j=0; j<7; ++j) {
            UIView* sonView=[[UIView alloc]initWithFrame:CGRectMake(j==0?0:45*j+3, 38*i, (j==0||j==6)?47:44, 37)];
            sonView.backgroundColor=[UIColor whiteColor];
            sonView.alpha=0.05;
            [dateView addSubview:sonView];
            if ((!(i==0&&j<firstDayWeek-1))&&num++<count) {
                //新历排版
                UILabel* sonupLabel=[[UILabel alloc]initWithFrame:CGRectMake(sonView.frame.origin.x-2, sonView.frame.origin.y+4, sonView.frame.size.width, sonView.frame.size.height/2)];
                sonupLabel.text=[NSString stringWithFormat:@"%d",num];
                sonupLabel.backgroundColor=[UIColor clearColor];
                sonupLabel.font=[UIFont boldSystemFontOfSize:16];
                sonupLabel.textColor=[UIColor colorWithRed:0.1 green:0.55 blue:0.69 alpha:1];
                sonupLabel.textAlignment=NSTextAlignmentRight;
                
                
                //点击按钮
                UIButton* dateButton=[UIButton buttonWithType:UIButtonTypeCustom];
                dateButton.frame=CGRectMake(sonView.frame.origin.x, sonView.frame.origin.y, sonView.frame.size.width, sonView.frame.size.height);
                [dateButton setBackgroundImage:[YZdownView createImageWithColor:[UIColor colorWithRed:0.1 green:0.9 blue:1 alpha:1]] forState:UIControlStateSelected];
                dateButton.tag=num;
                dateButton.alpha=0.8;
                [dateButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
                [dateView addSubview:dateButton];
                [dateView addSubview:sonupLabel];
                
                if (oneDayDate.year==nowDayDate.year&&oneDayDate.month==nowDayDate.month&&num==nowDayDate.day) {
                    sonupLabel.textColor=[UIColor whiteColor];
                    [dateButton setBackgroundImage:[YZdownView createImageWithColor:[UIColor colorWithRed:0.1 green:0.55 blue:0.69 alpha:1]] forState:UIControlStateNormal];
                    nowDayButton=dateButton;
                }
            }else if (i==0){
                UIGestureRecognizer* toUpGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onDown:)];
                [sonView addGestureRecognizer:toUpGesture];
            }else if (i==4||i==5){
                UIGestureRecognizer* toDownGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onUP:)];
                [sonView addGestureRecognizer:toDownGesture];
            }
        }
    }
    [newView addSubview:functionView];
    [newView addSubview:weekView];
    [newView addSubview:dateView];
    [downScrollView addSubview:newView];
//    [pageArray addObject:pageString];
}

//上下拉手势
-(void)onUP:(id)sender{
        page++;
    int count=[monthpinArray[oneDayDate.month-1] intValue];
    if (((oneDayDate.year%4==0&&oneDayDate.year%100!=0)||(oneDayDate.year%400==0))&&(oneDayDate.month==2)) {
        count=29;
    }
    firstDayWeek=(firstDayWeek+count)%7;
    if (firstDayWeek==0) {
        firstDayWeek=7;
    }
    if (++oneDayDate.month>12) {
        oneDayDate.year++;
        oneDayDate.month=1;
    }

    LastButton.selected=NO;
    [self.myEveryPageTurningDelegate everyPageTurningByDate:oneDayDate andPage:page andFirstWeekDay:firstDayWeek];
//    NSLog(@"nimei%d",page);
}

-(void)onDown:(id)sender{
    page--;
    if (--oneDayDate.month==0) {
        oneDayDate.year--;
        oneDayDate.month=12;
    }
    int count=[monthpinArray[oneDayDate.month-1] intValue];
    if (((oneDayDate.year%4==0&&oneDayDate.year%100!=0)||(oneDayDate.year%400==0))&&(oneDayDate.month==2)) {
        count=29;
    }
    firstDayWeek=(firstDayWeek+7-count%7)%7;
    if (firstDayWeek==0) {
        firstDayWeek=7;
    }
    LastButton.selected=NO;
    [self.myEveryPageTurningDelegate everyPageTurningByDate:oneDayDate andPage:page andFirstWeekDay:firstDayWeek];
//    NSLog(@"nijie%d",page);
}

//button点击相应按钮
-(void)onClick:(UIButton*)sender{

    if (mode==1) {
        BOOL isWeatherLabelHide=YES;
        int i=-1;
        for (NSString* clickStr in weatherClickDateArray) {
            ++i;
            if (sender.tag==[clickStr intValue]) {
                //NSLog(@"==%d==",i);
                isWeatherLabelHide=NO;
                [self.myPushWeatherTableDelegate pushWeatherTableByDay:i];
            }
        }
        if (isWeatherLabelHide) {
            [self.myHideWeatherDelegate hideWeatherTable];
        }
    }
    
    if (mode==4) {
 //       NSLog(@"%d",(sender.tag-1+safeFirstDayTime)%mySafePeriodModel.periodDate);
        YZSafePeriodModel2* myMode=[[YZSafePeriodModel2 alloc]init];
        myMode=[self safePeriodDataChangedByTime:(sender.tag-1+safeFirstDayTime)%mySafePeriodModel.periodDate];
 //       NSLog(@"%d--%d--%d",myMode.safePeriodMode,myMode.contentDay,myMode.numberOfPic);
        [self.myPushSafePeriodTableViewDelegate pushSafePeriodTableViewByModel:myMode];
    }
    
    if (sender.tag!=nowDayButton.tag) {
        nowDayButton.selected=NO;
    }
    if (LastButton.tag!=sender.tag) {
        LastButton.selected=NO;
        LastButton=sender;
    }
    oneDayDate.week=(firstDayWeek+oneDayDate.day-1)%7;
    if (oneDayDate.week==0) {
        oneDayDate.week=7;
    }
    oneDayDate.day=sender.tag%100;
    [dateLabel setTitle:[NSString stringWithFormat:@"%d-%02d-%02d",oneDayDate.year,oneDayDate.month,oneDayDate.day] forState:UIControlStateNormal];
    if (oneDayDate.year==nowDayDate.year&&oneDayDate.month==nowDayDate.month&&oneDayDate.day==nowDayDate.day) {
        nowTodayButton.hidden=YES;
    }
    else{
        nowTodayButton.hidden=NO;
    }
    if (sender.selected==YES&&mode==1) {
        [self.myDairyDelegate presentDairyView:oneDayDate];
    }
    sender.selected=YES;
    
}

//返回今天
-(void)backToToday:(id)sender{
    firstDayWeek=(7+nowDayDate.week-(nowDayDate.day-1)%7)%7;;
    page=0;
    oneDayDate=nowDayDate;
    self.isRightNow=YES;
    [self.myEveryPageTurningDelegate everyPageTurningByDate:oneDayDate andPage:page andFirstWeekDay:firstDayWeek];
    LastButton.selected=NO;
    LastButton=nowDayButton;
    [self onClick:nowDayButton];
    nowDayButton.selected=YES;
    nowTodayButton.hidden=YES;
}

//打开当天日志管理
-(void)goToDairyView:(id)sender{
    if (LastButton.selected==YES) {
        [self.myDairyDelegate presentDairyView:oneDayDate];
    }
}

+ (UIImage *)createImageWithColor:(UIColor *)color
{
        CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextFillRect(context, rect);
        UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return theImage;
}

//获取当前时间
-(void)acquairDate{
    NSDate* myDate=[NSDate date];
    NSDateFormatter* dateFormatter=[[NSDateFormatter alloc]init];
    dateFormatter.dateFormat=@"yyyy";
    nowDayDate.year=[[dateFormatter stringFromDate:myDate] intValue];
    dateFormatter.dateFormat=@"MM";
    nowDayDate.month=[[dateFormatter stringFromDate:myDate] intValue];
    dateFormatter.dateFormat=@"dd";
    nowDayDate.day=[[dateFormatter stringFromDate:myDate] intValue];
    dateFormatter.dateFormat=@"e";
    nowDayDate.week=[[dateFormatter stringFromDate:myDate] intValue]-1;
    if (nowDayDate.week==0) {
        nowDayDate.week=7;
    }
    int year=nowDayDate.year;
    int month=nowDayDate.month;
    int day=nowDayDate.day;
    for (int i=0; i<6; ++i) {
        int monthCount=[monthpinArray[month-1] intValue];
        if (((year%4==0&&year%100!=0)||(year%400==0))&&(month==2)){
            monthCount=29;
        };
        if (day>monthCount) {
            day-=monthCount;
            if (++month>12) {
                ++year;
                month=1;
            }
        }
        NSString* dateStr=[NSString stringWithFormat:@"%d",10000*year+100*month+day];
        day++;
        [weatherClickDateArray addObject:dateStr];
    }
}

//打开分享页面
-(void)shareMyself:(id)sender{
    [self.myShareDelegate showShareView];
}

//打开生理期编辑界面
-(void)editSafeperiod{
    [self.mySafePeriodDelegate presentSafePeriod];
}

//打开当天时间选择器
-(void)toDatePicker:(id)sender{
    [self.myDatePickDelegate showDatePicker];
}

-(void)toPresentPage{
    lastView=newView;
    [self addnewView];
    [dateLabel setTitle:[NSString stringWithFormat:@"%d-%02d-%02d",oneDayDate.year,oneDayDate.month,oneDayDate.day] forState:UIControlStateNormal];
}

//通过pickView返回的数据翻页
-(void)changePageByPicker:(YZDate)myDate{
    oneDayDate=myDate;
    page=(oneDayDate.year-nowDayDate.year)*12+oneDayDate.month-nowDayDate.month;
    firstDayWeek=(7+oneDayDate.week-(oneDayDate.day-1)%7)%7;
    if (firstDayWeek==0) {
        firstDayWeek=7;
    }
    lastView=newView;
    [self addnewView];
    [dateLabel setTitle:[NSString stringWithFormat:@"%d-%02d-%02d",oneDayDate.year,oneDayDate.month,oneDayDate.day] forState:UIControlStateNormal];
}

-(void)otherPageChangeByDate:(YZDate)mydate andPage:(int)Mypage andFirstWeekDay:(int)firstWeekDayThen{
        page=Mypage;
        oneDayDate=mydate;
        firstDayWeek=firstWeekDayThen;
    lastView=newView;
    [self addnewView];
    [dateLabel setTitle:[NSString stringWithFormat:@"%d-%02d-%02d",oneDayDate.year,oneDayDate.month,oneDayDate.day] forState:UIControlStateNormal];
}

//获得安全期数据
-(void)setSafePeriodByPeriodModel:(YZSafePeriodModel *)mySafePeriod{
    mySafePeriodModel=mySafePeriod;
}

//计算本月第一天离上次月经时间的时间偏差
-(void)acquairSafeFirstDay{

    YZDate thisDay=oneDayDate;
    thisDay.day=1;
    YZDate safeDate;
    safeDate.year=mySafePeriodModel.lastTimeYear;
    safeDate.month=mySafePeriodModel.lastTimeMonth;
    safeDate.day=mySafePeriodModel.lastTimeDay;
    safeFirstDayTime=[oneDayLunar getTwoDaysIntervalFromDay:thisDay toDate:safeDate]%mySafePeriodModel.periodDate;
    if (safeFirstDayTime<0) {
        safeFirstDayTime+=mySafePeriodModel.periodDate;
    }
//    NSLog(@"year=%d,month=%d,day=%d,safeFirstDayTime=%d",thisDay.year,thisDay.month,thisDay.day,safeFirstDayTime);
}

//根据安全日期计算，返回图片
-(UIImage*)accordingToSafeTime:(int)time{
    NSString* imageString;

    if (time>=0&&time<=mySafePeriodModel.durationDate-1) {
        imageString=[NSString stringWithFormat:@"safeperiod_yuejing%d",mySafePeriodModel.menstruationPicNum];
    }else if ((time>=mySafePeriodModel.periodDate-19&&time<=mySafePeriodModel.periodDate-10)&&(time!=mySafePeriodModel.periodDate-14)){
        imageString=[NSString stringWithFormat:@"safeperiod_weixian%d",mySafePeriodModel.DangerousNum];
    }else if (time==mySafePeriodModel.periodDate-14){
        imageString=[NSString stringWithFormat:@"safeperiod_pailan%d",mySafePeriodModel.ovulationPicNum];
    }else{
        imageString=[NSString stringWithFormat:@"safeperiod_anquan%d",mySafePeriodModel.SafePicNum];
    }
        
    return [UIImage imageNamed:imageString];
}

-(YZSafePeriodModel2*)safePeriodDataChangedByTime:(int)time{
    YZSafePeriodModel2* myModel=[[YZSafePeriodModel2 alloc]init];
    if (time>=0&&time<=mySafePeriodModel.durationDate-1) {
        myModel.safePeriodMode=3;
        myModel.contentDay=time+1;
        myModel.numberOfPic=mySafePeriodModel.menstruationPicNum;
        
    }else if ((time>=mySafePeriodModel.periodDate-19&&time<=mySafePeriodModel.periodDate-10)&&(time!=mySafePeriodModel.periodDate-14)){
        myModel.safePeriodMode=2;
        myModel.contentDay=time-(mySafePeriodModel.periodDate-19)+1;
        myModel.numberOfPic=mySafePeriodModel.DangerousNum;

    }else if (time==mySafePeriodModel.periodDate-14){
        myModel.safePeriodMode=4;
        myModel.contentDay=250;
        myModel.numberOfPic=mySafePeriodModel.ovulationPicNum;
        
    }else if (time>=mySafePeriodModel.durationDate&&time<=mySafePeriodModel.periodDate-20){
        myModel.safePeriodMode=1;
        myModel.contentDay=time-mySafePeriodModel.durationDate+1;
        myModel.numberOfPic=mySafePeriodModel.SafePicNum;
        
    }else{
        myModel.safePeriodMode=1;
        myModel.contentDay=time-(mySafePeriodModel.periodDate-9)+1;
        myModel.numberOfPic=mySafePeriodModel.SafePicNum;
        
    }
    
    return myModel;
}

@end
