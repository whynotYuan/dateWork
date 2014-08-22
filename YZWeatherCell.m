//
//  YZWeatherCell.m
//  dateWork
//
//  Created by 黄桂源 on 14-1-18.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "YZWeatherCell.h"

@implementation YZWeatherCell{
    UILabel* cityLabel;
    UIImageView* weatherImg;
    UILabel* detaillLable;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView* backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
        backgroundView.backgroundColor=[UIColor blackColor];
        backgroundView.alpha=0.25;
        cityLabel=[[UILabel alloc]init];
        weatherImg=[[UIImageView alloc]init];
        detaillLable=[[UILabel alloc]init];
        
        [self.contentView addSubview:backgroundView];
        [self.contentView addSubview:cityLabel];
        [self.contentView addSubview:weatherImg];
        [self.contentView addSubview:detaillLable];
    }
    return self;
}

-(void)refreshDate:(YZWeatherModel *)myModel andDay:(int)day{
    cityLabel.frame=CGRectMake(5, 5, myModel.cityName.length*15, 20);
    cityLabel.text=myModel.cityName;
    cityLabel.textColor=[UIColor whiteColor];
    cityLabel.font=[UIFont boldSystemFontOfSize:15];
    weatherImg.frame=CGRectMake(10+myModel.cityName.length*15, 5, 20, 20);
    weatherImg.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@-18.png",myModel.imgArray[day]]];
    detaillLable.frame=CGRectMake(35+myModel.cityName.length*15, 5, 180, 20);
    detaillLable.text=[NSString stringWithFormat:@"%@ %@",myModel.weatherArray[day],myModel.tempArray[day]];
    detaillLable.textColor=[UIColor whiteColor];
    detaillLable.font=[UIFont boldSystemFontOfSize:15];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
