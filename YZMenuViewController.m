//
//  YZMenuViewController.m
//  dateWork
//
//  Created by 黄桂源 on 14-1-8.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "YZMenuViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface YZMenuViewController ()

@end

@implementation YZMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView* backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    backgroundView.alpha=0.3;
    backgroundView.backgroundColor=[UIColor grayColor];
    [self.view addSubview:backgroundView];
    [self addNavigationBar];
    [self addButtons];
    


    
    self.view.backgroundColor=[UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addNavigationBar{
    UIView* navigationBarView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    UIImageView* navBackground=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    navBackground.image=[UIImage imageNamed:@"tileScrollBack_320_110"];
    
    UILabel* titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(140, 15, 40, 30)];
    titleLabel.text=@"菜单";
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    
    UIButton* leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame=CGRectMake(5, 8, 40, 40);
    [leftButton setImage:[UIImage imageNamed:@"back_iphone5.png"] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"button_selected.9.png"] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame=CGRectMake(280, 15, 30, 30);
    [rightButton setImage:[UIImage imageNamed:@"hall_list_icon_sync"] forState:UIControlStateNormal];

    [navigationBarView addSubview:navBackground];
    [navigationBarView addSubview:titleLabel];
    [navigationBarView addSubview:leftButton];
    [navigationBarView addSubview:rightButton];
    [self.view addSubview:navigationBarView];
}

