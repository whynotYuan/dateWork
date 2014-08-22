//
//  YZSafePeriodViewController.m
//  dateWork
//
//  Created by 黄桂源 on 14-1-13.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "YZSafePeriodViewController.h"
#import "YZSafePeriodModel.h"

@interface YZSafePeriodViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>

@end

@implementation YZSafePeriodViewController{
    YZSafePeriodModel* mySafePeriodModel;
    
    UIView* safeSonView;
    UIView* dangerousSonView;
    UIView* menstruationSonView;
    UIView* ovulationSonView;
    
    UIButton* safeRadioButton[3];
    UIButton* dangerousRadioButton[5];
    UIButton* menstruationRadioButton[3];
    UIButton* ovulationRadionButton[3];
    
    UIView* periodView;
    UILabel* periodLabel;
    NSString* periodBeforeString;
    NSMutableArray* periodDataArray;
    
    UIView* durationView;
    UILabel* durationLabel;
    NSString* durationBeforeString;
    NSMutableArray* durationDataArray;
    
    UIView* lastTimeView;
    UILabel* lastTimeLabel;
    UIDatePicker* myLastDatePicker;
    
    UIImageView* safeImageView;
    UIImageView* dangerousImageView;
    UIImageView* menstruationImageView;
    UIImageView* ovulationImageView;
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
    mySafePeriodModel=[[YZSafePeriodModel alloc]init];
    mySafePeriodModel.lastTimeYear=2013;
    mySafePeriodModel.lastTimeMonth=12;
    mySafePeriodModel.lastTimeDay=21;
    
    mySafePeriodModel.periodDate=35;
    mySafePeriodModel.durationDate=7;
    
    mySafePeriodModel.SafePicNum=3;
    mySafePeriodModel.DangerousNum=2;
    mySafePeriodModel.menstruationPicNum=1;
    mySafePeriodModel.ovulationPicNum=3;
    
    [super viewDidLoad];
	[self addNavigationBar];
    [self addBackgroundView];
    [self addCalculate];
    [self addChooseView];
    [self addClickView];
    
    [self addPeriodPickerView];
    [self addDurationPickerView];
    [self addLastTimePickerView];
    
    [self addSonView];
    
}


-(void)addBackgroundView{
    UIImageView* backgroundView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 60, 320, 420)];
    backgroundView.image=[UIImage imageNamed:@"sp_main_bg.jpg"];
    
    [self.view addSubview:backgroundView];
}

