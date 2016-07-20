//
//  GettingStartedController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "GettingStartedController.h"

#import "ChartData.h"
@import XuniFlexChartDynamicKit;

@interface GettingStartedController ()
@property (weak, nonatomic) IBOutlet FlexChart *chart;

@end

@implementation GettingStartedController

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
}


@end
