//
//  LegendAndTitlesController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "LegendAndTitlesController.h"
#import "ChartData.h"
#import "FlexChartKit/FlexChartKit.h"

@interface LegendAndTitlesController ()

@end

@implementation LegendAndTitlesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    FlexChart *chart = [[FlexChart alloc] init];
    NSMutableArray *chartData = [ChartData demoData];
    chart.bindingX = @"name";
    XuniSeries *sales = [[XuniSeries alloc] initForChart:chart binding:@"sales, sales" name:@"Sales"];
    XuniSeries *expenses = [[XuniSeries alloc] initForChart:chart binding:@"expenses, expenses" name:@"Expenses"];
    XuniSeries *downloads = [[XuniSeries alloc] initForChart:chart binding:@"downloads, downloads" name:@"Downloads"];
    
    [chart.series addObject:sales];
    [chart.series addObject:expenses];
    [chart.series addObject:downloads];
    
    chart.itemsSource = chartData;
    chart.axisX.labelsVisible = true;
    chart.axisY.labelsVisible = true;
    chart.header = @"Sample Chart";
    chart.headerTextColor = [UIColor colorWithRed:0.502 green:0.016 blue:0.302 alpha:1];
    chart.headerFont = [UIFont boldSystemFontOfSize:24.0f];
    chart.headerTextAlignment = XuniHorizontalAlignmentCenter;
    chart.footer = @"2015 GrapeCity, Inc.";
    chart.footerTextColor = [UIColor colorWithRed:0.502 green:0.016 blue:0.302 alpha:1];
    chart.footerFont = [UIFont systemFontOfSize:16.0f];
    chart.footerTextAlignment = XuniHorizontalAlignmentCenter;
    chart.axisX.title = @"Country";
    chart.axisX.titleFont = [UIFont boldSystemFontOfSize:16.0f];
    chart.axisX.titleFont = [UIFont italicSystemFontOfSize:16.0f];
    chart.axisY.title = @"Amount";
    chart.axisY.titleFont = [UIFont boldSystemFontOfSize:16.0f];
    chart.axisY.titleFont = [UIFont italicSystemFontOfSize:16.0f];
    chart.axisY.format = @"c0";

    chart.legend.orientation = XuniChartLegendOrientationAuto;
    chart.legend.position = XuniChartLegendPositionAuto;
    chart.tooltip.isVisible = true;
    
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
