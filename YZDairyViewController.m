//
//  YZDairyViewController.m
//  dateWork
//
//  Created by mac on 14-1-3.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "YZDairyViewController.h"
#import "YZLunarCalendar.h"
@interface YZDairyViewController (){
    YZDate date;
    YZDate lunarDate;
}

@end

@implementation YZDairyViewController{
    NSArray* weekArray;
    YZLunarCalendar* myLunar;
    UIView* ImputView;
    UITextField* myTextField;
    UIButton* leftButton;
    UIButton* cancelButton;
    UIButton* clickButton;
}


-(id)initWithDate:(YZDate)myDate{
    self=[super init];
    if (self) {
        date=myDate;
    }
    return self;
}

- (void)viewDidLoad
{
    weekArray=@[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    myLunar=[[YZLunarCalendar alloc]init];
    lunarDate=[myLunar solar_to_lunar:date];
    [super viewDidLoad];
    [self addNavigationBar];
    [self addFunctionView];
    [self addTextField];
    [self addImputView];
    [self onKeyboardShow:nil];

    

	self.view.backgroundColor=[UIColor whiteColor];
    UITapGestureRecognizer* down=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onViewTap:)];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onKeyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onKeyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    [self.view addGestureRecognizer:down];
}

- (void)onKeyboardShow:(id)sender{
    NSNotification* notification=sender;
    NSDictionary* dic=[notification userInfo];
    CGRect rect;
    NSValue* rectValue=[dic objectForKey:UIKeyboardFrameEndUserInfoKey];
    [rectValue getValue:&rect];
    [UIView animateWithDuration:0.25 animations:^{
        ImputView.frame=CGRectMake(240, 445-rect.size.height, 80, 35);
    }];
}

- (void)onKeyboardHide:(id)sender{
    [UIView animateWithDuration:0.25 animations:^{
        ImputView.frame=CGRectMake(240, 445, 80, 35);
    }];
}

-(void)onViewTap:(id)sender{
    if (myTextField.text.length>0) {
        leftButton.hidden=YES;
        cancelButton.hidden=NO;
        clickButton.hidden=NO;
    }else{
        leftButton.hidden=NO;
        cancelButton.hidden=YES;
        clickButton.hidden=YES;
    }
    [myTextField resignFirstResponder];
}


-(void)addNavigationBar{
    UIView* navigationBarView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    UIImageView* navBackground=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    navBackground.image=[UIImage imageNamed:@"tileScrollBack_320_110"];
    
    UILabel* titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(140, 15, 40, 30)];
    titleLabel.text=@"新建";
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    
    leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame=CGRectMake(5, 8, 40, 40);
    [leftButton setImage:[UIImage imageNamed:@"back_iphone5.png"] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"button_selected.9.png"] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    
    cancelButton=[UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame=CGRectMake(5, 10, 40, 40);
    [cancelButton setImage:[UIImage imageNamed:@"comments_input_cancel"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.hidden=YES;
    
    clickButton=[UIButton buttonWithType:UIButtonTypeCustom];
    clickButton.frame=CGRectMake(275, 10, 40, 40);
    [clickButton setImage:[UIImage imageNamed:@"comments_input_ok"] forState:UIControlStateNormal];
    clickButton.hidden=YES;
    
    [navigationBarView addSubview:navBackground];
    [navigationBarView addSubview:titleLabel];
    [navigationBarView addSubview:leftButton];
    [navigationBarView addSubview:cancelButton];
    [navigationBarView addSubview:clickButton];
    [self.view addSubview:navigationBarView];
}

-(void)goBack:(id)sender{
    [self.mydelegate toPresentView];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addFunctionView{
    UIView* functionView=[[UIView alloc]initWithFrame:CGRectMake(0, 50, 320, 55)];
    UIButton* timeButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [timeButton setBackgroundImage:[UIImage imageNamed:@"hall_btn_bg"] forState:UIControlStateNormal];
    timeButton.frame=CGRectMake(5, 5, 265, 45);
    UILabel* upTimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 140, 20)];
    upTimeLabel.font=[UIFont systemFontOfSize:16];
    upTimeLabel.text=[NSString stringWithFormat:@"%d-%02d-%02d 全天",date.year,date.month,date.day];
    
    UILabel* downTimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 22, 120, 20)];
    downTimeLabel.font=[UIFont systemFontOfSize:14];
    downTimeLabel.textColor=[UIColor grayColor];
    downTimeLabel.text=[NSString stringWithFormat:@"%@ %@%@",weekArray[date.week-1],[myLunar getMoonMonthStringWithNSInteger:lunarDate.month],[myLunar getMoonDayStringWithNSInteger:lunarDate.day]];
    [timeButton addSubview:upTimeLabel];
    [timeButton addSubview:downTimeLabel];
    
    UIButton* optionButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    optionButton.frame=CGRectMake(275, 5, 35, 45);
    [optionButton setBackgroundImage:[UIImage imageNamed:@"hall_btn_bg"] forState:UIControlStateNormal];
    UIImageView* optionImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_option"]];
    optionImageView.frame=CGRectMake(10, 15, 15, 15);
    [optionButton addSubview:optionImageView];
    
    [functionView addSubview:timeButton];
    [functionView addSubview:optionButton];
    [self.view addSubview:functionView];
}

-(void)addTextField{
    myTextField=[[UITextField alloc]initWithFrame:CGRectMake(10, 105, 300, 40)];
    myTextField.placeholder=@"请输入内容...";
    myTextField.selected=YES;

    
    [self.view addSubview:myTextField];
}

-(void)addImputView{
    ImputView=[[UIView alloc]initWithFrame:CGRectMake(240, 445, 80, 35)];
    ImputView.backgroundColor=[UIColor clearColor];
    UIButton* photoButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [photoButton setImage:[UIImage imageNamed:@"edit_theme_bg_btn"] forState:UIControlStateNormal];
    photoButton.frame=CGRectMake(0, 0, 30, 30);
    
    UIButton* microButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [microButton setImage:[UIImage imageNamed:@"micro_phone_icon"] forState:UIControlStateNormal];
    microButton.frame=CGRectMake(40, -5, 40, 40);
    
    [ImputView addSubview:photoButton];
    [ImputView addSubview:microButton];
    [self.view addSubview:ImputView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
