//
//  StylingSeriesController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "StylingSeriesController.h"
#import "FlexChartKit/FlexChartKit.h"
#import "ChartData.h"

@interface StylingSeriesController ()

@end

@implementation StylingSeriesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    FlexChart *chart = [[FlexChart alloc] init];
    NSMutableArray *chartData = [ChartData demoData];
    chart.bindingX = @"name";
    XuniSeries *sales = [[XuniSeries alloc] initForChart:chart binding:@"sales, sales" name:@"Sales"];
    XuniSeries *expenses = [[XuniSeries alloc] initForChart:chart binding:@"expenses, expenses" name:@"Expenses"];
    XuniSeries *downloads = [[XuniSeries alloc] initForChart:chart binding:@"downloads, downloads" name:@"Downloads"];
    sales.color = [UIColor greenColor];
    sales.borderColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:1];
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
    
    chart.itemsSource = chartData;
    chart.axisX.labelsVisible = true;
    chart.axisY.labelsVisible = true;
    
    chart.legend.orientation = XuniChartLegendOrientationAuto;
    chart.legend.position = XuniChartLegendPositionAuto;
    chart.tooltip.visible = true;
    
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
    chart.frame = CGRectMake(0, 55, self.view.bounds.size.width, self.view.bounds.size.height - 55);
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
