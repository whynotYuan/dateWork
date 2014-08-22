//
//  YZLineDrawingView.m
//  dateWork
//
//  Created by 黄桂源 on 14-1-17.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "YZLineDrawingView.h"

@implementation YZLineDrawingView{
    NSMutableArray *tempPointArray;
    NSMutableString * pointImageName;
    NSMutableArray *tempArray;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        tempPointArray = [NSMutableArray array];
        pointImageName = [NSMutableString string];
        tempArray = [NSMutableArray array];
    }
    return self;
}

- (void) setPointArray:(NSMutableArray *)pointArray withPointImageName:(NSString *)string withTempArray:(NSMutableArray *)array{
    [tempPointArray setArray:pointArray];
    [pointImageName setString:string];
    [tempArray setArray:array];
    
    [self setNeedsDisplay];//调用drawRect
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//[self setNeedsDisplay];重新调用drawRect，因为drawRect只会在开始时调用，所以要重写该方法以调用
 */
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    //设置context
    CGContextRef context = UIGraphicsGetCurrentContext();
    //线颜色
    CGColorRef myColor = [self.aColor CGColor];
    CGContextSetStrokeColorWithColor(context, myColor);
    //线宽
    CGContextSetLineWidth(context, 3.0);
    if ([tempPointArray count]) {
        //起点
        CGPoint myStartPoint = [[tempPointArray objectAtIndex:0] CGPointValue];
        CGContextMoveToPoint(context, myStartPoint.x, myStartPoint.y);
        //（每个终点）从第二个点开始
        for (int i = 1; i < [tempPointArray count]; i++) {
            CGPoint myEndPoint = [[tempPointArray objectAtIndex:i] CGPointValue];
            CGContextAddLineToPoint(context, myEndPoint.x, myEndPoint.y);
        }
        
        for (int i = 0; i < [tempPointArray count]; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:pointImageName]];
            NSValue *value = [tempPointArray objectAtIndex:i];
            CGPoint point = [value CGPointValue];
            imageView.center = point;
            [self addSubview:imageView];
            UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
            tempLabel.textColor = self.linecolor;
            tempLabel.backgroundColor = [UIColor clearColor];
            tempLabel.textAlignment = NSTextAlignmentRight;
            tempLabel.text = [NSString stringWithFormat:@"%@℃", [tempArray objectAtIndex:i]];
            tempLabel.font = [UIFont systemFontOfSize:15];
            CGPoint point1 = [[tempPointArray objectAtIndex:i] CGPointValue];
            tempLabel.center = CGPointMake(point1.x-10, point1.y - 12);
            [self addSubview:tempLabel];
        }
    }
    //把数组里面的点全部画出来
    CGContextStrokePath(context);
}


@end
