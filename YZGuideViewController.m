//
//  YZGuideViewController.m
//  dateWork
//
//  Created by 黄桂源 on 14-2-11.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "YZGuideViewController.h"
#import "YZViewController.h"
#import "YZCityCode.h"
#import "YZDateWorkDatabase.h"


@interface YZGuideViewController ()
@end

@implementation YZGuideViewController{
    YZDateWorkDatabase* cityCodeDB;
    YZCityCode* cityCode;
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
    cityCodeDB = [YZDateWorkDatabase shareDatabase];
    NSLog(@"文件路径= %@", NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]);
	// Do any additional setup after loading the view.
    //隐藏导航栏
    self.navigationController.navigationBarHidden = YES;
    
    dispatch_queue_t rootQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(rootQueue, ^{
        dispatch_group_t groupQueue = dispatch_group_create();
        //给组队列分配任务（1，2分配为并行执行)
        dispatch_group_async(groupQueue, rootQueue, ^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self settingScrollView];
            });
            
        });
        dispatch_group_async(groupQueue, rootQueue, ^{
            [self insertIntoTable];
            
        });
    });
    
}

- (void) settingScrollView{
    NSLog(@"the first setting");
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(320*4, 480);
    [self.view addSubview:scrollView];
    for (int i = 0; i < 4; i++) {
        UIImageView *scrollImageView = [[UIImageView alloc] initWithFrame:CGRectMake(320*i, 0, 320, 480)];
        scrollImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"guide%d.jpg",i+1]];
        if (i == 3) {
            scrollImageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(enterMainViewController:)];
            [scrollImageView addGestureRecognizer:tapGR];
        }
        [scrollView addSubview:scrollImageView];
    }
}

- (void) insertIntoTable{
    cityCode = [[YZCityCode alloc] init];
    NSArray *cityNameArr = [cityCode.cityCodeDic allKeys];
    
    for (int i = 0; i < [cityNameArr count]; i++) {
        NSString *cityNameStr = cityNameArr[i];
        NSString *cityCodeStr = [cityCode.cityCodeDic objectForKey:cityNameStr];
        [cityCodeDB insertIntoTableCityCodeWithCityName:cityNameStr andCityCode:cityCodeStr];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    
}

- (void) enterMainViewController:(UITapGestureRecognizer *)tap{
    YZViewController *mainView = [[YZViewController alloc] init];
    [self presentViewController:mainView animated:YES completion:Nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