-(void)addNavigationBar{
    UIView* navigationBarView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 60)];
    UIImageView* navBackground=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 60)];
    navBackground.image=[UIImage imageNamed:@"safe_period_header_bg.jpg"];
    
    UILabel* titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(140, 10, 40, 30)];
    titleLabel.text=@"计算";
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    
    UIButton* leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame=CGRectMake(5, 5, 40, 40);
    [leftButton setImage:[UIImage imageNamed:@"sp_back_btn"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [navigationBarView addSubview:navBackground];
    [navigationBarView addSubview:titleLabel];
    [navigationBarView addSubview:leftButton];
    [self.view addSubview:navigationBarView];
}

-(void)addCalculate{
    UIView* calculateView=[[UIView alloc]initWithFrame:CGRectMake(0, 75, 320, 140)];
    UIImageView* backgroundView=[[UIImageView alloc]initWithFrame:CGRectMake(35, 0, 250, 140)];
    backgroundView.image=[UIImage imageNamed:@"safe_period_setting_bg.jpg"];
    backgroundView.userInteractionEnabled=YES;
    
    UILabel* PeriodLineLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 20, 90, 20)];
    PeriodLineLabel.text=@"最短月经周期";
    PeriodLineLabel.font=[UIFont boldSystemFontOfSize:15];
    PeriodLineLabel.textColor=[UIColor colorWithRed:1 green:0.45 blue:0.5  alpha:1];
    UIButton* PeriodButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [PeriodButton setImage:[UIImage imageNamed:@"sp_special_btn_s"] forState:UIControlStateNormal];
    PeriodButton.frame=CGRectMake(120, 15, 80, 30);
    [PeriodButton addTarget:self action:@selector(periodViewAppear) forControlEvents:UIControlEventTouchUpInside];
    periodLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    periodLabel.text=[NSString stringWithFormat:@"%d",mySafePeriodModel.periodDate];
    periodLabel.textAlignment=NSTextAlignmentCenter;
    periodLabel.textColor=[UIColor colorWithRed:0.1 green:0.9 blue:1 alpha:1];
    [PeriodButton addSubview:periodLabel];
    
    UILabel* PeriodDayLabel=[[UILabel alloc]initWithFrame:CGRectMake(208, 20, 20, 20)];
    PeriodDayLabel.text=@"天";
    PeriodDayLabel.font=[UIFont boldSystemFontOfSize:15];
    PeriodDayLabel.textColor=[UIColor colorWithRed:1 green:0.45 blue:0.5  alpha:1];
    
    UILabel* durationLineLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 65, 90, 20)];
    durationLineLabel.text=@"平均行经日期";
    durationLineLabel.font=[UIFont boldSystemFontOfSize:15];
    durationLineLabel.textColor=[UIColor colorWithRed:1 green:0.45 blue:0.5  alpha:1];
    UIButton* durationButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [durationButton addTarget:self action:@selector(durationViewAppear) forControlEvents:UIControlEventTouchUpInside];
    [durationButton setImage:[UIImage imageNamed:@"sp_special_btn_s"] forState:UIControlStateNormal];
    durationButton.frame=CGRectMake(120, 60, 80, 30);
    
    durationLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    durationLabel.text=[NSString stringWithFormat:@"%d",mySafePeriodModel.durationDate];
    durationLabel.textAlignment=NSTextAlignmentCenter;
    durationLabel.textColor=[UIColor colorWithRed:0.1 green:0.9 blue:1 alpha:1];
    [durationButton addSubview:durationLabel];
    
    UILabel* durationDayLabel=[[UILabel alloc]initWithFrame:CGRectMake(208, 65, 20, 20)];
    durationDayLabel.text=@"天";
    durationDayLabel.font=[UIFont boldSystemFontOfSize:15];
    durationDayLabel.textColor=[UIColor colorWithRed:1 green:0.45 blue:0.5  alpha:1];
    
    UILabel* lastTimeThatLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 105, 90, 20)];
    lastTimeThatLabel.text=@"上次月经日期";
    lastTimeThatLabel.font=[UIFont boldSystemFontOfSize:15];
    lastTimeThatLabel.textColor=[UIColor colorWithRed:1 green:0.45 blue:0.5  alpha:1];
    UIButton* lastTimeButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [lastTimeButton setImage:[UIImage imageNamed:@"sp_special_btn_l"] forState:UIControlStateNormal];
    lastTimeButton.frame=CGRectMake(120, 100, 115, 30);
    [lastTimeButton addTarget:self action:@selector(lastTimeViewAppear) forControlEvents:UIControlEventTouchUpInside];
    lastTimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 115, 30)];

    lastTimeLabel.textAlignment=NSTextAlignmentCenter;
    lastTimeLabel.text=[NSString stringWithFormat:@"%d-%02d-%02d",mySafePeriodModel.lastTimeYear,mySafePeriodModel.lastTimeMonth,mySafePeriodModel.lastTimeDay];
    lastTimeLabel.textColor=[UIColor colorWithRed:0.1 green:0.9 blue:1 alpha:1];
    [lastTimeButton addSubview:lastTimeLabel];
    
    
    calculateView.backgroundColor=[UIColor clearColor];
    [backgroundView addSubview:PeriodLineLabel];
    [backgroundView addSubview:PeriodButton];
    [backgroundView addSubview:PeriodDayLabel];
    [backgroundView addSubview:durationLineLabel];
    [backgroundView addSubview:durationButton];
    [backgroundView addSubview:durationDayLabel];
    [backgroundView addSubview:lastTimeThatLabel];
    [backgroundView addSubview:lastTimeButton];
    
    [calculateView addSubview:backgroundView];
    [self.view addSubview:calculateView];
}

