//
//  BubbleChartController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "BubbleChartController.h"
#import "ChartData.h"
@import XuniFlexChartDynamicKit;

@interface BubbleChartController ()
@property (weak, nonatomic) IBOutlet FlexChart *chart;

@end

@implementation BubbleChartController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSMutableArray *chartData = [ChartData demoData];
    self.chart.bindingX = @"name";
    XuniSeries *sales    = [[XuniSeries alloc] initForChart:self.chart binding:@"sales, downloads" name:@"Sales"];
    XuniSeries *expenses = [[XuniSeries alloc] initForChart:self.chart binding:@"expenses, downloads" name:@"Expenses"];

    [ self.chart.series addObject:sales];
    [ self.chart.series addObject:expenses];
    self.chart.chartType                   = XuniChartTypeBubble;
    self.chart.itemsSource                 = chartData;
    self.chart.loadAnimation.animationMode = XuniAnimationModeSeries;

    self.chart.tag = 1;
    [self.view addSubview:self.chart];
}

@end
