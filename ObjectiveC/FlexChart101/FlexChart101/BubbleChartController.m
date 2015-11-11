//
//  BubbleChartController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "BubbleChartController.h"
#import "ChartData.h"
#import "XuniFlexChartKit/XuniFlexChartKit.h"

@interface BubbleChartController ()

@end

@implementation BubbleChartController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Bubble Chart"];
    
    // Do any additional setup after loading the view.
    FlexChart *chart = [[FlexChart alloc] init];
    NSMutableArray *chartData = [ChartData demoData];
    chart.bindingX = @"name";
    XuniSeries *sales = [[XuniSeries alloc] initForChart:chart binding:@"sales, downloads" name:@"Sales"];
    XuniSeries *expenses = [[XuniSeries alloc] initForChart:chart binding:@"expenses, downloads" name:@"Expenses"];
    
    [chart.series addObject:sales];
    [chart.series addObject:expenses];
    chart.chartType = XuniChartTypeBubble;
    chart.itemsSource = chartData;
    chart.loadAnimation.animationMode = XuniAnimationModeSeries;
    
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
