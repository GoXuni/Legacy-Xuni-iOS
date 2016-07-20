//
//  CustomTooltipsController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "CustomTooltipsController.h"
@import XuniFlexChartDynamicKit;
@import XuniChartCoreDynamicKit;
#import "ChartData.h"

@interface CustomTooltipsController (){
    MyTooltip *t;
}
@property (weak, nonatomic) IBOutlet FlexChart *chart;
@end

@implementation CustomTooltipsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *chartData = [ChartData demoData];
    self.chart.bindingX = @"name";
    XuniSeries *sales = [[XuniSeries alloc] initForChart:self.chart binding:@"sales, sales" name:@"Sales"];
    XuniSeries *expenses = [[XuniSeries alloc] initForChart:self.chart binding:@"expenses, expenses" name:@"Expenses"];
    XuniSeries *downloads = [[XuniSeries alloc] initForChart:self.chart binding:@"downloads, downloads" name:@"Downloads"];
    
    [self.chart.series addObject:sales];
    [self.chart.series addObject:expenses];
    [self.chart.series addObject:downloads];
    
    self.chart.itemsSource = chartData;
    self.chart.stacking = XuniStackingStacked;
    self.chart.palette = [XuniPalettes zen];
    self.chart.loadAnimation.animationMode = XuniAnimationModeSeries;
    self.chart.axisY.axisLineVisible = NO;
    self.chart.axisY.majorUnit = 2000;
    
    t = [[MyTooltip alloc] init];
    t.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0.792 alpha:1];
    self.chart.tooltip.content = t;
    
}

@end

@interface MyTooltip (){
    UILabel *label;
    UIImage *image;
    UIImageView *imageView;
    CGFloat tooltipWidth;
    CGFloat tooltipHeight;
}
@end


@implementation MyTooltip

-(void)setChartData:(XuniDataPoint *)chartData{
    XuniChartDataPoint *cdpt = (XuniChartDataPoint *)chartData;
    NSNumber *countryNum = [NSNumber numberWithDouble:cdpt.pointIndex];

    if (label == nil  && imageView == nil) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/4, 0, self.bounds.size.width*3/4, self.bounds.size.height)];
        label.textColor = [UIColor blackColor];

        label.numberOfLines = 3;
        label.text = [NSString stringWithFormat:@"%@ \n\n $%.2f", cdpt.seriesName, cdpt.value];
        label.font = [label.font fontWithSize:11];
        image = [UIImage imageNamed:[countryNum stringValue]];
        imageView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:imageView];
        [self addSubview:label];
    }
    else{
        image = [UIImage imageNamed:[countryNum stringValue]];
        [imageView setImage:image];
        label.text = [NSString stringWithFormat:@"%@ \n\n $%.2f", cdpt.seriesName, cdpt.value];
        [imageView setNeedsLayout];
        [label setNeedsLayout];
    }
}
-(void)_render{
    //prevents drawing of default tooltip
}
-(CGRect)_getFrameRect:(CGRect)contentFrame senderPoint:(CGPoint)senderPoint{
        tooltipHeight = 50;
        tooltipWidth = 100;
        if (([UIScreen mainScreen].bounds.size.width - senderPoint.x) < tooltipWidth  && ([UIScreen mainScreen].bounds.size.height - senderPoint.y) < tooltipHeight){
            return CGRectMake(([UIScreen mainScreen].bounds.size.width - tooltipWidth), ([UIScreen mainScreen].bounds.size.height - tooltipHeight), tooltipWidth, tooltipHeight);
        }
        else if (([UIScreen mainScreen].bounds.size.width - senderPoint.x) < tooltipWidth){
            return CGRectMake(([UIScreen mainScreen].bounds.size.width - tooltipWidth), senderPoint.y, tooltipWidth, tooltipHeight);
        }
        else if (([UIScreen mainScreen].bounds.size.height - senderPoint.y) < tooltipHeight){
            return CGRectMake(senderPoint.x, ([UIScreen mainScreen].bounds.size.height - tooltipHeight), tooltipWidth, tooltipHeight);
        }
        else{
            return CGRectMake(senderPoint.x, senderPoint.y, tooltipWidth, tooltipHeight);
        }
}
-(CGRect)_getContentFrameRect:(CGRect)contentFrame senderPoint:(CGPoint)senderPoint{
    tooltipHeight = 50;
    tooltipWidth = 100;
    if (([UIScreen mainScreen].bounds.size.width - senderPoint.x) < tooltipWidth  && ([UIScreen mainScreen].bounds.size.height - senderPoint.y) < tooltipHeight){
        return CGRectMake(([UIScreen mainScreen].bounds.size.width - tooltipWidth), ([UIScreen mainScreen].bounds.size.height - tooltipHeight), tooltipWidth, tooltipHeight);
    }
    else if (([UIScreen mainScreen].bounds.size.width - senderPoint.x) < tooltipWidth){
        return CGRectMake(([UIScreen mainScreen].bounds.size.width - tooltipWidth), senderPoint.y, tooltipWidth, tooltipHeight);
    }
    else if (([UIScreen mainScreen].bounds.size.height - senderPoint.y) < tooltipHeight){
        return CGRectMake(senderPoint.x, ([UIScreen mainScreen].bounds.size.height - tooltipHeight), tooltipWidth, tooltipHeight);
    }
    else{
        return CGRectMake(senderPoint.x, senderPoint.y, tooltipWidth, tooltipHeight);
    }
}
@end
