//
//  CustomizingAxesController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "CustomizingAxesController.h"
#import "FlexChartKit/FlexChartkit.h"
#import "ChartData.h"

@interface CustomizingAxesController ()

@end

@implementation CustomizingAxesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSNumber *max = [[NSNumber alloc] initWithInt:10000];
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
    chart.axisX.title = @"AAAAAA";
    chart.axisY.lineWidth = 2;
    chart.axisY.majorTickWidth = 0;
    chart.axisY.majorGridColor = [UIColor colorWithRed:0.769 green:0.769 blue:0.769 alpha:1];
    chart.axisY.axisLineVisible = true;
    chart.axisY.minorTickWidth = 1;
    chart.axisY.format = @"c0";
    chart.axisY.max = max;
    chart.axisY.majorUnit = 2000;
    
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
