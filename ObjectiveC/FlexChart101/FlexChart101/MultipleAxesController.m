//
//  MultipleAxesController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "MultipleAxesController.h"
#import "XuniFlexChartKit/XuniFlexChartKit.h"
#import "WeatherData.h"

@interface MultipleAxesController ()

@end

@implementation MultipleAxesController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:NSLocalizedString(@"Multiple Axes", nil)];
    
    // Do any additional setup after loading the view.
    FlexChart *chart = [[FlexChart alloc] init];
    NSMutableArray *chartData = [WeatherData demoData];
    chart.bindingX = @"monthName";
    XuniSeries *precip = [[XuniSeries alloc] initForChart:chart binding:@"precipitation, precipitation" name:@"Precip"];
    XuniSeries *temp= [[XuniSeries alloc] initForChart:chart binding:@"temp, temp" name:@"Avg. Temp"];
    temp.chartType = XuniChartTypeSplineSymbols;
    
    XuniAxis *axisT = [[XuniAxis alloc] initWithPosition:XuniPositionRight forChart:chart];
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
    [chart.axesArray addObject:axisT];

    chart.itemsSource = chartData;
    chart.axisY.min = @4;
    chart.axisY.max = @20;
    chart.axisY.majorUnit = 2;
    chart.axisY.title = @"Precipitation (in)";
    chart.axisY.axisLineVisible = NO;
    chart.axisY.majorTickWidth = 1;
    chart.axisY.minorTickWidth = 0;
    chart.axisY.titleTextColor = [UIColor colorWithRed:0.533 green:0.741 blue:0.902 alpha:1];
    chart.axisX.labelAngle = 90;
    chart.axisX.majorGridVisible = NO;
    chart.legend.position = XuniChartLegendPositionNone;
    
    [temp setAxisY:axisT];
    [chart.series addObject:precip];
    [chart.series addObject:temp];
    
    chart.tag = 1;
    [self.view addSubview:chart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    FlexChart *chart = (FlexChart*)[self.view viewWithTag:1];
    chart.frame = CGRectMake(0, 65, self.view.bounds.size.width, self.view.bounds.size.height - 65);
    [chart setNeedsDisplay];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
