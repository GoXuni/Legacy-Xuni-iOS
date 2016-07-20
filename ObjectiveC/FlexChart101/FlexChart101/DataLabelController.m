//
//  DataLabelController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "DataLabelController.h"
#import "ChartData.h"
@import XuniFlexChartDynamicKit;

@interface DataLabelController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSelector;
@property (weak, nonatomic) IBOutlet FlexChart *chart;

@end

@implementation DataLabelController

- (IBAction)modeChanged:(id)sender {
    int row = self.modeSelector.selectedSegmentIndex;
    if (row == 0) {
        self.chart.dataLabel.position = FlexChartDataLabelPositionNone;
    }
    else if (row == 1){
        self.chart.dataLabel.position = FlexChartDataLabelPositionLeft;
    }
    else if (row == 2){
        self.chart.dataLabel.position = FlexChartDataLabelPositionTop;
    }
    else if (row == 3){
        self.chart.dataLabel.position = FlexChartDataLabelPositionRight;
    }
    else if (row == 4){
        self.chart.dataLabel.position = FlexChartDataLabelPositionBottom;
    }
    else if (row == 5){
        self.chart.dataLabel.position = FlexChartDataLabelPositionCenter;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSMutableArray *chartData = [ChartData demoData];
    
    self.chart.bindingX = @"name";
    XuniSeries *expenses = [[XuniSeries alloc] initForChart:self.chart binding:@"expenses" name:@"Total Expenses"];
    [self.chart.series addObject:expenses];
    
    self.chart.itemsSource = chartData;
    self.chart.chartType = XuniChartTypeBar;
    self.chart.isAnimated = NO;
    self.chart.tooltip.isVisible = NO;
    self.chart.axisX.majorGridVisible = YES;
    self.chart.axisY.labelsVisible = NO;
    self.chart.axisY.majorGridVisible = NO;
    self.chart.axisY.minorGridVisible = NO;
    self.chart.axisY.majorTickWidth = 0;
    self.chart.palette = [XuniPalettes organic];
    
    self.chart.dataLabel.content= @"{x} {y}";
    self.chart.dataLabel.dataLabelFormat = @"F2";
    self.chart.dataLabel.position = FlexChartDataLabelPositionLeft;
    self.chart.dataLabel.dataLabelFontColor = [UIColor redColor];
    self.chart.dataLabel.dataLabelBackgroundColor = [UIColor whiteColor];
    self.chart.dataLabel.dataLabelBorderColor = [UIColor blueColor];
    self.chart.dataLabel.dataLabelBorderWidth = 1;
    self.chart.dataLabel.dataLabelFont = [UIFont systemFontOfSize:15];
    
    
    _modeSelector.selectedSegmentIndex = 1;
}

@end
