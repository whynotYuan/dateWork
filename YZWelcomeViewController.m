//
//  YZWelcomeViewController.m
//  dateWork
//
//  Created by 黄桂源 on 14-2-11.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "YZWelcomeViewController.h"
#import "YZViewController.h"
#import "YZGuideViewController.h"

@interface YZWelcomeViewController ()

@end

@implementation YZWelcomeViewController{
    UIImageView* welcomeView;
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
    //设置欢迎视图
    welcomeView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"special.jpg"]];
    welcomeView.frame = self.view.bounds;
    [self.view addSubview:welcomeView];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(begindelay) object:nil];
    [self performSelector:@selector(begindelay) withObject:nil afterDelay:0.0];
}

- (void) begindelay{
    // Override point for customization after application launch.
    //首先判断用户是否第一次使用本应用(自定义一个判断方法）
    if ([self isEverUsed]) {
        YZViewController *mainView = [[YZViewController alloc] init];
        [self presentViewController:mainView animated:YES completion:Nil];
        

    }
    else{
        YZGuideViewController* guideView=[[YZGuideViewController alloc]init];
        [self presentViewController:guideView animated:YES completion:nil];
    }
}

- (BOOL) isEverUsed{
    NSUserDefaults *isEverUse = [NSUserDefaults standardUserDefaults];
    if (![isEverUse boolForKey:@"isEverUsed"]) {
        [isEverUse setBool:YES forKey:@"isEverUsed"];
        NSLog(@"第一次使用");
        return NO;
    }
    return YES;//不是第一次使用
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