-(void)addChooseView{
    UIView* chooseView=[[UIView alloc]initWithFrame:CGRectMake(0, 220, 320, 110)];
    UIImageView* backgroundView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 0, 290, 110)];
    backgroundView.image=[UIImage imageNamed:@"sp_note_bg"];
    backgroundView.userInteractionEnabled=YES;
 
    
    
    UIButton* safeButton=[UIButton buttonWithType:UIButtonTypeCustom];
    safeButton.frame=CGRectMake(70, 34, 75, 25);
    safeButton.tag=1;
    [safeButton addTarget:self action:@selector(showView:) forControlEvents:UIControlEventTouchUpInside];
    safeImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    safeImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"safeperiod_anquan_table%d",mySafePeriodModel.SafePicNum]];
    NSLog(@"%d",mySafePeriodModel.SafePicNum);
    [safeButton addSubview:safeImageView];
    UILabel* safeLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 1, 45, 20)];
    safeLabel.text=@"安全期";
    safeLabel.textColor=[UIColor grayColor];
    safeLabel.font=[UIFont boldSystemFontOfSize:14];
    [safeButton addSubview:safeLabel];
    
    
    
    UIButton* dangerousButton=[UIButton buttonWithType:UIButtonTypeCustom];
    dangerousButton.frame=CGRectMake(145, 34, 75, 25);
    dangerousButton.tag=2;
    [dangerousButton addTarget:self action:@selector(showView:) forControlEvents:UIControlEventTouchUpInside];
    dangerousImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    dangerousImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"safeperiod_weixian_table%d",mySafePeriodModel.DangerousNum]];
    [dangerousButton addSubview:dangerousImageView];
    UILabel* dangerousLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 1, 45, 20)];
    dangerousLabel.text=@"危险期";
    dangerousLabel.textColor=[UIColor grayColor];
    dangerousLabel.font=[UIFont boldSystemFontOfSize:14];
    [dangerousButton addSubview:dangerousLabel];
    
    
    UIButton* menstruationButton=[UIButton buttonWithType:UIButtonTypeCustom];
    menstruationButton.frame=CGRectMake(70, 59, 75, 25);
    menstruationButton.tag=3;
    [menstruationButton addTarget:self action:@selector(showView:) forControlEvents:UIControlEventTouchUpInside];
    menstruationImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    menstruationImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"safeperiod_yuejing_table%d",mySafePeriodModel.menstruationPicNum]];
    [menstruationButton addSubview:menstruationImageView];
    UILabel* menstruationLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 1, 45, 20)];
    menstruationLabel.text=@"月经期";
    menstruationLabel.textColor=[UIColor grayColor];
    menstruationLabel.font=[UIFont boldSystemFontOfSize:14];
    [menstruationButton addSubview:menstruationLabel];
    
    
    UIButton* ovulationButton=[UIButton buttonWithType:UIButtonTypeCustom];
    ovulationButton.frame=CGRectMake(145, 59, 75, 25);
    ovulationButton.tag=4;
    [ovulationButton addTarget:self action:@selector(showView:) forControlEvents:UIControlEventTouchUpInside];
    ovulationImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    ovulationImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"safeperiod_pailan_table%d",mySafePeriodModel.ovulationPicNum]];
    [ovulationButton addSubview:ovulationImageView];
    UILabel* ovulationLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 1, 45, 20)];
    ovulationLabel.text=@"排卵期";
    ovulationLabel.textColor=[UIColor grayColor];
    ovulationLabel.font=[UIFont boldSystemFontOfSize:14];
    [ovulationButton addSubview:ovulationLabel];
    
    
    [backgroundView addSubview:safeButton];
    [backgroundView addSubview:dangerousButton];
    [backgroundView addSubview:menstruationButton];
    [backgroundView addSubview:ovulationButton];
    [chooseView addSubview:backgroundView];
    [self.view addSubview:chooseView];
}

//加入ChooseView的几个弹出界面

-(void)addSonView{
    [self addSafeSonView];
    [self addDangerousSonView];
    [self addMenstruationSonView];
    [self addOvulationSonView];
}

