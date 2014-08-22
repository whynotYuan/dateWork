//
//  YZupView.m
//  dateWork
//
//  Created by mac on 13-12-30.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "YZupView.h"
#import "YZWeatherModel.h"
#import "YZWeatherCell.h"
#import "YZSafePeriodCell.h"
#import "ASIHTTPRequest.h"
#import "YZWeatherCityArray.h"

@implementation YZupView{
    int mode;
    int weatherDay;
    YZSafePeriodModel2* mySafePeriodModel;
    NSMutableData* weatherData;
//    NSMutableArray* weatherArray;
    UITableView* myTabelView;
    YZWeatherCityArray* myCityArray;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithData:(int)a{
    self=[self initWithFrame:CGRectMake(a*320, 10, 320, 199)];
    if (self) {
        mode=a;
        switch (mode) {
            case 1:
                weatherData=[NSMutableData data];
//                weatherArray=[NSMutableArray array];
                myCityArray=[YZWeatherCityArray shareWeatherCityArray];
                [self acquairWeatherData];
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
                [self createEigthView];
                break;
                
            default:
                break;
        }

    }
    return self;
}

-(void)createFirstView{
    UIButton* titleButtom=[UIButton buttonWithType:UIButtonTypeCustom];
    titleButtom.frame=CGRectMake(5, 0, 80, 30);
    [titleButtom setTitle:@"我的日历" forState:UIControlStateNormal];
    titleButtom.titleLabel.font=[UIFont boldSystemFontOfSize:19];
    [titleButtom setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
    [titleButtom addTarget:self action:@selector(prsentChangeModeView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:titleButtom];
    
    UIButton* menuButton=[UIButton buttonWithType:UIButtonTypeCustom];
    menuButton.frame=CGRectMake(275, -10, 50, 50);
    [menuButton setImage:[UIImage imageNamed:@"paixi"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(toMenuView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:menuButton];
    

}

-(void)createSecondView{
    UIButton* titleButtom=[UIButton buttonWithType:UIButtonTypeCustom];
    titleButtom.frame=CGRectMake(10, 0, 65, 25);
    [titleButtom setImage:[UIImage imageNamed:@"lunar_name"] forState:UIControlStateNormal];
    [titleButtom setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
    [titleButtom addTarget:self action:@selector(prsentChangeModeView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:titleButtom];
    
    UIButton* menuButton=[UIButton buttonWithType:UIButtonTypeCustom];
    menuButton.frame=CGRectMake(275, -10, 50, 50);
    [menuButton setImage:[UIImage imageNamed:@"paixi"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(toMenuView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:menuButton];
}

-(void)createThirdView{
    UIButton* titleButtom=[UIButton buttonWithType:UIButtonTypeCustom];
    titleButtom.frame=CGRectMake(10, 0, 75, 30);
    [titleButtom setImage:[UIImage imageNamed:@"birthday_logo"] forState:UIControlStateNormal];
    [titleButtom setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
    [titleButtom addTarget:self action:@selector(prsentChangeModeView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:titleButtom];
    
    UIButton* menuButton=[UIButton buttonWithType:UIButtonTypeCustom];
    menuButton.frame=CGRectMake(275, -10, 50, 50);
    [menuButton setImage:[UIImage imageNamed:@"birthday_menu"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(toMenuView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:menuButton];
}

-(void)createForthView{
    UIButton* titleButtom=[UIButton buttonWithType:UIButtonTypeCustom];
    titleButtom.frame=CGRectMake(8, 0, 60, 30);
    [titleButtom setTitle:@"生理期" forState:UIControlStateNormal];
    titleButtom.titleLabel.font=[UIFont boldSystemFontOfSize:19];
    [titleButtom setTitleColor:[UIColor colorWithRed:1 green:0.5 blue:0.55  alpha:1] forState:UIControlStateNormal];
    [titleButtom setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [titleButtom addTarget:self action:@selector(prsentChangeModeView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:titleButtom];
    
    UIButton* menuButton=[UIButton buttonWithType:UIButtonTypeCustom];
    menuButton.frame=CGRectMake(275, -10, 50, 50);
    [menuButton setImage:[UIImage imageNamed:@"paixi"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(toMenuView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:menuButton];
}

-(void)createFifthView{
    UIButton* titleButtom=[UIButton buttonWithType:UIButtonTypeCustom];
    titleButtom.frame=CGRectMake(8, 0, 120, 30);
    [titleButtom setTitle:@"品牌特卖推荐" forState:UIControlStateNormal];
    titleButtom.titleLabel.font=[UIFont boldSystemFontOfSize:19];
    [titleButtom setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [titleButtom addTarget:self action:@selector(prsentChangeModeView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:titleButtom];
    
    UIButton* menuButton=[UIButton buttonWithType:UIButtonTypeCustom];
    menuButton.frame=CGRectMake(275, -10, 50, 50);
    [menuButton setImage:[UIImage imageNamed:@"paixi"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(toMenuView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:menuButton];
}

-(void)createSixthView{
    UIButton* titleButtom=[UIButton buttonWithType:UIButtonTypeCustom];
    titleButtom.frame=CGRectMake(5, 0, 120, 30);
    [titleButtom setTitle:@"电影首映推荐" forState:UIControlStateNormal];
    titleButtom.titleLabel.font=[UIFont boldSystemFontOfSize:19];
    [titleButtom setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [titleButtom setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [titleButtom addTarget:self action:@selector(prsentChangeModeView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:titleButtom];
    
    UIButton* menuButton=[UIButton buttonWithType:UIButtonTypeCustom];
    menuButton.frame=CGRectMake(275, -10, 50, 50);
    [menuButton setImage:[UIImage imageNamed:@"paixi"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(toMenuView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:menuButton];
}

-(void)createSevenView{
    UIButton* titleButtom=[UIButton buttonWithType:UIButtonTypeCustom];
    titleButtom.frame=CGRectMake(7, 0, 80, 30);
    [titleButtom setTitle:@"占星日历" forState:UIControlStateNormal];
    titleButtom.titleLabel.font=[UIFont boldSystemFontOfSize:19];
    [titleButtom setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
    [titleButtom addTarget:self action:@selector(prsentChangeModeView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:titleButtom];
    
    UIButton* menuButton=[UIButton buttonWithType:UIButtonTypeCustom];
    menuButton.frame=CGRectMake(275, -10, 50, 50);
    [menuButton setImage:[UIImage imageNamed:@"paixi"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(toMenuView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:menuButton];
}

-(void)createEigthView{
    UIButton* titleButtom=[UIButton buttonWithType:UIButtonTypeCustom];
    titleButtom.frame=CGRectMake(8, 0, 110, 30);
    [titleButtom setTitle:@"美剧更新日历" forState:UIControlStateNormal];
    titleButtom.titleLabel.font=[UIFont boldSystemFontOfSize:18];
    [titleButtom setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
    [titleButtom addTarget:self action:@selector(prsentChangeModeView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:titleButtom];
    
    UIButton* menuButton=[UIButton buttonWithType:UIButtonTypeCustom];
    menuButton.frame=CGRectMake(275, -10, 50, 50);
    [menuButton setImage:[UIImage imageNamed:@"paixi"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(toMenuView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:menuButton];
}

-(void)clickWeatherByDay:(int)day{
    weatherDay=day;
    myTabelView.hidden=NO;
    if (myTabelView==nil) {
        [self addTableView];
    }
    [myTabelView reloadData];
}

-(void)clickSafePeriodByModel:(YZSafePeriodModel2 *)myModel{
    mySafePeriodModel=myModel;
    myTabelView.hidden=NO;
    if (myTabelView==nil) {
        [self addTableView];
    }
    [myTabelView reloadData];
}

-(void)hideWeatherTable{
    myTabelView.hidden=YES;
}

-(void)acquairWeatherData{

//    static NSString *urlString=@"http://m.weather.com.cn/data/101280601.html";
//    NSURL *url=[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    NSURLRequest *request=[NSURLRequest requestWithURL:url];
//    [NSURLConnection connectionWithRequest:request delegate:self];
    
//    NSArray* arr=[NSArray array];
//    arr=@[@"101280601",@"101010100",@"101010200",@"101281701"];
//    for (int i=0; i<arr.count; ++i) {
//        NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://m.weather.com.cn/data/%@.html",arr[i]]]];
//        [NSURLConnection connectionWithRequest:request delegate:self];
//    }
    
    
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.weather.com.cn/data/101280601.html"]];
//    //    将请求的url数据放到NSData对象中
//    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    //    iOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
//    NSDictionary *weatherDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
//    //    weatherDic字典中存放的数据也是字典型，从它里面通过键值取值
//    NSDictionary *weatherInfo = [weatherDic objectForKey:@"weatherinfo"];
//    [myModel acquairDataFromNet:weatherInfo];
//    [weatherArray addObject:myModel];

    NSArray* arr=[NSArray array];
    arr=@[@"101280601",@"101010100",@"101200101",@"101281701",@"101020100",@"101130101"];
    
    for (int i=0; i<arr.count; ++i) {
        ASIHTTPRequest* requset=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://m.weather.com.cn/data/%@.html",arr[i]]]];
        __weak ASIHTTPRequest* weakRequest=requset;
        [requset setCompletionBlock:^{
            NSDictionary* weatherDic=[NSJSONSerialization JSONObjectWithData:weakRequest.responseData options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *weatherInfo = [weatherDic objectForKey:@"weatherinfo"];
            YZWeatherModel* lala=[[YZWeatherModel alloc]init];
            [lala acquairDataFromNet:weatherInfo];
//            [weatherArray addObject:lala];
            [myCityArray.cityArray addObject:lala];
        }];
        [requset setFailedBlock:^{
            NSLog(@"your are a pig!");
        }];
        [requset startAsynchronous];
    }

}


//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
//
//    weatherData.length=0;
//}
//
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
//    [weatherData appendData:data];
//}
//
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
//    NSDictionary* jsonDictionary=[NSJSONSerialization JSONObjectWithData:weatherData options:NSJSONReadingMutableContainers error:nil];
//    NSDictionary* weatherDictionary=jsonDictionary[@"weatherinfo"];
//    YZWeatherModel* myModel=[[YZWeatherModel alloc]init];
//    [myModel acquairDataFromNet:weatherDictionary];
//    NSLog(@"congelatulation");
//    [weatherArray addObject:myModel];
//}
//
//-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
//    NSLog(@"%@",error);
//}

//推出切换界面
-(void)prsentChangeModeView{
    [self.myChangeModeDelegate presentChangeModeView];
}

//推出菜单界面
-(void)toMenuView{
    [self.myMenuDelegate presentMenuView];
}


-(void)addTableView{
    myTabelView=[[UITableView alloc]initWithFrame:CGRectMake(0, 40, 320, 159) style:UITableViewStylePlain];
    myTabelView.backgroundColor=[UIColor clearColor];
    myTabelView.separatorStyle=UITableViewCellSeparatorStyleNone;
    myTabelView.delegate=self;
    myTabelView.dataSource=self;
    myTabelView.bounces=NO;
    myTabelView.tag=mode;
    if (mode==4) {
        myTabelView.userInteractionEnabled=NO;
    }
    UIView* downView=[[UIView alloc]init];
    [myTabelView setTableFooterView:downView];
    [self addSubview:myTabelView];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag==4) {
        return 1;
    }
    return myCityArray.cityArray.count;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* ID=@"nimei";
    if (tableView.tag==4) {
        YZSafePeriodCell* YZCell=[tableView dequeueReusableCellWithIdentifier:ID];
        if (!YZCell) {
            YZCell=[[YZSafePeriodCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        YZCell.backgroundColor=[UIColor clearColor];
        YZCell.selectionStyle=UITableViewCellSelectionStyleNone;
        [YZCell refreshDate:mySafePeriodModel];
        return YZCell;
    }
    YZWeatherCell* YZCell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!YZCell) {
        YZCell=[[YZWeatherCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    YZCell.backgroundColor=[UIColor clearColor];
    YZCell.selectionStyle=UITableViewCellSelectionStyleNone;
    [YZCell refreshDate:myCityArray.cityArray[indexPath.row] andDay:weatherDay];
    return YZCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag==1) {
        [self.myWeatherViewDelegate presentWeatherViewByPage:indexPath.row];
    }

    
}

@end
