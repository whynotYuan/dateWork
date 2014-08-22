//
//  YZLunarCalendar.m
//  dateWork
//
//  Created by 黄桂源 on 14-1-6.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "YZLunarCalendar.h"

@implementation YZLunarCalendar{
    NSArray* festivalOfNowDay;
    NSArray* festivalOfLunar;
    NSArray* solarTerms;
    NSArray* holiday;
    NSArray* workday;
}
- (id)init
{
    self = [super init];
    if (self) {
        festivalOfNowDay=@[
         @"101",@"元旦",
         @"214",@"情人",
         @"308",@"妇女",
         @"312",@"植树",
         @"401",@"愚人",
         @"501",@"劳动",
         @"504",@"青年",
         @"5F27",@"母亲",
         @"601",@"儿童",
         @"6F37",@"父亲",
         @"701",@"建党",
         @"801",@"建军",
         @"910",@"教师",
         @"101",@"国庆",
         @"1031",@"万圣",
         @"11F44",@"感恩",
         @"1224",@"平安夜",
         @"1225",@"圣诞"];
        festivalOfLunar=@[@"101",@"春节",
                          @"115",@"元宵",
                          @"202",@"龙抬头",
                          @"505",@"端午",
                          @"707",@"七夕",
                          @"715",@"中元",
                          @"815",@"中秋",
                          @"909",@"重阳",
                          @"1208",@"腊八",
                          @"1223",@"小年"];
        solarTerms=@[@"小寒", @"大寒",@"立春", @"雨水", @"惊蛰", @"春分", @"清明", @"谷雨", @"立夏", @"小满", @"芒种", @"夏至", @"小暑", @"大暑", @"立秋", @"处暑", @"白露", @"秋分", @"寒露", @"霜降", @"立冬", @"小雪", @"大雪", @"冬至"];
        holiday=@[@"20130101",@"20130102",@"20130103",@"20130209",@"20130210",@"20130211",@"20130212",@"20130213",@"20130214",@"20130215",@"20130404",@"20130405",@"20130404",@"20130429",@"20130430",@"20130501",@"20130610",@"20130611",@"20130612",@"20130919",@"20130920",@"20130921",@"20131001",@"20131002",@"20131003",@"20131004",@"20131005",@"20131006",@"20131007",@"20140101",@"20140131",@"20140201",@"20140202",@"20140203",@"20140204",@"20140205",@"20140206",@"20140405",@"20140407",@"20140501",@"20140502",@"20140503",@"20140602",@"20140908",@"20141001",@"20141002",@"20141003",@"20141004",@"20141005",@"20141006",@"20141007"];
        workday=@[@"20130105",@"20130106",@"20130216",@"20130217",@"20130407",@"20130427",@"20130428",@"20130608",@"20130609",@"20130922",@"20130929",@"20131012",@"20140126",@"20140208",@"20140504",@"20140928",@"20141011"];
    }
    return self;
}

//判断是否法定假期或者工作日
-(int)isHolidayOrWorkdayWithDate:(YZDate)date{
    NSString* time=[NSString stringWithFormat:@"%d",date.year*10000+date.month*100+date.day];
    int number=0;
    for (NSString* day in holiday) {
        if ([time isEqualToString:day]) {
            number=1;
            break;
        }
    }
    for (NSString* day in workday) {
        if ([time isEqualToString:day]) {
            number=2;
            break;
        }
    }
    return number;
}

//得到农历月份对应字符串
- (NSString *)getMoonMonthStringWithNSInteger:(NSInteger)month {
    NSString* resultStr;
    if (month<=12) {
        resultStr = [NSString stringWithCString:stringOfMonth[month-1] encoding:NSUTF8StringEncoding];
    }else{
        NSString *str =  [NSString stringWithCString:stringOfMonth[month%100-1] encoding:NSUTF8StringEncoding];
        resultStr = [NSString stringWithFormat:@"闰%@",str];
    }
    return resultStr;
}

//得到农历日期对应字符串
- (NSString *)getMoonDayStringWithNSInteger:(NSInteger)day {
    NSString *resultStr = [NSString stringWithCString:stringOfDay[day-1] encoding:NSUTF8StringEncoding];
    return resultStr;
}

//计算当年的时间
- (NSInteger)getAccumulateDayOfThisYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    
    NSInteger days = 0;
    
    
    days = daysOfMonth[month-1] + day;
    if (((year%4==0&&year%100!=0) || year%400==0) && month>2) {
        days ++;
    }
    return days;
}

