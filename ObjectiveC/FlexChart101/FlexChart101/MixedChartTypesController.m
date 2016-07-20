//
//  MixedChartTypesController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "MixedChartTypesController.h"
#import "ChartData.h"
@import XuniFlexChartDynamicKit;

@interface MixedChartTypesController ()
@property (weak, nonatomic) IBOutlet FlexChart *chart;

@end

@implementation MixedChartTypesController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *chartData = [ChartData demoData];
    self.chart.bindingX = @"name";
    XuniSeries *sales = [[XuniSeries alloc] initForChart:self.chart binding:@"sales, sales" name:@"Sales"];
    XuniSeries *expenses = [[XuniSeries alloc] initForChart:self.chart binding:@"expenses, expenses" name:@"Expenses"];
    XuniSeries *downloads = [[XuniSeries alloc] initForChart:self.chart binding:@"downloads, downloads" name:@"Downloads"];
    downloads.chartType = XuniChartTypeLine;
    
    [self.chart.series addObject:sales];
    [self.chart.series addObject:expenses];
    [self.chart.series addObject:downloads];
    self.chart.itemsSource = chartData;
    
}



@end
