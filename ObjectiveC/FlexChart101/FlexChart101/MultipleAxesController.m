//
//  MultipleAxesController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "MultipleAxesController.h"
@import XuniFlexChartDynamicKit;
#import "WeatherData.h"

@interface MultipleAxesController ()
@property (weak, nonatomic) IBOutlet FlexChart *chart;

@end

@implementation MultipleAxesController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *chartData = [WeatherData demoData];
    self.chart.bindingX = @"monthName";
    XuniSeries *precip = [[XuniSeries alloc] initForChart:self.chart binding:@"precipitation, precipitation" name:@"Precip"];
    XuniSeries *temp= [[XuniSeries alloc] initForChart:self.chart binding:@"temp, temp" name:@"Avg. Temp"];
    temp.chartType = XuniChartTypeSplineSymbols;
    
    XuniAxis *axisT = [[XuniAxis alloc] initWithPosition:XuniPositionRight forChart:self.chart];
    axisT.min = @0;
    axisT.max = @80;
    axisT.majorUnit = 10;
    axisT.title = @"Avg. Temperature (F)";
    axisT.axisLineVisible = NO;
    axisT.majorGridVisible = NO;
    axisT.majorGridWidth = 1;
    axisT.minorTickWidth = 0;
    axisT.titleTextColor = [UIColor colorWithRed:0.984 green:0.698 blue:0.345 alpha:1];
    axisT.labelsVisible = YES;
    [self.chart.axesArray addObject:axisT];

    self.chart.itemsSource = chartData;
    self.chart.axisY.min = @4;
    self.chart.axisY.max = @20;
    self.chart.axisY.majorUnit = 2;
    self.chart.axisY.title = @"Precipitation (in)";
    self.chart.axisY.axisLineVisible = NO;
    self.chart.axisY.majorTickWidth = 1;
    self.chart.axisY.minorTickWidth = 0;
    self.chart.axisY.titleTextColor = [UIColor colorWithRed:0.533 green:0.741 blue:0.902 alpha:1];
    self.chart.axisX.labelAngle = 90;
    self.chart.axisX.majorGridVisible = NO;
    self.chart.legend.position = XuniChartLegendPositionNone;
    
    [temp setAxisY:axisT];
    [self.chart.series addObject:precip];
    [self.chart.series addObject:temp];
}


@end