-(void)addButtons{
    UIView* buttonView=[[UIView alloc]initWithFrame:CGRectMake(0, 50, 320, 300)];
    buttonView.backgroundColor=[UIColor clearColor];
    
    UIButton* hallButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    hallButton.layer.cornerRadius=5;
    hallButton.frame=CGRectMake(5, 5, 100, 90);
    [hallButton setBackgroundImage:[UIImage imageNamed:@"hall_btn_bg"] forState:UIControlStateNormal];
    UIImageView* hallImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"hall_list_icon_public"]];
    hallImageView.frame=CGRectMake(30, 8, 40, 40);
    UILabel* hallLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 55, 80, 20)];
    hallLabel.text=@"日历广场";
    hallLabel.font=[UIFont systemFontOfSize:15];
    hallLabel.textAlignment=NSTextAlignmentCenter;
    UIImageView* flagImage=[[UIImageView alloc]initWithFrame:CGRectMake(20, 75, 60, 5)];
    flagImage.image=[UIImage imageNamed:@"hall_list_icon_public_flag"];
    [hallButton addSubview:hallLabel];
    [hallButton addSubview:hallImageView];
    [hallButton addSubview:flagImage];
    [hallButton setBackgroundColor:[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1]];
    
    UIButton* createButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    createButton.layer.cornerRadius=5;
    createButton.frame=CGRectMake(110, 5, 100, 90);
    [createButton setBackgroundImage:[UIImage imageNamed:@"hall_btn_bg"] forState:UIControlStateNormal];
    UIImageView* createImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"hall_list_icon_create"]];
    createImageView.frame=CGRectMake(30, 8, 40, 40);
    UILabel* createLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 55, 80, 20)];
    createLabel.text=@"创建群组";
    createLabel.font=[UIFont systemFontOfSize:15];
    createLabel.textAlignment=NSTextAlignmentCenter;
    [createButton addSubview:createLabel];
    [createButton addSubview:createImageView];
    [createButton setBackgroundColor:[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1]];
    
    UIButton* manageButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    manageButton.frame=CGRectMake(215, 5, 100, 90);
    manageButton.layer.cornerRadius=5;
    [manageButton setBackgroundImage:[UIImage imageNamed:@"hall_btn_bg"] forState:UIControlStateNormal];
    UIImageView* manageImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"hall_list_icon_calendarmanager"]];
    manageImageView.frame=CGRectMake(30, 8, 40, 40);
    UILabel* manageLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 55, 80, 20)];
    manageLabel.text=@"日历管理";
    manageLabel.font=[UIFont systemFontOfSize:15];
    manageLabel.textAlignment=NSTextAlignmentCenter;
    [manageButton addSubview:manageLabel];
    [manageButton addSubview:manageImageView];
    [manageButton setBackgroundColor:[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1]];
    
    UIButton* searchButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    searchButton.frame=CGRectMake(5, 100, 100, 90);
    searchButton.layer.cornerRadius=5;
    [searchButton setBackgroundImage:[UIImage imageNamed:@"hall_btn_bg"] forState:UIControlStateNormal];
    UIImageView* searchImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"hall_list_icon_search"]];
    searchImageView.frame=CGRectMake(30, 8, 40, 40);
    UILabel* searchLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 55, 80, 20)];
    searchLabel.text=@"搜索";
    searchLabel.font=[UIFont systemFontOfSize:15];
    searchLabel.textAlignment=NSTextAlignmentCenter;
    [searchButton addSubview:searchLabel];
    [searchButton addSubview:searchImageView];
    [searchButton setBackgroundColor:[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1]];
    
    UIButton* messageButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    messageButton.frame=CGRectMake(110, 100, 100, 90);
    messageButton.layer.cornerRadius=5;
    [messageButton setBackgroundImage:[UIImage imageNamed:@"hall_btn_bg"] forState:UIControlStateNormal];
    UIImageView* messageImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"hall_list_icon_message"]];
    messageImageView.frame=CGRectMake(30, 8, 40, 40);
    UILabel* messageLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 55, 80, 20)];
    messageLabel.text=@"消息";
    messageLabel.font=[UIFont systemFontOfSize:15];
    messageLabel.textAlignment=NSTextAlignmentCenter;
    [messageButton addSubview:messageLabel];
    [messageButton addSubview:messageImageView];
    [messageButton setBackgroundColor:[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1]];
    
    UIButton* setupButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    setupButton.frame=CGRectMake(215, 100, 100, 90);
    setupButton.layer.cornerRadius=5;
    [setupButton setBackgroundImage:[UIImage imageNamed:@"hall_btn_bg"] forState:UIControlStateNormal];
    UIImageView* setupImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"hall_list_icon_setting"]];
    setupImageView.frame=CGRectMake(30, 8, 40, 40);
    UILabel* setupLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 55, 80, 20)];
    setupLabel.text=@"设置";
    setupLabel.font=[UIFont systemFontOfSize:15];
    setupLabel.textAlignment=NSTextAlignmentCenter;
    [setupButton addSubview:setupLabel];
    [setupButton addSubview:setupImageView];
    [setupButton setBackgroundColor:[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1]];
    
    UIButton* accountButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    accountButton.frame=CGRectMake(5, 195, 100, 90);
    accountButton.layer.cornerRadius=5;
    [accountButton setBackgroundImage:[UIImage imageNamed:@"hall_btn_bg"] forState:UIControlStateNormal];
    UIImageView* accountImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"hall_list_icon_account"]];
    accountImageView.frame=CGRectMake(30, 8, 40, 40);
    UILabel* accountLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 55, 80, 20)];
    accountLabel.text=@"账号";
    accountLabel.font=[UIFont systemFontOfSize:15];
    accountLabel.textAlignment=NSTextAlignmentCenter;
    [accountButton addSubview:accountLabel];
    [accountButton addSubview:accountImageView];
    [accountButton setBackgroundColor:[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1]];
    
    UIButton* helpButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    helpButton.frame=CGRectMake(110, 195, 100, 90);
    helpButton.layer.cornerRadius=5;
    [helpButton setBackgroundImage:[UIImage imageNamed:@"hall_btn_bg"] forState:UIControlStateNormal];
    UIImageView* helpImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"hall_list_icon_help"]];
    helpImageView.frame=CGRectMake(30, 8, 40, 40);
    UILabel* helpLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 55, 80, 20)];
    helpLabel.text=@"帮助";
    helpLabel.font=[UIFont systemFontOfSize:15];
    helpLabel.textAlignment=NSTextAlignmentCenter;
    [helpButton addSubview:helpLabel];
    [helpButton addSubview:helpImageView];
    [helpButton setBackgroundColor:[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1]];
    
    [buttonView addSubview:hallButton];
    [buttonView addSubview:createButton];
    [buttonView addSubview:manageButton];
    [buttonView addSubview:searchButton];
    [buttonView addSubview:messageButton];
    [buttonView addSubview:setupButton];
    [buttonView addSubview:accountButton];
    [buttonView addSubview:helpButton];
    [self.view addSubview:buttonView];
}

-(void)goBack{
    [self.myDelegate toPresentView];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