//根据阳历获得农历
-(YZDate)solar_to_lunar:(YZDate)mydate{/*公历转农历*/
    
    int year = mydate.year,
    month = mydate.month,
    day = mydate.day;
    int bySpring,bySolar,daysPerMonth;
    int index,flag;
    YZDate lunar;
    
    //bySpring 记录春节离当年元旦的天数。
    //bySolar 记录阳历日离当年元旦的天数。
    if( ((lunar200y[year-1900] & 0x0060) >> 5) == 1)
        bySpring = (lunar200y[year-1900] & 0x001F) - 1;
    else
        bySpring = (lunar200y[year-1900] & 0x001F) - 1 + 31;
    bySolar = daysOfMonth[month-1] + day - 1;
    if( (!(year % 4)) && (month > 2))
        bySolar++;
    
    //daysPerMonth记录大小月的天数 29 或30
    //index 记录从哪个月开始来计算。
    //flag 是用来对闰月的特殊处理。
    
    //判断阳历日在春节前还是春节后
    if (bySolar >= bySpring) {//阳历日在春节后（含春节那天）
        bySolar -= bySpring;
        month = 1;
        index = 1;
        flag = 0;
        if( ( lunar200y[year - 1900] & (0x80000 >> (index-1)) ) ==0)
            daysPerMonth = 29;
        else
            daysPerMonth = 30;
        while(bySolar >= daysPerMonth) {
            bySolar -= daysPerMonth;
            index++;
            if(month == ((lunar200y[year - 1900] & 0xF00000) >> 20) ) {
                flag = ~flag;
                if(flag == 0)
                    month++;
                    month+=100;
            }
            else{
                if (month>100) {
                    month-=100;
                }
                month++;
            }
            if( ( lunar200y[year - 1900] & (0x80000 >> (index-1)) ) ==0)
                daysPerMonth=29;
            else
                daysPerMonth=30;
        }
        day = bySolar + 1;
    }
    else {//阳历日在春节前
        bySpring -= bySolar;
        year--;
        month = 12;
        if ( ((lunar200y[year - 1900] & 0xF00000) >> 20) == 0)
            index = 12;
        else
            index = 13;
        flag = 0;
        if( ( lunar200y[year - 1900] & (0x80000 >> (index-1)) ) ==0)
            daysPerMonth = 29;
        else
            daysPerMonth = 30;
        while(bySpring > daysPerMonth) {
            bySpring -= daysPerMonth;
            index--;
            if(flag == 0)
                month--;
            if(month == ((lunar200y[year - 1900] & 0xF00000) >> 20))
                flag = ~flag;
            if( ( lunar200y[year - 1900] & (0x80000 >> (index-1)) ) ==0)
                daysPerMonth = 29;
            else
                daysPerMonth = 30;
        }
        
        day = daysPerMonth - bySpring + 1;
    }
    lunar.day = day;
    lunar.month = month;
    lunar.year = year;

    return lunar;
}

//通过农历日期获得传统节日
-(NSString *)getFestivalOFLunarWithDate:(YZDate)date andwhithString:(NSString *)formalString{
    NSString* resultStr=formalString;
    NSString* myDate=[NSString stringWithFormat:@"%d%02d",date.month,date.day];
    for (int i=0; i<festivalOfLunar.count-1; i+=2) {
        if ([myDate isEqualToString:festivalOfLunar[i]]) {
            resultStr=festivalOfLunar[i+1];
            break;
        }
    }
    if (date.month==12) {
        int lala=date.year-1900-1;
        if (date.day==29+((lunar200y[lala]&0x000100)>>8)) {
            resultStr=@"除夕";
        }
    }
    return resultStr;
}

//通过新历日期获得24节气
-(NSString *)getSolarTermWithDate:(YZDate)date andwihtString:(NSString *)formalString{
    NSString* resultStr=formalString;
    NSInteger solarTermDate=[self getSolarTermsWithYear:date.year month:date.month];
    if ((date.day==solarTermDate/100)&&date.day<15) {
        resultStr=solarTerms[(date.month-1)*2];
    }
    if ((date.day==solarTermDate%100)&&date.day>15) {
        resultStr=solarTerms[(date.month-1)*2+1];
    }
    return resultStr;
}

//通过新年月获取24节气时间
- (NSInteger)getSolarTermsWithYear:(NSInteger)year month:(NSInteger)month {
    
    NSInteger addr = (year - 1901)*12 + month-1;
    
    NSInteger day1 = 15 - ((jieqiCode[addr]&0xf0)>>4);
    NSInteger day2 = 15 + (jieqiCode[addr]&0x0f);
    
    return day1*100+day2;
    
}

//通过新历日期获取节日
-(NSString*)getFestivalWithDate:(YZDate)date andWithString:(NSString*)formalString{
    NSString* resultString=formalString;
    NSString* myDate=[NSString stringWithFormat:@"%d%02d",date.month,date.day];
    NSString* myDate2=[NSString stringWithFormat:@"%dF%d%d",date.month,(date.day-1)/7+1,date.week];
    for (int i=0; i<festivalOfNowDay.count-1; i+=2) {
        if (([myDate isEqualToString:festivalOfNowDay[i]])||([myDate2 isEqualToString:festivalOfNowDay[i]])) {
            resultString=festivalOfNowDay[i+1];
            break;
        }
    }
    return resultString;
}

//计算两天时间差
-(int)getTwoDaysIntervalFromDay:(YZDate)fromDate toDate:(YZDate)toDate{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *fromDateComponents = [[NSDateComponents alloc] init];
    fromDateComponents.year = fromDate.year;
    fromDateComponents.month = fromDate.month;
    fromDateComponents.day = fromDate.day;
    
    NSDateComponents *toDateComponents = [[NSDateComponents alloc] init];
    toDateComponents.year = toDate.year;
    toDateComponents.month = toDate.month;
    toDateComponents.day = toDate.day;
    
    NSTimeInterval intervalTime = [[calendar dateFromComponents:fromDateComponents] timeIntervalSinceDate:[calendar dateFromComponents:toDateComponents]];
    
    intervalTime = intervalTime/(24*60*60);
    
    return (int)intervalTime;
}

