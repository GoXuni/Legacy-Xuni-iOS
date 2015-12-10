//
//  SalesDashboardController.m
//  XuniExplorer
//
//  Created by kelley.ricker on 10/15/15.
//  Copyright © 2015 GrapeCity. All rights reserved.
//

#import "SalesDashboardController.h"
#import "XuniFlexChartKit/XuniFlexChartKit.h"
#import "XuniFlexPieKit/XuniFlexPieKit.h"
#import "XuniGaugeKit/XuniGaugeKit.h"
#import "DashboardData.h"

@interface SalesDashboardController (){
    FlexChart *chart;
    FlexPie *pie;
    XuniBulletGraph *graph;
}
@end

@implementation SalesDashboardController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"Sales Dashboard";
    chart = [[FlexChart alloc] init];
    chart.chartType = XuniChartTypeColumn;
    NSMutableArray *dashData = [DashboardData demoData];
    chart.bindingX = @"quarter";
    XuniSeries *sales = [[XuniSeries alloc] initForChart:chart binding:@"sales, sales" name:@"Sales"];
    XuniSeries *expenses = [[XuniSeries alloc] initForChart:chart binding:@"expenses, expenses" name:@"Expenses"];
    XuniSeries *downloads = [[XuniSeries alloc] initForChart:chart binding:@"downloads, downloads" name:@"Downloads"];
    
    [chart.series addObject:sales];
    [chart.series addObject:expenses];
    [chart.series addObject:downloads];
    
    chart.itemsSource = dashData;
    chart.axisX.labelsVisible = true;
    chart.axisY.labelsVisible = true;
    chart.header = @"Financial Information";
    chart.legend.orientation = XuniChartLegendOrientationAuto;
    chart.legend.position = XuniChartLegendPositionAuto;
    chart.tooltip.isVisible = true;
    chart.axisY.axisLineVisible = false;
    chart.delegate = self;
    chart.userInteractionEnabled = true;
    chart.selectionMode = XuniSelectionModeSeries;
    chart.palette = [XuniPalettes organic];
    
    pie = [[FlexPie alloc] init];
    pie.binding = @"sales";
    pie.bindingName = @"quarter";
    pie.itemsSource = dashData;
    pie.header = @"Sales";
    pie.legend.orientation = XuniChartLegendOrientationAuto;
    pie.innerRadius = .5;
    pie.updateAnimation.duration = 1;
    pie.palette = [XuniPalettes organic];
    
    graph = [[XuniBulletGraph alloc] init];
    graph.isReadOnly = true;
    graph.showText = XuniShowTextAll;
    graph.format = @"P0";
    graph.min = 0;
    graph.max = 1;
    graph.target = .7;
    graph.bad = .5;
    graph.value = .73;
    graph.pointer.thickness = .7;
    graph.pointerColor = [UIColor colorWithRed:(137.0/255.0) green:(111.0/255.0) blue: (215.0/255.0)  alpha:1];
    graph.goodRangeColor = [UIColor colorWithRed:(149.0/255.0) green:(211.0/255.0) blue: (64.0/255.0) alpha:1];
    graph.badRangeColor = [UIColor colorWithRed:(125.0/255.0) green:(183.0/255.0) blue: (179.0/255.0) alpha:1];
    graph.targetColor = [UIColor whiteColor];
    [self.view addSubview:graph];
    [self.view addSubview:pie];
    [self.view addSubview:chart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    chart.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height * 2/5);
    pie.frame = CGRectMake(0, self.view.bounds.size.height * 2/5, self.view.bounds.size.width, self.view.bounds.size.height * 2/5);
    graph.frame = CGRectMake(0, self.view.bounds.size.height * 13/15, self.view.bounds.size.width, self.view.bounds.size.height/10);
}
-(void)selectionChanged:(XuniHitTestInfo *)hitTestInfo{
    if([hitTestInfo.series.name  isEqual: @"Sales"]){
        pie.binding = @"sales";
        pie.header = @"Sales";
    }
    else if ([hitTestInfo.series.name  isEqual: @"Downloads"]){
        pie.binding = @"downloads";
        pie.header = @"Downloads";
    }
    else if ([hitTestInfo.series.name  isEqual: @"Expenses"]){
        pie.binding = @"expenses";
        pie.header = @"Expenses";
    }
    [pie refresh];
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
