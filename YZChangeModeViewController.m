//
//  YZChangeModeViewController.m
//  dateWork
//
//  Created by 黄桂源 on 14-1-13.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "YZChangeModeViewController.h"

@interface YZChangeModeViewController ()

@end

@implementation YZChangeModeViewController{
    UIImageView* myImageView[9];
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
    for (int i=0; i<9; ++i) {
        myImageView[i]=[[UIImageView alloc]init];
        if (i==2) {
            myImageView[i].image=[UIImage imageNamed:@"002"];
        }else{
            myImageView[i].image=[UIImage imageNamed:[NSString stringWithFormat:@"%03d.jpg",i]];
        }
    }
    UIView* backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    backgroundView.alpha=0.8;
    backgroundView.backgroundColor=[UIColor blackColor];
    [self.view addSubview:backgroundView];
    
	[self addNavigationBar];
    [self addButtonView];
    
    
    self.view.backgroundColor=[UIColor whiteColor];
}

-(void)addNavigationBar{
    UIView* navigationBarView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    UIImageView* navBackground=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    navBackground.image=[UIImage imageNamed:@"tileScrollBack_320_110"];
    
    UILabel* titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(120, 15, 80, 30)];
    titleLabel.text=@"日历切换";
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    
    UIButton* leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame=CGRectMake(5, 8, 40, 40);
    [leftButton setImage:[UIImage imageNamed:@"back_iphone5.png"] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"button_selected.9.png"] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    
    [navigationBarView addSubview:navBackground];
    [navigationBarView addSubview:leftButton];
    [navigationBarView addSubview:titleLabel];
    [self.view addSubview:navigationBarView];
}

-(void)addButtonView{
    UIView* buttonView=[[UIView alloc]initWithFrame:CGRectMake(0, 50, 320, 300)];
    buttonView.backgroundColor=[UIColor clearColor];
    
    for (int i=0; i<9; ++i) {
        //5, 5, 90, 80
        UIButton* myButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        myButton.frame=CGRectMake(5*(i%3+1)+100*(i%3),5*(i/3+1)+90*(i/3), 100, 90);
        myButton.tag=i;
        [myButton setBackgroundImage:[UIImage imageNamed:@"hall_btn_bg"] forState:UIControlStateNormal];
        [myButton addTarget:self action:@selector(changeMode:) forControlEvents:UIControlEventTouchUpInside];
        [buttonView addSubview:myButton];
        
        myImageView[i].frame=CGRectMake(5*(i%3+1)+100*(i%3)+5, 5*(i/3+1)+90*(i/3)+5+50, 90, 80);
    }
    [self.view addSubview:buttonView];
    for (int i=0; i<9; ++i) {
        [self.view addSubview:myImageView[i]];
    }
}

-(void)changeMode:(UIButton*)sender{
    [self.view bringSubviewToFront:myImageView[sender.tag]];
    [self.myDelegate toPresentView];
    [self.myScrollToPresentViewDelegate scrollToPresentView:sender.tag];
    [UIView animateWithDuration:0.3 animations:^{
        myImageView[sender.tag].frame=CGRectMake(0, 0, 320, 480);
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:^{
            myImageView[sender.tag].frame=CGRectMake(5*(sender.tag%3+1)+100*(sender.tag%3)+5, 5*(sender.tag/3+1)+90*(sender.tag/3)+5+50, 90, 80);

        }];
    }];
}

-(void)goBack:(id)sender{
    [self.myDelegate toPresentView];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
