//
//  LegendAndTitlesController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "LegendAndTitlesController.h"
#import "ChartData.h"
@import XuniFlexChartDynamicKit;

@interface LegendAndTitlesController ()
@property (weak, nonatomic) IBOutlet FlexChart *chart;

@end

@implementation LegendAndTitlesController

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
    self.chart.chartType = XuniChartTypeScatter;
    
    self.chart.header = @"Sample Chart";
    self.chart.headerTextColor = [UIColor colorWithRed:0.502 green:0.016 blue:0.302 alpha:1];
    self.chart.headerFont = [UIFont boldSystemFontOfSize:24.0f];
    self.chart.headerTextAlignment = XuniHorizontalAlignmentCenter;
    self.chart.footer = @"2015 GrapeCity, Inc.";
    self.chart.footerTextColor = [UIColor colorWithRed:0.502 green:0.016 blue:0.302 alpha:1];
    self.chart.footerFont = [UIFont systemFontOfSize:16.0f];
    self.chart.footerTextAlignment = XuniHorizontalAlignmentCenter;
    
    self.chart.axisX.title = @"Country";
    self.chart.axisX.titleFont = [UIFont boldSystemFontOfSize:16.0f];
    self.chart.axisX.titleFont = [UIFont italicSystemFontOfSize:16.0f];
    self.chart.axisX.majorGridVisible = YES;
    self.chart.axisY.title = @"Amount";
    self.chart.axisY.titleFont = [UIFont boldSystemFontOfSize:16.0f];
    self.chart.axisY.titleFont = [UIFont italicSystemFontOfSize:16.0f];
    self.chart.axisY.format = @"C0";
}

@end