-(void)addSafeSonView{
    safeSonView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    
    UIView* backGroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    backGroundView.backgroundColor=[UIColor blackColor];
    backGroundView.alpha=0.5;
    UITapGestureRecognizer* SafeSonGR=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideSafeSonView)];
    [backGroundView addGestureRecognizer:SafeSonGR];

    
    UIImageView* mainPic=[[UIImageView alloc]initWithFrame:CGRectMake(34, 200, 252, 80)];
    mainPic.image=[UIImage imageNamed:@"sp_icon_selection_bg.png"];
    mainPic.userInteractionEnabled=YES;
    
    for (int i=0; i<3; ++i) {
        UIImageView* safeImage=[[UIImageView alloc]initWithFrame:CGRectMake(40.5*(i+1)+i*30, 15, 30, 30)];
        safeImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"safeperiod_anquan_table%d",i+1]];
        
        safeRadioButton[i]=[UIButton buttonWithType:UIButtonTypeCustom];
        safeRadioButton[i].frame=CGRectMake(40.5*(i+1)+i*30, 45, 30, 30);
        [safeRadioButton[i] setImage:[UIImage imageNamed:@"radio_unselected.png"] forState:UIControlStateNormal];
        [safeRadioButton[i] setImage:[UIImage imageNamed:@"radio_selected.png"] forState:UIControlStateSelected];
        safeRadioButton[i].tag=i;
        [safeRadioButton[i] addTarget:self action:@selector(safeSonSelected:) forControlEvents:UIControlEventTouchDown];
        [mainPic addSubview:safeImage];
        [mainPic addSubview:safeRadioButton[i]];
    }
    safeRadioButton[mySafePeriodModel.SafePicNum-1].selected=YES;
    
    safeSonView.hidden=YES;
    [safeSonView addSubview:backGroundView];
    [safeSonView addSubview:mainPic];
    [self.view addSubview:safeSonView];
}

-(void)addDangerousSonView{
    dangerousSonView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    
    UIView* backGroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    backGroundView.backgroundColor=[UIColor blackColor];
    backGroundView.alpha=0.5;
    UITapGestureRecognizer* dangerousSonGR=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideDangerousSonView)];
    [backGroundView addGestureRecognizer:dangerousSonGR];
    
    
    UIImageView* mainPic=[[UIImageView alloc]initWithFrame:CGRectMake(34, 200, 252, 80)];
    mainPic.image=[UIImage imageNamed:@"sp_icon_selection_bg.png"];
    mainPic.userInteractionEnabled=YES;
    
    for (int i=0; i<5; ++i) {
        UIImageView* dangerousImage=[[UIImageView alloc]initWithFrame:CGRectMake(17*(i+1)+30*i, 15, 30, 30)];
        dangerousImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"safeperiod_weixian_table%d",i+1]];
        
        dangerousRadioButton[i]=[UIButton buttonWithType:UIButtonTypeCustom];
        dangerousRadioButton[i].frame=CGRectMake(17*(i+1)+30*i, 45, 30, 30);
        [dangerousRadioButton[i] setImage:[UIImage imageNamed:@"radio_unselected.png"] forState:UIControlStateNormal];
        [dangerousRadioButton[i] setImage:[UIImage imageNamed:@"radio_selected.png"] forState:UIControlStateSelected];
        dangerousRadioButton[i].tag=i;
        [dangerousRadioButton[i] addTarget:self action:@selector(dangerousSonSelected:) forControlEvents:UIControlEventTouchDown];
        
        [mainPic addSubview:dangerousImage];
        [mainPic addSubview:dangerousRadioButton[i]];
    }
    
    dangerousSonView.hidden=YES;
    [dangerousSonView addSubview:backGroundView];
    [dangerousSonView addSubview:mainPic];
    [self.view addSubview:dangerousSonView];
}

