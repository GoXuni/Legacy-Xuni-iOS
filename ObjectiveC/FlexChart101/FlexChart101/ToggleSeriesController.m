//
//  ToggleSeriesController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "ToggleSeriesController.h"
#import "ChartData.h"
@import XuniFlexChartDynamicKit;

@interface ToggleSeriesController ()
@property (weak, nonatomic) IBOutlet FlexChart *chart;

@end

@implementation ToggleSeriesController
- (IBAction)switchChanged:(id)sender {
    UISwitch* switchState = (UISwitch*)sender;
    int index = switchState.tag;
    if ([switchState isOn]) {
        ((XuniSeries *)[self.chart.series objectAtIndex:index]).visibility = XuniSeriesVisibilityVisible;
    }
    else
    {
        ((XuniSeries *)[self.chart.series objectAtIndex:index]).visibility = XuniSeriesVisibilityHidden;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSMutableArray *chartData = [ChartData demoData];
    FlexChart *chart = self.chart;
    
    XuniSeries *sales = [[XuniSeries alloc] initForChart:chart binding:@"sales, sales" name:@"Sales"];
    XuniSeries *expenses = [[XuniSeries alloc] initForChart:chart binding:@"expenses, expenses" name:@"Expenses"];
    XuniSeries *downloads = [[XuniSeries alloc] initForChart:chart binding:@"downloads, downloads" name:@"Downloads"];
    [chart.series addObject:sales];
    [chart.series addObject:expenses];
    [chart.series addObject:downloads];
    
    chart.bindingX = @"name";
    chart.itemsSource = chartData;
    chart.chartType = XuniChartTypeLineSymbols;
    chart.selectionMode = XuniSelectionModeSeries;
    
}


@end
