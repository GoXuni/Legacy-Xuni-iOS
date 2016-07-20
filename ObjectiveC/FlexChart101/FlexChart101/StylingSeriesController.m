//
//  StylingSeriesController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "StylingSeriesController.h"
@import XuniFlexChartDynamicKit;
#import "ChartData.h"

@interface StylingSeriesController ()
@property (weak, nonatomic) IBOutlet FlexChart *chart;

@end

@implementation StylingSeriesController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FlexChart *chart = self.chart;
    XuniSeries *sales = [[XuniSeries alloc] initForChart:chart binding:@"sales" name:@"Sales"];
    XuniSeries *expenses = [[XuniSeries alloc] initForChart:chart binding:@"expenses" name:@"Expenses"];
    XuniSeries *downloads = [[XuniSeries alloc] initForChart:chart binding:@"downloads" name:@"Downloads"];
    
    sales.color = [UIColor purpleColor];
    sales.borderColor = [UIColor greenColor];
    sales.borderWidth = 2;
    expenses.color = [UIColor redColor];
    expenses.borderColor = [UIColor colorWithRed:.502 green:0 blue:0 alpha:1];
    expenses.borderWidth = 2;
    downloads.chartType = XuniChartTypeLineSymbols;
    downloads.color = [UIColor colorWithRed:1 green:0.416 blue:0 alpha:1];
    downloads.borderWidth = 10;
    downloads.symbolColor = [UIColor yellowColor];
    downloads.symbolBorderColor = [UIColor yellowColor];
    downloads.symbolBorderWidth = 5;
    [chart.series addObject:sales];
    [chart.series addObject:expenses];
    [chart.series addObject:downloads];
    
    chart.bindingX = @"name";
    chart.itemsSource = [ChartData demoData];
    
}


@end