-(void)addMenstruationSonView{
    menstruationSonView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    
    UIView* backGroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    backGroundView.backgroundColor=[UIColor blackColor];
    backGroundView.alpha=0.5;
    UITapGestureRecognizer* menstruationSonGR=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideMenstruationSonView)];
    [backGroundView addGestureRecognizer:menstruationSonGR];
    
    
    UIImageView* mainPic=[[UIImageView alloc]initWithFrame:CGRectMake(34, 200, 252, 80)];
    mainPic.image=[UIImage imageNamed:@"sp_icon_selection_bg.png"];
    mainPic.userInteractionEnabled=YES;
    
    for (int i=0; i<3; ++i) {
        UIImageView* menstruationImage=[[UIImageView alloc]initWithFrame:CGRectMake(40.5*(i+1)+i*30, 15, 30, 30)];
        menstruationImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"safeperiod_yuejing_table%d",i+1]];
        
        menstruationRadioButton[i]=[UIButton buttonWithType:UIButtonTypeCustom];
        menstruationRadioButton[i].frame=CGRectMake(40.5*(i+1)+i*30, 45, 30, 30);
        [menstruationRadioButton[i] setImage:[UIImage imageNamed:@"radio_unselected.png"] forState:UIControlStateNormal];
        [menstruationRadioButton[i] setImage:[UIImage imageNamed:@"radio_selected.png"] forState:UIControlStateSelected];
        menstruationRadioButton[i].tag=i;
        [menstruationRadioButton[i] addTarget:self action:@selector(menstruationSonSelected:) forControlEvents:UIControlEventTouchDown];
        [mainPic addSubview:menstruationImage];
        [mainPic addSubview:menstruationRadioButton[i]];
    }
    menstruationRadioButton[mySafePeriodModel.menstruationPicNum-1].selected=YES;
    
    menstruationSonView.hidden=YES;
    [menstruationSonView addSubview:backGroundView];
    [menstruationSonView addSubview:mainPic];
    [self.view addSubview:menstruationSonView];
}

-(void)addOvulationSonView{
    ovulationSonView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    
    UIView* backGroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    backGroundView.backgroundColor=[UIColor blackColor];
    backGroundView.alpha=0.5;
    UITapGestureRecognizer* ovulationSonGR=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideOvulationSonView)];
    [backGroundView addGestureRecognizer:ovulationSonGR];
    
    
    UIImageView* mainPic=[[UIImageView alloc]initWithFrame:CGRectMake(34, 200, 252, 80)];
    mainPic.image=[UIImage imageNamed:@"sp_icon_selection_bg.png"];
    mainPic.userInteractionEnabled=YES;
    
    for (int i=0; i<3; ++i) {
        UIImageView* ovulationImage=[[UIImageView alloc]initWithFrame:CGRectMake(40.5*(i+1)+i*30, 15, 30, 30)];
        ovulationImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"safeperiod_pailan_table%d",i+1]];
        
        ovulationRadionButton[i]=[UIButton buttonWithType:UIButtonTypeCustom];
        ovulationRadionButton[i].frame=CGRectMake(40.5*(i+1)+i*30, 45, 30, 30);
        [ovulationRadionButton[i] setImage:[UIImage imageNamed:@"radio_unselected.png"] forState:UIControlStateNormal];
        [ovulationRadionButton[i] setImage:[UIImage imageNamed:@"radio_selected.png"] forState:UIControlStateSelected];
        ovulationRadionButton[i].tag=i;
        [ovulationRadionButton[i] addTarget:self action:@selector(ovulationSonSelevted:) forControlEvents:UIControlEventTouchDown];
        [mainPic addSubview:ovulationImage];
        [mainPic addSubview:ovulationRadionButton[i]];
    }
    ovulationRadionButton[mySafePeriodModel.ovulationPicNum-1].selected=YES;
    
    ovulationSonView.hidden=YES;
    [ovulationSonView addSubview:backGroundView];
    [ovulationSonView addSubview:mainPic];
    [self.view addSubview:ovulationSonView];
}

-(void)showView:(UIButton*)sender{
    switch (sender.tag) {
        case 1:
            safeSonView.hidden=NO;
            break;
        
        case 2:
            dangerousSonView.hidden=NO;
            break;
            
        case 3:
            menstruationSonView.hidden=NO;
            break;
            
        case 4:
            ovulationSonView.hidden=NO;
            break;
            
        default:
            break;
    }
}

