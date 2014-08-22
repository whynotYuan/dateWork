//
//  YZWeatherViewController.m
//  dateWork
//
//  Created by 黄桂源 on 14-1-15.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "YZWeatherViewController.h"
#import "YZLineDrawingView.h"
#import "YZWeatherCityArray.h"

@interface YZWeatherViewController ()<UIScrollViewDelegate>

@end

@implementation YZWeatherViewController{
    UIScrollView* myScrollView;
    UILabel* NavigationTitleLabel;
    NSMutableArray* dateArray;
    NSArray* weekArray;
    NSArray* weekCountArray;
    NSArray* monthpinArray;
    NSMutableArray* cityNameArray;
    YZWeatherCityArray* myCityArray;
    BOOL isCreate;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    isCreate=NO;
    weekCountArray=[NSArray array];
    myCityArray=[YZWeatherCityArray shareWeatherCityArray];
    weekCountArray=@[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    monthpinArray=[NSArray array];

    monthpinArray=@[@"31",@"28",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31"];
    cityNameArray=[NSMutableArray array];
    [self acquairDate];
	[self addbackground];
    [self addNavigationBar];
}

-(void)addbackground{
    myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    myScrollView.showsHorizontalScrollIndicator=NO;
    myScrollView.pagingEnabled=YES;
    myScrollView.bounces=NO;
    myScrollView.delegate=self;
    [self.view addSubview:myScrollView];
}

//实现scrollView协议
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int page=myScrollView.contentOffset.x/myScrollView.frame.size.width;
    
    NavigationTitleLabel.text=cityNameArray[page];
}


-(void)addNavigationBar{
    UIView* navigationBarView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    UIImageView* navBackground=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    navBackground.image=[UIImage imageNamed:@"tileScrollBack_320_110"];
    
    NavigationTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(120, 12, 80, 30)];
    NavigationTitleLabel.textColor=[UIColor whiteColor];
    NavigationTitleLabel.font=[UIFont boldSystemFontOfSize:19];
    NavigationTitleLabel.textAlignment=NSTextAlignmentCenter;
    
    UIButton* leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame=CGRectMake(5, 8, 40, 40);
    [leftButton setImage:[UIImage imageNamed:@"back_iphone5.png"] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"button_selected.9.png"] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame=CGRectMake(280, 15, 30, 30);
    [rightButton setImage:[UIImage imageNamed:@"weather_manager_icon.png"] forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"button_selected.9.png"] forState:UIControlStateHighlighted];
    
    [navigationBarView addSubview:navBackground];
    [navigationBarView addSubview:NavigationTitleLabel];
    [navigationBarView addSubview:leftButton];
    [navigationBarView addSubview:rightButton];
    [self.view addSubview:navigationBarView];
}

-(void)creatWeatherScrollScrollToPage:(int)page{
    if (!isCreate) {
        for (int i=0; i<myCityArray.cityArray.count; ++i) {
            [self refleshViewByWeatherData:myCityArray.cityArray[i] andPage:i];
        }
        isCreate=YES;
    }
    [myScrollView setContentOffset:CGPointMake(page*320, 0)];
    NavigationTitleLabel.text=cityNameArray[page];
}

-(void)refleshViewByWeatherData:(YZWeatherModel *)weatherData andPage:(int)page{
    
    UIView* myView=[[UIView alloc]initWithFrame:CGRectMake(320*page, 0, 320, 480)];
    
    UIImageView* backGroundImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    backGroundImage.image=[UIImage imageNamed:@"weather_bg.jpg"];
  
    
// 第一栏
    UIView* firstLineView=[[UIView alloc]initWithFrame:CGRectMake(0, 50, 320, 45)];
    
    UIView* firstLineBackground=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 45)];
    firstLineBackground.backgroundColor=[UIColor whiteColor];
    firstLineBackground.alpha=0.1;
    [firstLineView addSubview:firstLineBackground];
    
    for (int i=0; i<5; ++i) {
        UILabel* firstUpLabel=[[UILabel alloc]initWithFrame:CGRectMake(64*i, 4, 64, 20)];
        firstUpLabel.text=weekArray[i];
        firstUpLabel.textAlignment=NSTextAlignmentCenter;
        firstUpLabel.textColor=[UIColor whiteColor];
        if (i==0) {
            firstUpLabel.textColor=[UIColor yellowColor];
        }
        firstUpLabel.font=[UIFont systemFontOfSize:14];
        UILabel* firstDownLabel=[[UILabel alloc]initWithFrame:CGRectMake(64*i, 24, 64, 18)];
        firstDownLabel.text=dateArray[i];
        firstDownLabel.textAlignment=NSTextAlignmentCenter;
        firstDownLabel.textColor=[UIColor whiteColor];
        firstDownLabel.font=[UIFont systemFontOfSize:14];
        [firstLineView addSubview:firstUpLabel];
        [firstLineView addSubview:firstDownLabel];
    }
    


    
    