NSInteger daysOfMonth[] = {0, 31, 59, 90, 120, 151,181, 212, 243, 273, 304, 334, 365};

static char stringOfDay[30][8] = {{"初一"},{"初二"},{"初三"},{"初四"},{"初五"},{"初六"},{"初七"},{"初八"},{"初九"},{"初十"},{"十一"},{"十二"},{"十三"},{"十四"},{"十五"},{"十六"},{"十七"},{"十八"},{"十九"},{"二十"},{"廿一"},{"廿二"},{"廿三"},{"廿四"},{"廿五"},{"廿六"},{"廿七"},{"廿八"},{"廿九"},{"三十"},};

static char stringOfMonth[12][8] = {{"正月"},{"二月"},{"三月"},{"四月"},{"五月"},{"六月"},{"七月"},{"八月"},{"九月"},{"十月"},{"冬月"},{"腊月"}};
/*
格式BIT23-20 位表示闰月月份,值为0 为无闰月,
BIT19-8 对应农历第1-12 月的大小
BIT7 表示农历第13 个月大小  月份对应的位为1 表示本农历月大(30 天),为0 表示小(29 天)
BIT6-5 表示春节的公历月份,BIT4-0 表示春节的公历日期
 */
unsigned int lunar200y[200] = {
    0x84bd3f,0x04AE53,0x0A5748,0x5526BD,0x0D2650,0x0D9544,0x46AAB9,0x056A4D,0x09AD42,0x24AEB6,0x04AE4A,/*1900-1910*/
    0x6A4DBE,0x0A4D52,0x0D2546,0x5D52BA,0x0B544E,0x0D6A43,0x296D37,0x095B4B,0x749BC1,0x049754,/*1911-1920*/
    0x0A4B48,0x5B25BC,0x06A550,0x06D445,0x4ADAB8,0x02B64D,0x095742,0x2497B7,0x04974A,0x664B3E,/*1921-1930*/
    0x0D4A51,0x0EA546,0x56D4BA,0x05AD4E,0x02B644,0x393738,0x092E4B,0x7C96BF,0x0C9553,0x0D4A48,/*1931-1940*/
    0x6DA53B,0x0B554F,0x056A45,0x4AADB9,0x025D4D,0x092D42,0x2C95B6,0x0A954A,0x7B4ABD,0x06CA51,/*1941-1950*/
    0x0B5546,0x555ABB,0x04DA4E,0x0A5B43,0x352BB8,0x052B4C,0x8A953F,0x0E9552,0x06AA48,0x6AD53C,/*1951-1960*/
    0x0AB54F,0x04B645,0x4A5739,0x0A574D,0x052642,0x3E9335,0x0D9549,0x75AABE,0x056A51,0x096D46,/*1961-1970*/
    0x54AEBB,0x04AD4F,0x0A4D43,0x4D26B7,0x0D254B,0x8D52BF,0x0B5452,0x0B6A47,0x696D3C,0x095B50,/*1971-1980*/
    0x049B45,0x4A4BB9,0x0A4B4D,0xAB25C2,0x06A554,0x06D449,0x6ADA3D,0x0AB651,0x093746,0x5497BB,/*1981-1990*/
    0x04974F,0x064B44,0x36A537,0x0EA54A,0x86B2BF,0x05AC53,0x0AB647,0x5936BC,0x092E50,0x0C9645,/*1991-2000*/
    0x4D4AB8,0x0D4A4C,0x0DA541,0x25AAB6,0x056A49,0x7AADBD,0x025D52,0x092D47,0x5C95BA,0x0A954E,/*2001-2010*/
    0x0B4A43,0x4B5537,0x0AD54A,0x955ABF,0x04BA53,0x0A5B48,0x652BBC,0x052B50,0x0A9345,0x474AB9,/*2011-2020*/
    0x06AA4C,0x0AD541,0x24DAB6,0x04B64A,0x69573D,0x0A4E51,0x0D2646,0x5E933A,0x0D534D,0x05AA43,/*2021-2030*/
    0x36B537,0x096D4B,0xB4AEBF,0x04AD53,0x0A4D48,0x6D25BC,0x0D254F,0x0D5244,0x5DAA38,0x0B5A4C,/*2031-2040*/
    0x056D41,0x24ADB6,0x049B4A,0x7A4BBE,0x0A4B51,0x0AA546,0x5B52BA,0x06D24E,0x0ADA42,0x355B37,/*2041-2050*/
    0x09374B,0x8497C1,0x049753,0x064B48,0x66A53C,0x0EA54F,0x06B244,0x4AB638,0x0AAE4C,0x092E42,/*2051-2060*/
    0x3C9735,0x0C9649,0x7D4ABD,0x0D4A51,0x0DA545,0x55AABA,0x056A4E,0x0A6D43,0x452EB7,0x052D4B,/*2061-2070*/
    0x8A95BF,0x0A9553,0x0B4A47,0x6B553B,0x0AD54F,0x055A45,0x4A5D38,0x0A5B4C,0x052B42,0x3A93B6,/*2071-2080*/
    0x069349,0x7729BD,0x06AA51,0x0AD546,0x54DABA,0x04B64E,0x0A5743,0x452738,0x0D264A,0x8E933E,/*2081-2090*/
    0x0D5252,0x0DAA47,0x66B53B,0x056D4F,0x04AE45,0x4A4EB9,0x0A4D4C,0x0D1541,0x2D92B5          /*2091-2099*/
};

