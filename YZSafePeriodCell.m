//
//  YZSafePeriodCell.m
//  dateWork
//
//  Created by 黄桂源 on 14-1-20.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "YZSafePeriodCell.h"

@implementation YZSafePeriodCell{
    UIImageView* safePic;
    UILabel* safeLabel;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        safePic=[[UIImageView alloc]initWithFrame:CGRectMake(5, 3, 24, 24)];
        safeLabel=[[UILabel alloc]initWithFrame:CGRectMake(35, 5, 200, 20)];
        safeLabel.textColor=[UIColor colorWithRed:1 green:0.45 blue:0.5  alpha:1];
        safeLabel.font=[UIFont systemFontOfSize:15];
        [self.contentView addSubview:safePic];
        [self.contentView addSubview:safeLabel];
    }
    return self;
}

-(void)refreshDate:(YZSafePeriodModel2 *)myModel{
    switch (myModel.safePeriodMode) {
        case 1:
            safePic.image=[UIImage imageNamed:[NSString stringWithFormat:@"safeperiod_anquan_table%d",myModel.numberOfPic]];
            safeLabel.text=[NSString stringWithFormat:@"安全期第%d天",myModel.contentDay];
            break;
        
        case 2:
            safePic.image=[UIImage imageNamed:[NSString stringWithFormat:@"safeperiod_weixian_table%d",myModel.numberOfPic]];
            safeLabel.text=[NSString stringWithFormat:@"危险期第%d天",myModel.contentDay];
            break;
            
        case 3:
            safePic.image=[UIImage imageNamed:[NSString stringWithFormat:@"safeperiod_yuejing_table%d",myModel.numberOfPic]];
            safeLabel.text=[NSString stringWithFormat:@"月经期第%d天",myModel.contentDay];
            break;
            
        case 4:
            safePic.image=[UIImage imageNamed:[NSString stringWithFormat:@"safeperiod_pailan_table%d",myModel.numberOfPic]];
            safeLabel.text=@"排卵日";
            break;
        default:
            break;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