-(void)hideSafeSonView{
    safeSonView.hidden=YES;
}

-(void)hideDangerousSonView{
    dangerousSonView.hidden=YES;
}

-(void)hideMenstruationSonView{
    menstruationSonView.hidden=YES;
}

-(void)hideOvulationSonView{
    ovulationSonView.hidden=YES;
}

-(void)safeSonSelected:(UIButton*)sender{
    for (int i=0; i<3; ++i) {
        safeRadioButton[i].selected=NO;
    }
    safeRadioButton[sender.tag].selected=YES;
    mySafePeriodModel.SafePicNum=sender.tag+1;
    safeImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"safeperiod_anquan_table%d",mySafePeriodModel.SafePicNum]];
    safeSonView.hidden=YES;
}

-(void)dangerousSonSelected:(UIButton*)sender{
    for (int i=0; i<5; ++i) {
        dangerousRadioButton[i].selected=NO;
    }
    dangerousRadioButton[sender.tag].selected=YES;
    mySafePeriodModel.DangerousNum=sender.tag+1;
    dangerousImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"safeperiod_weixian_table%d",mySafePeriodModel.DangerousNum]];
    dangerousSonView.hidden=YES;
}

-(void)menstruationSonSelected:(UIButton*)sender{
    for (int i=0; i<3; ++i) {
        menstruationRadioButton[i].selected=NO;
    }
    menstruationRadioButton[sender.tag].selected=YES;
    mySafePeriodModel.menstruationPicNum=sender.tag+1;
    menstruationImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"safeperiod_yuejing_table%d",mySafePeriodModel.menstruationPicNum]];
    menstruationSonView.hidden=YES;
}

-(void)ovulationSonSelevted:(UIButton*)sender{
    for (int i=0; i<3; ++i) {
        ovulationRadionButton[i].selected=NO;
    }
    ovulationRadionButton[sender.tag].selected=YES;
    mySafePeriodModel.ovulationPicNum=sender.tag+1;
    ovulationImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"safeperiod_pailan_table%d",mySafePeriodModel.ovulationPicNum]];
    ovulationSonView.hidden=YES;
}

//添加确认按钮
-(void)addClickView{
    UIButton* mybutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [mybutton setImage:[UIImage imageNamed:@"sp_search_btn_bg.jpg"] forState:UIControlStateNormal];
    [mybutton setImage:[UIImage imageNamed:@"sp_search_btn_bg_hl.jpg"] forState:UIControlStateHighlighted];
    mybutton.frame=CGRectMake(35, 355, 250, 40);
    [mybutton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    UILabel* clickLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 5, 50, 30)];
    clickLabel.textAlignment=NSTextAlignmentCenter;
    clickLabel.textColor=[UIColor whiteColor];
    clickLabel.text=@"确认";
    clickLabel.font=[UIFont boldSystemFontOfSize:19];
    
    [mybutton addSubview:clickLabel];
    [self.view addSubview:mybutton];
}