/****************************************************************************************************************************
 二十四节气数据库（1901--2050）
 数据格式说明:
 如1901年的节气为
 1月    2月     3月     4月       5月      6月    7月     8月      9月    10月   11月    12月
 [ 6,21][ 4,19][ 6,21][ 5,21][ 6,22][ 6,22][ 8,23][ 8,24][ 8,24][ 8,24][ 8,23][ 8,22]
 [ 9, 6][11, 4][ 9, 6][10, 6][ 9, 7][ 9, 7][ 7, 8][ 7, 9][ 7, 9][ 7, 9][ 7, 8][ 7,15]
 上面第一行数据为每月节气对应公历日期,15减去每月第一个节气,每月第二个节气减去15得第二
 行，这样每月两个节气对应数据都小于16,每月用一个字节存放,高位存放第一个节气数据,低位存
 放第二个节气的数据,可得下表
 ****************************************************************************************************************************/
static unsigned char jieqiCode[]=
{
 //0x96,0xB4,0x96,0xA6,0x97,0x97,0x78,0x79,0x79,0x69,0x78,0x77,     //1900
    0x96, 0xB4, 0x96, 0xA6, 0x97, 0x97, 0x78, 0x79, 0x79, 0x69, 0x78, 0x77, //1901
    0x96, 0xA4, 0x96, 0x96, 0x97, 0x87, 0x79, 0x79, 0x79, 0x69, 0x78, 0x78, //1902
    0x96, 0xA5, 0x87, 0x96, 0x87, 0x87, 0x79, 0x69, 0x69, 0x69, 0x78, 0x78, //1903
    0x86, 0xA5, 0x96, 0xA5, 0x96, 0x97, 0x88, 0x78, 0x78, 0x79, 0x78, 0x87, //1904
    0x96, 0xB4, 0x96, 0xA6, 0x97, 0x97, 0x78, 0x79, 0x79, 0x69, 0x78, 0x77, //1905
    0x96, 0xA4, 0x96, 0x96, 0x97, 0x97, 0x79, 0x79, 0x79, 0x69, 0x78, 0x78, //1906
    0x96, 0xA5, 0x87, 0x96, 0x87, 0x87, 0x79, 0x69, 0x69, 0x69, 0x78, 0x78, //1907
    0x86, 0xA5, 0x96, 0xA5, 0x96, 0x97, 0x88, 0x78, 0x78, 0x69, 0x78, 0x87, //1908
    0x96, 0xB4, 0x96, 0xA6, 0x97, 0x97, 0x78, 0x79, 0x79, 0x69, 0x78, 0x77, //1909
    0x96, 0xA4, 0x96, 0x96, 0x97, 0x97, 0x79, 0x79, 0x79, 0x69, 0x78, 0x78, //1910
    0x96, 0xA5, 0x87, 0x96, 0x87, 0x87, 0x79, 0x69, 0x69, 0x69, 0x78, 0x78, //1911
    0x86, 0xA5, 0x96, 0xA5, 0x96, 0x97, 0x88, 0x78, 0x78, 0x69, 0x78, 0x87, //1912
    0x95, 0xB4, 0x96, 0xA6, 0x97, 0x97, 0x78, 0x79, 0x79, 0x69, 0x78, 0x77, //1913
    0x96, 0xB4, 0x96, 0xA6, 0x97, 0x97, 0x79, 0x79, 0x79, 0x69, 0x78, 0x78, //1914
    0x96, 0xA5, 0x97, 0x96, 0x97, 0x87, 0x79, 0x79, 0x69, 0x69, 0x78, 0x78, //1915
    0x96, 0xA5, 0x96, 0xA5, 0x96, 0x97, 0x88, 0x78, 0x78, 0x79, 0x77, 0x87, //1916
    0x95, 0xB4, 0x96, 0xA6, 0x96, 0x97, 0x78, 0x79, 0x78, 0x69, 0x78, 0x87, //1917
    0x96, 0xB4, 0x96, 0xA6, 0x97, 0x97, 0x79, 0x79, 0x79, 0x69, 0x78, 0x77, //1918
    0x96, 0xA5, 0x97, 0x96, 0x97, 0x87, 0x79, 0x79, 0x69, 0x69, 0x78, 0x78, //1919
    0x96, 0xA5, 0x96, 0xA5, 0x96, 0x97, 0x88, 0x78, 0x78, 0x79, 0x77, 0x87, //1920
    0x95, 0xB4, 0x96, 0xA5, 0x96, 0x97, 0x78, 0x79, 0x78, 0x69, 0x78, 0x87, //1921
    0x96, 0xB4, 0x96, 0xA6, 0x97, 0x97, 0x79, 0x79, 0x79, 0x69, 0x78, 0x77, //1922
    0x96, 0xA4, 0x96, 0x96, 0x97, 0x87, 0x79, 0x79, 0x69, 0x69, 0x78, 0x78, //1923
    0x96, 0xA5, 0x96, 0xA5, 0x96, 0x97, 0x88, 0x78, 0x78, 0x79, 0x77, 0x87, //1924
    0x95, 0xB4, 0x96, 0xA5, 0x96, 0x97, 0x78, 0x79, 0x78, 0x69, 0x78, 0x87, //1925
    0x96, 0xB4, 0x96, 0xA6, 0x97, 0x97, 0x78, 0x79, 0x79, 0x69, 0x78, 0x77, //1926
    0x96, 0xA4, 0x96, 0x96, 0x97, 0x87, 0x79, 0x79, 0x79, 0x69, 0x78, 0x78, //1927
    0x96, 0xA5, 0x96, 0xA5, 0x96, 0x96, 0x88, 0x78, 0x78, 0x78, 0x87, 0x87, //1928
    0x95, 0xB4, 0x96, 0xA5, 0x96, 0x97, 0x88, 0x78, 0x78, 0x79, 0x77, 0x87, //1929
    0x96, 0xB4, 0x96, 0xA6, 0x97, 0x97, 0x78, 0x79, 0x79, 0x69, 0x78, 0x77, //1930
    0x96, 0xA4, 0x96, 0x96, 0x97, 0x87, 0x79, 0x79, 0x79, 0x69, 0x78, 0x78, //1931
    0x96, 0xA5, 0x96, 0xA5, 0x96, 0x96, 0x88, 0x78, 0x78, 0x78, 0x87, 0x87, //1932
    0x95, 0xB4, 0x96, 0xA5, 0x96, 0x97, 0x88, 0x78, 0x78, 0x69, 0x78, 0x87, //1933
    0x96, 0xB4, 0x96, 0xA6, 0x97, 0x97, 0x78, 0x79, 0x79, 0x69, 0x78, 0x77, //1934
    0x96, 0xA4, 0x96, 0x96, 0x97, 0x97, 0x79, 0x79, 0x79, 0x69, 0x78, 0x78, //1935
    0x96, 0xA5, 0x96, 0xA5, 0x96, 0x96, 0x88, 0x78, 0x78, 0x78, 0x87, 0x87, //1936
    0x95, 0xB4, 0x96, 0xA5, 0x96, 0x97, 0x88, 0x78, 0x78, 0x69, 0x78, 0x87, //1937
    0x96, 0xB4, 0x96, 0xA6, 0x97, 0x97, 0x78, 0x79, 0x79, 0x69, 0x78, 0x77, //1938
    0x96, 0xA4, 0x96, 0x96, 0x97, 0x97, 0x79, 0x79, 0x79, 0x69, 0x78, 0x78, //1939
    0x96, 0xA5, 0x96, 0xA5, 0x96, 0x96, 0x88, 0x78, 0x78, 0x78, 0x87, 0x87, //1940
    0x95, 0xB4, 0x96, 0xA5, 0x96, 0x97, 0x88, 0x78, 0x78, 0x69, 0x78, 0x87, //1941
    0x96, 0xB4, 0x96, 0xA6, 0x97, 0x97, 0x78, 0x79, 0x79, 0x69, 0x78, 0x77, //1942
    0x96, 0xA4, 0x96, 0x96, 0x97, 0x97, 0x79, 0x79, 0x79, 0x69, 0x78, 0x78, //1943
    0x96, 0xA5, 0x96, 0xA5, 0xA6, 0x96, 0x88, 0x78, 0x78, 0x78, 0x87, 0x87, //1944
    0x95, 0xB4, 0x96, 0xA5, 0x96, 0x97, 0x88, 0x78, 0x78, 0x79, 0x77, 0x87, //1945
    0x95, 0xB4, 0x96, 0xA6, 0x97, 0x97, 0x78, 0x79, 0x78, 0x69, 0x78, 0x77, //1946
    0x96, 0xB4, 0x96, 0xA6, 0x97, 0x97, 0x79, 0x79, 0x79, 0x69, 0x78, 0x78, //1947
    0x96, 0xA5, 0xA6, 0xA5, 0xA6, 0x96, 0x88, 0x88, 0x78, 0x78, 0x87, 0x87, //1948
    0xA5, 0xB4, 0x96, 0xA5, 0x96, 0x97, 0x88, 0x79, 0x78, 0x79, 0x77, 0x87, //1949
    0x95, 0xB4, 0x96, 0xA5, 0x96, 0x97, 0x78, 0x79, 0x78, 0x69, 0x78, 0x77, //1950
    0x96, 0xB4, 0x96, 0xA6, 0x97, 0x97, 0x79, 0x79, 0x79, 0x69, 0x78, 0x78, //1951
    0x96, 0xA5, 0xA6, 0xA5, 0xA6, 0x96, 0x88, 0x88, 0x78, 0x78, 0x87, 0x87, //1952
    0xA5, 0xB4, 0x96, 0xA5, 0x96, 0x97, 0x88, 0x78, 0x78, 0x79, 0x77, 0x87, //1953
    0x95, 0xB4, 0x96, 0xA5, 0x96, 0x97, 0x78, 0x79, 0x78, 0x68, 0x78, 0x87, //1954
    0x96, 0xB4, 0x96, 0xA6, 0x97, 0x97, 0x78, 0x79, 0x79, 0x69, 0x78, 0x77, //1955
    0x96, 0xA5, 0xA5, 0xA5, 0xA6, 0x96, 0x88, 0x88, 0x78, 0x78, 0x87, 0x87, //1956
    0xA5, 0xB4, 0x96, 0xA5, 0x96, 0x97, 0x88, 0x78, 0x78, 0x79, 0x77, 0x87, //1957
    0x95, 0xB4, 0x96, 0xA5, 0x96, 0x97, 0x88, 0x78, 0x78, 0x69, 0x78, 0x87, //1958
    0x96, 0xB4, 0x96, 0xA6, 0x97, 0x97, 0x78, 0x79, 0x79, 0x69, 0x78, 0x77, //1959
    0x96, 0xA4, 0xA5, 0xA5, 0xA6, 0x96, 0x88, 0x88, 0x88, 0x78, 0x87, 0x87, //1960
    0xA5, 0xB4, 0x96, 0xA5, 0x96, 0x96, 0x88, 0x78, 0x78, 0x78, 0x87, 0x87, //1961
    0x96, 0xB4, 0x96, 0xA5, 0x96, 0x97, 0x88, 0x78, 0x78, 0x69, 0x78, 0x87, //1962
    0x96, 0xB4, 0x96, 0xA6, 0x97, 0x97, 0x78, 0x79, 0x79, 0x69, 0x78, 0x77, //1963
    0x96, 0xA4, 0xA5, 0xA5, 0xA6, 0x96, 0x88, 0x88, 0x88, 0x78, 0x87, 0x87, //1964
    0xA5, 0xB4, 0x96, 0xA5, 0x96, 0x96, 0x88, 0x78, 0x78, 0x78, 0x87, 0x87, //1965
    0x95, 0xB4, 0x96, 0xA5, 0x96, 0x97, 0x88, 0x78, 0x78, 0x69, 0x78, 0x87, //1966
    0x96, 0xB4, 0x96, 0xA6, 0x97, 0x97, 0x78, 0x79, 0x79, 0x69, 0x78, 0x77, //1967
    0x96, 0xA4, 0xA5, 0xA5, 0xA6, 0xA6, 0x88, 0x88, 0x88, 0x78, 0x87, 0x87, //1968
    0xA5, 0xB4, 0x96, 0xA5, 0x96, 0x96, 0x88, 0x78, 0x78, 0x78, 0x87, 0x87, //1969
    0x95, 0xB4, 0x96, 0xA5, 0x96, 0x97, 0x88, 0x78, 0x78, 0x69, 0x78, 0x87, //1970
    0x96, 0xB4, 0x96, 0xA6, 0x97, 0x97, 0x78, 0x79, 0x79, 0x69, 0x78, 0x77, //1971
    0x96, 0xA4, 0xA5, 0xA5, 0xA6, 0xA6, 0x88, 0x88, 0x88, 0x78, 0x87, 0x87, //1972
    0xA5, 0xB5, 0x96, 0xA5, 0xA6, 0x96, 0x88, 0x78, 0x78, 0x78, 0x87, 0x87, //1973
    0x95, 0xB4, 0x96, 0xA5, 0x96, 0x97, 0x88, 0x78, 0x78, 0x69, 0x78, 0x87, //1974
    0x96, 0xB4, 0x96, 0xA6, 0x97, 0x97, 0x78, 0x79, 0x78, 0x69, 0x78, 0x77, //1975
    0x96, 0xA4, 0xA5, 0xB5, 0xA6, 0xA6, 0x88, 0x89, 0x88, 0x78, 0x87, 0x87, //1976
    0xA5, 0xB4, 0x96, 0xA5, 0x96, 0x96, 0x88, 0x88, 0x78, 0x78, 0x87, 0x87, //1977
    0x95, 0xB4, 0x96, 0xA5, 0x96, 0x97, 0x88, 0x78, 0x78, 0x79, 0x78, 0x87, //1978
    0x96, 0xB4, 0x96, 0xA6, 0x96, 0x97, 0x78, 0x79, 0x78, 0x69, 0x78, 0x77, //1979
    0x96, 0xA4, 0xA5, 0xB5, 0xA6, 0xA6, 0x88, 0x88, 0x88, 0x78, 0x87, 0x87, //1980
    0xA5, 0xB4, 0x96, 0xA5, 0xA6, 0x96, 0x88, 0x88, 0x78, 0x78, 0x77, 0x87, //1981
    0x95, 0xB4, 0x96, 0xA5, 0x96, 0x97, 0x88, 0x78, 0x78, 0x79, 0x77, 0x87, //1982
    0x95, 0xB4, 0x96, 0xA5, 0x96, 0x97, 0x78, 0x79, 0x78, 0x69, 0x78, 0x77, //1983
    0x96, 0xB4, 0xA5, 0xB5, 0xA6, 0xA6, 0x87, 0x88, 0x88, 0x78, 0x87, 0x87, //1984
    0xA5, 0xB4, 0xA6, 0xA5, 0xA6, 0x96, 0x88, 0x88, 0x78, 0x78, 0x87, 0x87, //1985
    0xA5, 0xB4, 0x96, 0xA5, 0x96, 0x97, 0x88, 0x78, 0x78, 0x79, 0x77, 0x87, //1986
    0x95, 0xB4, 0x96, 0xA5, 0x96, 0x97, 0x88, 0x79, 0x78, 0x69, 0x78, 0x87, //1987
    0x96, 0xB4, 0xA5, 0xB5, 0xA6, 0xA6, 0x87, 0x88, 0x88, 0x78, 0x87, 0x86, //1988
    0xA5, 0xB4, 0xA5, 0xA5, 0xA6, 0x96, 0x88, 0x88, 0x88, 0x78, 0x87, 0x87, //1989
    0xA5, 0xB4, 0x96, 0xA5, 0x96, 0x96, 0x88, 0x78, 0x78, 0x79, 0x77, 0x87, //1990
    0x95, 0xB4, 0x96, 0xA5, 0x86, 0x97, 0x88, 0x78, 0x78, 0x69, 0x78, 0x87, //1991
    0x96, 0xB4, 0xA5, 0xB5, 0xA6, 0xA6, 0x87, 0x88, 0x88, 0x78, 0x87, 0x86, //1992
    0xA5, 0xB3, 0xA5, 0xA5, 0xA6, 0x96, 0x88, 0x88, 0x88, 0x78, 0x87, 0x87, //1993
    0xA5, 0xB4, 0x96, 0xA5, 0x96, 0x96, 0x88, 0x78, 0x78, 0x78, 0x87, 0x87, //1994
    0x95, 0xB4, 0x96, 0xA5, 0x96, 0x97, 0x88, 0x76, 0x78, 0x69, 0x78, 0x87, //1995
    0x96, 0xB4, 0xA5, 0xB5, 0xA6, 0xA6, 0x87, 0x88, 0x88, 0x78, 0x87, 0x86, //1996
    0xA5, 0xB3, 0xA5, 0xA5, 0xA6, 0xA6, 0x88, 0x88, 0x88, 0x78, 0x87, 0x87, //1997
    0xA5, 0xB4, 0x96, 0xA5, 0x96, 0x96, 0x88, 0x78, 0x78, 0x78, 0x87, 0x87, //1998
    0x95, 0xB4, 0x96, 0xA5, 0x96, 0x97, 0x88, 0x78, 0x78, 0x69, 0x78, 0x87, //1999
    0x96, 0xB4, 0xA5, 0xB5, 0xA6, 0xA6, 0x87, 0x88, 0x88, 0x78, 0x87, 0x86, //2000
    0xA5, 0xB3, 0xA5, 0xA5, 0xA6, 0xA6, 0x88, 0x88, 0x88, 0x78, 0x87, 0x87, //2001
    0xA5, 0xB4, 0x96, 0xA5, 0x96, 0x96, 0x88, 0x78, 0x78, 0x78, 0x87, 0x87, //2002
    0x95, 0xB4, 0x96, 0xA5, 0x96, 0x97, 0x88, 0x78, 0x78, 0x69, 0x78, 0x87, //2003
    0x96, 0xB4, 0xA5, 0xB5, 0xA6, 0xA6, 0x87, 0x88, 0x88, 0x78, 0x87, 0x86, //2004
    0xA5, 0xB3, 0xA5, 0xA5, 0xA6, 0xA6, 0x88, 0x88, 0x88, 0x78, 0x87, 0x87, //2005
    0xA5, 0xB4, 0x96, 0xA5, 0xA6, 0x96, 0x88, 0x88, 0x78, 0x78, 0x87, 0x87, //2006
    0x95, 0xB4, 0x96, 0xA5, 0x96, 0x97, 0x88, 0x78, 0x78, 0x69, 0x78, 0x87, //2007
    0x96, 0xB4, 0xA5, 0xB5, 0xA6, 0xA6, 0x87, 0x88, 0x87, 0x78, 0x87, 0x86, //2008
    0xA5, 0xB3, 0xA5, 0xB5, 0xA6, 0xA6, 0x88, 0x88, 0x88, 0x78, 0x87, 0x87, //2009
    0xA5, 0xB4, 0x96, 0xA5, 0xA6, 0x96, 0x88, 0x88, 0x78, 0x78, 0x87, 0x87, //2010
    0x95, 0xB4, 0x96, 0xA5, 0x96, 0x97, 0x88, 0x78, 0x78, 0x79, 0x78, 0x87, //2011
    0x96, 0xB4, 0xA5, 0xB5, 0xA5, 0xA6, 0x87, 0x88, 0x87, 0x78, 0x87, 0x86, //2012
    0xA5, 0xB3, 0xA5, 0xB5, 0xA6, 0xA6, 0x87, 0x88, 0x88, 0x78, 0x87, 0x87, //2013
    0xA5, 0xB4, 0x96, 0xA5, 0xA6, 0x96, 0x88, 0x88, 0x78, 0x78, 0x87, 0x87, //2014
    0x95, 0xB4, 0x96, 0xA5, 0x96, 0x97, 0x88, 0x78, 0x78, 0x79, 0x77, 0x87, //2015
    0x95, 0xB4, 0xA5, 0xB4, 0xA5, 0xA6, 0x87, 0x88, 0x87, 0x78, 0x87, 0x86, //2016
    0xA5, 0xC3, 0xA5, 0xB5, 0xA6, 0xA6, 0x87, 0x88, 0x88, 0x78, 0x87, 0x87, //2017
    0xA5, 0xB4, 0xA6, 0xA5, 0xA6, 0x96, 0x88, 0x88, 0x78, 0x78, 0x87, 0x87, //2018
    0xA5, 0xB4, 0x96, 0xA5, 0x96, 0x96, 0x88, 0x78, 0x78, 0x79, 0x77, 0x87, //2019
    0x95, 0xB4, 0xA5, 0xB4, 0xA5, 0xA6, 0x97, 0x87, 0x87, 0x78, 0x87, 0x86, //2020
    0xA5, 0xC3, 0xA5, 0xB5, 0xA6, 0xA6, 0x87, 0x88, 0x88, 0x78, 0x87, 0x86, //2021
    0xA5, 0xB4, 0xA5, 0xA5, 0xA6, 0x96, 0x88, 0x88, 0x88, 0x78, 0x87, 0x87, //2022
    0xA5, 0xB4, 0x96, 0xA5, 0x96, 0x96, 0x88, 0x78, 0x78, 0x79, 0x77, 0x87, //2023
    0x95, 0xB4, 0xA5, 0xB4, 0xA5, 0xA6, 0x97, 0x87, 0x87, 0x78, 0x87, 0x96, //2024
    0xA5, 0xC3, 0xA5, 0xB5, 0xA6, 0xA6, 0x87, 0x88, 0x88, 0x78, 0x87, 0x86, //2025
    0xA5, 0xB3, 0xA5, 0xA5, 0xA6, 0xA6, 0x88, 0x88, 0x88, 0x78, 0x87, 0x87, //2026
    0xA5, 0xB4, 0x96, 0xA5, 0x96, 0x96, 0x88, 0x78, 0x78, 0x78, 0x87, 0x87, //2027
    0x95, 0xB4, 0xA5, 0xB4, 0xA5, 0xA6, 0x97, 0x87, 0x87, 0x78, 0x87, 0x96, //2028
    0xA5, 0xC3, 0xA5, 0xB5, 0xA6, 0xA6, 0x87, 0x88, 0x88, 0x78, 0x87, 0x86, //2029
    0xA5, 0xB3, 0xA5, 0xA5, 0xA6, 0xA6, 0x88, 0x88, 0x88, 0x78, 0x87, 0x87, //2030
    0xA5, 0xB4, 0x96, 0xA5, 0x96, 0x96, 0x88, 0x78, 0x78, 0x78, 0x87, 0x87, //2031
    0x95, 0xB4, 0xA5, 0xB4, 0xA5, 0xA6, 0x97, 0x87, 0x87, 0x78, 0x87, 0x96, //2032
    0xA5, 0xC3, 0xA5, 0xB5, 0xA6, 0xA6, 0x88, 0x88, 0x88, 0x78, 0x87, 0x86, //2033
    0xA5, 0xB3, 0xA5, 0xA5, 0xA6, 0xA6, 0x88, 0x78, 0x88, 0x78, 0x87, 0x87, //2034
    0xA5, 0xB4, 0x96, 0xA5, 0xA6, 0x96, 0x88, 0x88, 0x78, 0x78, 0x87, 0x87, //2035
    0x95, 0xB4, 0xA5, 0xB4, 0xA5, 0xA6, 0x97, 0x87, 0x87, 0x78, 0x87, 0x96, //2036
    0xA5, 0xC3, 0xA5, 0xB5, 0xA6, 0xA6, 0x87, 0x88, 0x88, 0x78, 0x87, 0x86, //2037
    0xA5, 0xB3, 0xA5, 0xA5, 0xA6, 0xA6, 0x88, 0x88, 0x88, 0x78, 0x87, 0x87, //2038
    0xA5, 0xB4, 0x96, 0xA5, 0xA6, 0x96, 0x88, 0x88, 0x78, 0x78, 0x87, 0x87, //2039
    0x95, 0xB4, 0xA5, 0xB4, 0xA5, 0xA6, 0x97, 0x87, 0x87, 0x78, 0x87, 0x96, //2040
    0xA5, 0xC3, 0xA5, 0xB5, 0xA5, 0xA6, 0x87, 0x88, 0x87, 0x78, 0x87, 0x86, //2041
    0xA5, 0xB3, 0xA5, 0xB5, 0xA6, 0xA6, 0x88, 0x88, 0x88, 0x78, 0x87, 0x87, //2042
    0xA5, 0xB4, 0x96, 0xA5, 0xA6, 0x96, 0x88, 0x88, 0x78, 0x78, 0x87, 0x87, //2043
    0x95, 0xB4, 0xA5, 0xB4, 0xA5, 0xA6, 0x97, 0x87, 0x87, 0x88, 0x87, 0x96, //2044
    0xA5, 0xC3, 0xA5, 0xB4, 0xA5, 0xA6, 0x87, 0x88, 0x87, 0x78, 0x87, 0x86, //2045
    0xA5, 0xB3, 0xA5, 0xB5, 0xA6, 0xA6, 0x87, 0x88, 0x88, 0x78, 0x87, 0x87, //2046
    0xA5, 0xB4, 0x96, 0xA5, 0xA6, 0x96, 0x88, 0x88, 0x78, 0x78, 0x87, 0x87, //2047
    0x95, 0xB4, 0xA5, 0xB4, 0xA5, 0xA5, 0x97, 0x87, 0x87, 0x88, 0x86, 0x96, //2048
    0xA4, 0xC3, 0xA5, 0xA5, 0xA5, 0xA6, 0x97, 0x87, 0x87, 0x78, 0x87, 0x86, //2049
    0xA5, 0xC3, 0xA5, 0xB5, 0xA6, 0xA6, 0x87, 0x88, 0x78, 0x78, 0x87, 0x87 //2050
};

@end