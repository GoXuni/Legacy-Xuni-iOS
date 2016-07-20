//
//  DynamicChartsController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//


#import "DynamicChartsController.h"
@import XuniFlexChartDynamicKit;
#import "DynamicChartData.h"

@interface DynamicChartsController (){
    NSMutableArray *chartData;
}
@property (weak, nonatomic) IBOutlet FlexChart *chart;

@end

@implementation DynamicChartsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FlexChart *chart = self.chart;
    chartData = [DynamicChartData demoData];
    chart.bindingX = @"time";
    XuniSeries *trucks = [[XuniSeries alloc] initForChart:chart binding:@"trucks, trucks" name:@"Trucks"];
    XuniSeries *ships = [[XuniSeries alloc] initForChart:chart binding:@"ships, ships" name:@"Ships"];
    XuniSeries *planes = [[XuniSeries alloc] initForChart:chart binding:@"planes, planes" name:@"Planes"];
    
    [chart.series addObject:trucks];
    [chart.series addObject:ships];
    [chart.series addObject:planes];
    
    chart.itemsSource = chartData;
    chart.chartType = XuniChartTypeLine;
    chart.palette = [XuniPalettes coral];
    chart.tooltip.isVisible = false;
    
    chart.loadAnimation.animationMode = XuniAnimationModePoint;
    
    NSDate *d = [NSDate dateWithTimeIntervalSinceNow: chart.loadAnimation.duration + 0.1];
    NSTimer *timer = [[NSTimer alloc] initWithFireDate:d
                                              interval:1
                                                target:self
                                              selector:@selector(onTick)
                                              userInfo:nil
                                               repeats:YES];
    NSRunLoop *runner = [NSRunLoop currentRunLoop];
    [runner addTimer:timer forMode: NSDefaultRunLoopMode];
    
}

-(void)onTick{
    FlexChart *chart = self.chart;
    chart.isAnimated = NO;
    chart.itemsSource = [DynamicChartData dynamicData:chartData];
}

@end