//第二栏
    UIView* secondLineView=[[UIView alloc]initWithFrame:CGRectMake(0, 95, 320, 50)];
    UIView* secondLine=[[UIView alloc]initWithFrame:CGRectMake(0, 49, 320, 1)];
    secondLine.backgroundColor=[UIColor whiteColor];
    secondLine.alpha=0.2;
    [secondLineView addSubview:secondLine];
    
    for (int i=0; i<5; ++i) {
        UILabel* secondUpLabel=[[UILabel alloc]initWithFrame:CGRectMake(64*i, 4, 64, 20)];
        secondUpLabel.text=weatherData.windArray[i];
        secondUpLabel.textAlignment=NSTextAlignmentCenter;
        secondUpLabel.textColor=[UIColor whiteColor];
        secondUpLabel.font=[UIFont systemFontOfSize:13];
        UILabel* secondDownLabel=[[UILabel alloc]initWithFrame:CGRectMake(64*i, 24, 64, 18)];
        secondDownLabel.text=weatherData.flArray[i];
        secondDownLabel.textAlignment=NSTextAlignmentCenter;
        secondDownLabel.textColor=[UIColor whiteColor];
        secondDownLabel.font=[UIFont systemFontOfSize:13];
        [secondLineView addSubview:secondUpLabel];
        [secondLineView addSubview:secondDownLabel];
    }
    



//第三栏
    UIView* thirdLineView=[[UIView alloc]initWithFrame:CGRectMake(0, 145, 320, 25)];
    UIView* thirdLine=[[UIView alloc]initWithFrame:CGRectMake(0, 24, 320, 1)];
    thirdLine.backgroundColor=[UIColor whiteColor];
    thirdLine.alpha=0.2;
    [thirdLineView addSubview:thirdLine];
    
    for (int i=0; i<5; ++i) {
        UILabel* thirdLabel=[[UILabel alloc]initWithFrame:CGRectMake(64*i, 2, 64, 20)];
        thirdLabel.text=weatherData.weatherArray[i];;
        thirdLabel.textAlignment=NSTextAlignmentCenter;
        thirdLabel.textColor=[UIColor whiteColor];
        thirdLabel.font=[UIFont systemFontOfSize:12];
        [thirdLineView addSubview:thirdLabel];
    }

    
//第四栏
    UIView* forthLineView=[[UIView alloc]initWithFrame:CGRectMake(0, 170, 320, 50)];
    UIView* forthLine=[[UIView alloc]initWithFrame:CGRectMake(0, 49, 320, 1)];
    forthLine.backgroundColor=[UIColor whiteColor];
    forthLine.alpha=0.2;
    [forthLineView addSubview:forthLine];
    
    for (int i=0; i<5; ++i) {
        UIImageView* forthImage=[[UIImageView alloc]initWithFrame:CGRectMake(19+64*i, 12, 26, 26)];
        forthImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",weatherData.imgArray[i]]];
        [forthLineView addSubview:forthImage];
    }
    


//第五栏
    UIView* fifthView=[[UIView alloc]initWithFrame:CGRectMake(0, 220, 320, 260)];
