//
//  FinancialChartController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "FinancialChartController.h"
@import XuniFlexChartDynamicKit;
#import "FinancialData.h"

@interface FinancialChartController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *switcher;
@property (weak, nonatomic) IBOutlet FlexChart *chart;

@end

@implementation FinancialChartController
- (IBAction)modeSwitched:(id)sender {
    switch (self.switcher.selectedSegmentIndex) {
        case 0:
            self.chart.chartType = XuniChartTypeCandlestick;
            break;
        case 1:
            self.chart.chartType = XuniChartTypeHighLowOpenClose;
            break;
        default:
            break;
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *financialData = [FinancialData demoData];
    self.chart.bindingX = @"date";
    XuniSeries *finance = [[XuniSeries alloc] initForChart:self.chart binding: @"high,low,open,close" name: @"AAPL"];
    
    [self.chart.series addObject:finance];
    self.chart.itemsSource = financialData;
    self.chart.chartType = XuniChartTypeCandlestick;
    self.chart.selectionMode = XuniSelectionModePoint;
    self.chart.axisY.majorGridFill = [UIColor colorWithWhite:0.6 alpha:0.2];
    self.chart.legend.position = XuniChartLegendPositionNone;
    
}



@end