-(void)addPeriodPickerView{
    periodView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    UIView* backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    backgroundView.backgroundColor=[UIColor grayColor];
    backgroundView.alpha=0.5;
    
    periodDataArray=[NSMutableArray array];
    for (int i=20; i<=40; ++i) {
        NSString* periodString=[NSString stringWithFormat:@"%d天",i];
        [periodDataArray addObject:periodString];
    }
    
    UILabel* dateLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 120, 150, 30)];
    dateLabel.text=@"最短月经周期:";
    dateLabel.textColor=[UIColor colorWithRed:1 green:0.45 blue:0.5  alpha:1];
    dateLabel.font=[UIFont boldSystemFontOfSize:16];
    dateLabel.backgroundColor=[UIColor clearColor];
    UIButton* cancelButton=[UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame=CGRectMake(210, 125, 15, 15);
    [cancelButton setImage:[UIImage imageNamed:@"picker_negative"] forState:UIControlStateNormal];
    cancelButton.tag=1;
    [cancelButton addTarget:self action:@selector(onCancel:) forControlEvents:UIControlEventTouchUpInside];
    UIButton* clickButton=[UIButton buttonWithType:UIButtonTypeCustom];
    clickButton.frame=CGRectMake(255, 120, 20, 20);
    [clickButton setImage:[UIImage imageNamed:@"picker_positive"] forState:UIControlStateNormal];
    clickButton.tag=1;
    [clickButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel* tipsLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, 157, 220, 15)];
    tipsLabel.text=@"正常月经周期为28~30天";
    tipsLabel.textAlignment=NSTextAlignmentCenter;
    tipsLabel.font=[UIFont systemFontOfSize:15];
    tipsLabel.textColor=[UIColor grayColor];
    
    UIPickerView* periodPick=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 160, 320, 160)];
    periodPick.tag=1;
    periodPick.dataSource=self;
    periodPick.delegate=self;
    
    periodView.hidden=YES;
    [periodView addSubview:backgroundView];
    [periodView addSubview:periodPick];
    [periodView addSubview:dateLabel];
    [periodView addSubview:cancelButton];
    [periodView addSubview:clickButton];
    [periodView addSubview:tipsLabel];
    [self.view addSubview:periodView];
}

-(void)addDurationPickerView{
    durationView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    UIView* backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    backgroundView.backgroundColor=[UIColor grayColor];
    backgroundView.alpha=0.5;
    
    durationDataArray=[NSMutableArray array];
    for (int i=3; i<=10; ++i) {
        NSString* durationString=[NSString stringWithFormat:@"%d天",i];
        [durationDataArray addObject:durationString];
    }
    
    UILabel* dateLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 120, 150, 30)];
    dateLabel.text=@"最短月经周期:";
    dateLabel.textColor=[UIColor colorWithRed:1 green:0.45 blue:0.5  alpha:1];
    dateLabel.font=[UIFont boldSystemFontOfSize:16];
    dateLabel.backgroundColor=[UIColor clearColor];
    UIButton* cancelButton=[UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame=CGRectMake(210, 125, 15, 15);
    [cancelButton setImage:[UIImage imageNamed:@"picker_negative"] forState:UIControlStateNormal];
    cancelButton.tag=2;
    [cancelButton addTarget:self action:@selector(onCancel:) forControlEvents:UIControlEventTouchUpInside];
    UIButton* clickButton=[UIButton buttonWithType:UIButtonTypeCustom];
    clickButton.frame=CGRectMake(255, 120, 20, 20);
    [clickButton setImage:[UIImage imageNamed:@"picker_positive"] forState:UIControlStateNormal];
    clickButton.tag=2;
    [clickButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel* tipsLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, 157, 220, 15)];
    tipsLabel.text=@"平均行经日期为3~7天";
    tipsLabel.textAlignment=NSTextAlignmentCenter;
    tipsLabel.font=[UIFont systemFontOfSize:15];
    tipsLabel.textColor=[UIColor grayColor];
    
    UIPickerView* durationPick=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 160, 320, 160)];
    durationPick.tag=2;
    durationPick.dataSource=self;
    durationPick.delegate=self;
    
    durationView.hidden=YES;
    [durationView addSubview:backgroundView];
    [durationView addSubview:durationPick];
    [durationView addSubview:dateLabel];
    [durationView addSubview:cancelButton];
    [durationView addSubview:clickButton];
    [durationView addSubview:tipsLabel];
    [self.view addSubview:durationView];
}

