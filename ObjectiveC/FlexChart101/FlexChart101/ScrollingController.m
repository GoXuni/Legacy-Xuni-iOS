//
//  ScrollingController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "ScrollingController.h"
@import XuniFlexChartDynamicKit;
#import "WeatherData.h"

@interface ScrollingController ()
@property (weak, nonatomic) IBOutlet FlexChart *chart;

@end

@implementation ScrollingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FlexChart *chart = self.chart;
    NSMutableArray *chartData = [WeatherData demoData];
    
    XuniSeries *precip = [[XuniSeries alloc] initForChart:chart binding:@"precipitation" name:@"Precip"];
    XuniSeries *temp= [[XuniSeries alloc] initForChart:chart binding:@"temp" name:@"Temp"];
    temp.chartType = XuniChartTypeSpline;
    XuniSeries *volume= [[XuniSeries alloc] initForChart:chart binding:@"volume" name:@"Volume"];
    volume.chartType = XuniChartTypeSpline;
    
    XuniAxis *axisT = [[XuniAxis alloc] initWithPosition:XuniPositionRight forChart:chart];
    axisT.min = @20;
    axisT.max = @80;
    axisT.majorUnit = 5;
    axisT.title = @"Volume";
    axisT.axisLineVisible = NO;
    axisT.majorGridVisible = NO;
    axisT.majorTickWidth = 0;
    axisT.labelsVisible = YES;
    [chart.axesArray addObject:axisT];

    chart.chartType = XuniChartTypeColumn;
    chart.bindingX = @"index";
    chart.itemsSource = chartData;
    chart.zoomMode = XuniZoomModeX;
    chart.axisY.min = @4;
    chart.axisY.max = @20;
    chart.axisY.majorUnit = 2;
    chart.axisY.axisLineVisible = NO;
    chart.axisY.majorTickWidth = 0;
    chart.axisX.labelAngle = 90;
    chart.axisX.majorGridVisible = NO;
    chart.axisX.displayedRange = 10;
    chart.palette = [XuniPalettes midnight];
    chart.header = @"Drag to scroll/Pinch to zoom";
    chart.headerFont = [UIFont systemFontOfSize:14];
    chart.headerTextAlignment = XuniHorizontalAlignmentCenter;
    
    [temp setAxisY:axisT];
    [volume setAxisY:axisT];
    [chart.series addObject:precip];
    [chart.series addObject:temp];
    [chart.series addObject:volume];
    
}



@end