//计算每天偏差
    NSMutableArray* daySortArray=[NSMutableArray arrayWithArray:weatherData.dayTempArray];
    for (int i=0; i<daySortArray.count; ++i) {
        for (int j=i+1; j<daySortArray.count; ++j) {
            if ([daySortArray[i] intValue]>[daySortArray[j] intValue]) {
                [daySortArray exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
    }
    int dayMax=([weatherData.dayTempArray[0] intValue]-[daySortArray[0] intValue])>=([daySortArray[daySortArray.count-1] intValue]-[weatherData.dayTempArray[0] intValue])?([weatherData.dayTempArray[0] intValue]-[daySortArray[0] intValue]):([daySortArray[daySortArray.count-1] intValue]-[weatherData.dayTempArray[0] intValue]);
    
    NSMutableArray* nightSortArray=[NSMutableArray arrayWithArray:weatherData.nightTempArray];
    for (int i=0; i<nightSortArray.count; ++i) {
        for (int j=i+1; j<nightSortArray.count; ++j) {
            if ([nightSortArray[i] intValue]>[nightSortArray[j] intValue]) {
                [nightSortArray exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
    }
    int nightMax=([weatherData.nightTempArray[0] intValue]-[nightSortArray[0] intValue])>([nightSortArray[nightSortArray.count-1] intValue]-[weatherData.nightTempArray[0] intValue])?([weatherData.nightTempArray[0] intValue]-[nightSortArray[0] intValue]):([nightSortArray[nightSortArray.count-1] intValue]-[weatherData.nightTempArray[0] intValue]);
    
    int max=dayMax>=nightMax?dayMax:nightMax;
    
    YZLineDrawingView* dayLineView=[[YZLineDrawingView alloc]initWithFrame:CGRectMake(0, 0, 320, 110)];
    dayLineView.aColor=[UIColor orangeColor];
    dayLineView.linecolor=[UIColor redColor];

    
    NSMutableArray* dayPointArray=[NSMutableArray array];
    for (int i=0; i < [weatherData.dayTempArray count]; i++) {
        CGPoint point = CGPointMake(30+i*(300-40)/([weatherData.dayTempArray count]-1), 55 + ([[weatherData.dayTempArray objectAtIndex:0] floatValue] -[[weatherData.dayTempArray objectAtIndex:i] floatValue])*50/max);//50/max是放大系数
        
        [dayPointArray addObject:[NSValue valueWithCGPoint:point]];
    }
    [dayLineView setPointArray:dayPointArray withPointImageName:@"node_day" withTempArray:weatherData.dayTempArray];
    
    YZLineDrawingView* nightLineView=[[YZLineDrawingView alloc]initWithFrame:CGRectMake(0, 110, 320, 110)];
    nightLineView.aColor=[UIColor colorWithRed:0.1 green:0.9 blue:1 alpha:1];
    nightLineView.linecolor=[UIColor whiteColor];
    NSMutableArray* nightPointArray=[NSMutableArray array];
    for (int i=0; i<weatherData.nightTempArray.count; ++i) {
        CGPoint point = CGPointMake(30+i*(300-40)/([weatherData.nightTempArray count]-1), 55 + ([[weatherData.nightTempArray objectAtIndex:0] floatValue] -[[weatherData.nightTempArray objectAtIndex:i] floatValue])*50/max);//9是放大系数
        
        [nightPointArray addObject:[NSValue valueWithCGPoint:point]];
    }
    [nightLineView setPointArray:nightPointArray withPointImageName:@"node_night" withTempArray:weatherData.nightTempArray];
    [fifthView addSubview:dayLineView];
    [fifthView addSubview:nightLineView];
    
    [myView addSubview:backGroundImage];
    [myView addSubview:firstLineView];
    [myView addSubview:secondLineView];
    [myView addSubview:thirdLineView];
    [myView addSubview:forthLineView];
    [myView addSubview:fifthView];
    [myScrollView addSubview:myView];
    myScrollView.contentSize=CGSizeMake(320*(page+1), 480);
    [cityNameArray addObject:weatherData.cityName];
}

-(void)goBack{
//    for (UIView* sonView in firstView.subviews) {
//        [sonView removeFromSuperview];
//    }
    [self.myDelegate toPresentView];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)acquairDate{
    dateArray=[NSMutableArray array];
    weekArray=[NSArray array];
    NSDate* myDate=[NSDate date];
    NSDateFormatter* dateFormatter=[[NSDateFormatter alloc]init];
    dateFormatter.dateFormat=@"YYYY";
    int year=[[dateFormatter stringFromDate:myDate] intValue];
    dateFormatter.dateFormat=@"MM";
    int month=[[dateFormatter stringFromDate:myDate] intValue];
    dateFormatter.dateFormat=@"dd";
    int day=[[dateFormatter stringFromDate:myDate] intValue];
    for (int i=0; i<5; ++i) {
        int monthCount=[monthpinArray[month-1] intValue];
        if (((year%4==0&&year%100!=0)||(year%400==0))&&(month==2)){
            monthCount=29;
        }
        if (day>monthCount) {
            day-=monthCount;
            if (++month>12) {
                month=1;
            }
        }
        NSString* date=[NSString stringWithFormat:@"%02d/%02d",day,month];
        day++;
        [dateArray addObject:date];
    }
    dateFormatter.dateFormat=@"e";
    NSString* week3=weekCountArray[([[dateFormatter stringFromDate:myDate] intValue]-1+2)%7];
    NSString* week4=weekCountArray[([[dateFormatter stringFromDate:myDate] intValue]-1+3)%7];
    NSString* week5=weekCountArray[([[dateFormatter stringFromDate:myDate] intValue]-1+4)%7];
    weekArray=@[@"今天",@"明天",week3,week4,week5];
}

@end
