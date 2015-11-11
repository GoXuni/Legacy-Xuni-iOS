//
//  ScrollingController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "ScrollingController.h"
#import "XuniFlexChartKit/XuniFlexChartKit.h"
#import "WeatherData.h"

@interface ScrollingController ()

@end

@implementation ScrollingController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Scrolling"];
    
    // Do any additional setup after loading the view.
    FlexChart *chart = [[FlexChart alloc] init];
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