-(void)addLastTimePickerView{
    lastTimeView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    UIView* backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    backgroundView.backgroundColor=[UIColor grayColor];
    backgroundView.alpha=0.5;
    
    UILabel* dateLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 150, 150, 30)];
    dateLabel.text=@"请选择日期:";
    dateLabel.textColor=[UIColor colorWithRed:1 green:0.45 blue:0.5  alpha:1];
    dateLabel.font=[UIFont boldSystemFontOfSize:16];
    dateLabel.backgroundColor=[UIColor clearColor];
    UIButton* cancelButton=[UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame=CGRectMake(210, 155, 15, 15);
    [cancelButton setImage:[UIImage imageNamed:@"picker_negative"] forState:UIControlStateNormal];
    cancelButton.tag=3;
    [cancelButton addTarget:self action:@selector(onCancel:) forControlEvents:UIControlEventTouchUpInside];
    UIButton* clickButton=[UIButton buttonWithType:UIButtonTypeCustom];
    clickButton.frame=CGRectMake(255, 150, 20, 20);
    [clickButton setImage:[UIImage imageNamed:@"picker_positive"] forState:UIControlStateNormal];
    clickButton.tag=3;
    [clickButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    myLastDatePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 160, 320, 160)];
    myLastDatePicker.datePickerMode=UIDatePickerModeDate;
    lastTimeView.hidden=YES;
    [lastTimeView addSubview:backgroundView];
    [lastTimeView addSubview:myLastDatePicker];
    [lastTimeView addSubview:dateLabel];
    [lastTimeView addSubview:cancelButton];
    [lastTimeView addSubview:clickButton];
    [self.view addSubview:lastTimeView];
}



//实现pickView代理
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView.tag==1) {
        return 21;
    }
    return 8;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView.tag==1) {
        return periodDataArray[row];
    }
    return durationDataArray[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (pickerView.tag) {
        case 1:
            periodLabel.text=[NSString stringWithFormat:@"%d",row+20];
            break;
        case 2:
            durationLabel.text=[NSString stringWithFormat:@"%d",row+3];
        default:
            break;
    }
    
}

-(void)lastTimeViewAppear{
    lastTimeView.hidden=NO;
}

-(void)periodViewAppear{
    periodBeforeString=periodLabel.text;
    periodView.hidden=NO;
}

-(void)durationViewAppear{
    durationBeforeString=durationLabel.text;
    durationView.hidden=NO;
}

//pickView按钮
-(void)onCancel:(UIButton*)sender{
    switch (sender.tag) {
        case 1:
            periodLabel.text=periodBeforeString;
            periodView.hidden=YES;
            break;
        case 2:
            durationLabel.text=durationBeforeString;
            durationView.hidden=YES;
            break;
        case 3:
            lastTimeView.hidden=YES;
        default:
            break;
    }

}

-(void)onClick:(UIButton*)sender{
    switch (sender.tag) {
        case 1:
            periodView.hidden=YES;
            mySafePeriodModel.periodDate=[periodLabel.text intValue];
            break;
        case 2:
            durationView.hidden=YES;
            mySafePeriodModel.durationDate=[durationLabel.text intValue];
            break;
        case 3:
            lastTimeView.hidden=YES;
            NSDateFormatter* dateFormatter=[[NSDateFormatter alloc]init];
            dateFormatter.dateFormat=@"yyyy";
            NSString* yearString=[dateFormatter stringFromDate:myLastDatePicker.date];
            mySafePeriodModel.lastTimeYear=[yearString intValue];
            dateFormatter.dateFormat=@"MM";
            NSString* monthString=[dateFormatter stringFromDate:myLastDatePicker.date];
            mySafePeriodModel.lastTimeMonth=[monthString intValue];
            dateFormatter.dateFormat=@"dd";
            NSString* dayString=[dateFormatter stringFromDate:myLastDatePicker.date];
            mySafePeriodModel.lastTimeDay=[dayString intValue];
            lastTimeLabel.text=[NSString stringWithFormat:@"%@-%@-%@",yearString,monthString,dayString];
            break;
            

    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//确定健按钮
-(void)click{
    YZDate myDate;
    myDate.year=mySafePeriodModel.lastTimeYear;
    myDate.month=mySafePeriodModel.lastTimeMonth;
    myDate.day=mySafePeriodModel.lastTimeDay;
    [self.myCalculateSafePerioDelegate calculateSafePerioByPeriodDateModel:mySafePeriodModel];
    [self.myDelegate toPresentView];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//返回主界面按钮
-(void)goBack:(id)sender{
    [self.myDelegate toPresentView];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
