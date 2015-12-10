//
//  SalesDashboardController.m
//  XuniExplorer
//
//  Created by kelley.ricker on 10/15/15.
//  Copyright © 2015 GrapeCity. All rights reserved.
//

#import "SalesDashboardTabletController.h"
#import "XuniFlexChartKit/XuniFlexChartKit.h"
#import "XuniFlexPieKit/XuniFlexPieKit.h"
#import "XuniGaugeKit/XuniGaugeKit.h"
#import "DashboardData.h"

@interface SalesDashboardTabletController (){
    FlexChart *chart;
    FlexPie *pie;
    XuniBulletGraph *graph1;
    XuniBulletGraph *graph2;
    XuniBulletGraph *graph3;
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
}
@end

@implementation SalesDashboardTabletController

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
    pie.legend.borderColor = [UIColor whiteColor];
    pie.delegate = self;
    pie.palette = [XuniPalettes organic];
    
    graph1 = [[XuniBulletGraph alloc] init];
    graph1.isReadOnly = true;
    graph1.showText = XuniShowTextAll;
    graph1.format = @"P0";
    graph1.min = 0;
    graph1.max = 1;
    graph1.target = .7;
    graph1.bad = .5;
    graph1.value = .65;
    graph1.pointer.thickness = .7;
    graph1.pointerColor = [UIColor colorWithRed:(137.0/255.0) green:(111.0/255.0) blue: (215.0/255.0)  alpha:1];
    graph1.goodRangeColor = [UIColor colorWithRed:(149.0/255.0) green:(211.0/255.0) blue: (64.0/255.0) alpha:1];
    graph1.badRangeColor = [UIColor colorWithRed:(125.0/255.0) green:(183.0/255.0) blue: (179.0/255.0) alpha:1];
    graph1.targetColor = [UIColor whiteColor];
    graph1.valueFont = [UIFont systemFontOfSize:11];
    
    graph2 = [[XuniBulletGraph alloc] init];
    graph2.isReadOnly = true;
    graph2.showText = XuniShowTextAll;
    graph2.format = @"P0";
    graph2.min = 0;
    graph2.max = 1;
    graph2.target = .7;
    graph2.bad = .5;
    graph2.value = .86;
    graph2.pointer.thickness = .7;
    graph2.pointerColor = [UIColor colorWithRed:(137.0/255.0) green:(111.0/255.0) blue: (215.0/255.0)  alpha:1];
    graph2.goodRangeColor = [UIColor colorWithRed:(149.0/255.0) green:(211.0/255.0) blue: (64.0/255.0) alpha:1];
    graph2.badRangeColor = [UIColor colorWithRed:(125.0/255.0) green:(183.0/255.0) blue: (179.0/255.0) alpha:1];
    graph2.targetColor = [UIColor whiteColor];
    graph2.valueFont = [UIFont systemFontOfSize:11];
    
    graph3 = [[XuniBulletGraph alloc] init];
    graph3.isReadOnly = true;
    graph3.showText = XuniShowTextAll;
    graph3.format = @"P0";
    graph3.min = 0;
    graph3.max = 1;
    graph3.target = .7;
    graph3.bad = .5;
    graph3.value = .53;
    graph3.pointer.thickness = .7;
    graph3.pointerColor = [UIColor colorWithRed:(137.0/255.0) green:(111.0/255.0) blue: (215.0/255.0)  alpha:1];
    graph3.goodRangeColor = [UIColor colorWithRed:(149.0/255.0) green:(211.0/255.0) blue: (64.0/255.0) alpha:1];
    graph3.badRangeColor = [UIColor colorWithRed:(125.0/255.0) green:(183.0/255.0) blue: (179.0/255.0) alpha:1];
    graph3.targetColor = [UIColor whiteColor];
    graph3.valueFont = [UIFont systemFontOfSize:11];
    
    label1 = [[UILabel alloc] init];
    label1.text = @"Sales Goal";
    label1.textAlignment = NSTextAlignmentCenter;
    
    label2 = [[UILabel alloc] init];
    label2.text = @"Downloads Goal";
    label2.textAlignment = NSTextAlignmentCenter;
    
    label3 = [[UILabel alloc] init];
    label3.text = @"Expenses Goal";
    label3.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:graph1];
    [self.view addSubview:graph2];
    [self.view addSubview:graph3];
    [self.view addSubview:label1];
    [self.view addSubview:label2];
    [self.view addSubview:label3];
    
    [self.view addSubview:pie];
    [self.view addSubview:chart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    chart.frame = CGRectMake(0, 0, self.view.bounds.size.width * 2/3, self.view.bounds.size.height);
    pie.frame = CGRectMake(self.view.bounds.size.width * 2/3, 0, self.view.bounds.size.width/3, self.view.bounds.size.height/2);
    graph1.frame = CGRectMake(self.view.bounds.size.width * 2/3, self.view.bounds.size.height * 10/18, self.view.bounds.size.width/3, self.view.bounds.size.height/18);
    graph2.frame = CGRectMake(self.view.bounds.size.width * 2/3, self.view.bounds.size.height * 12/18, self.view.bounds.size.width/3, self.view.bounds.size.height/18);
    graph3.frame = CGRectMake(self.view.bounds.size.width * 2/3, self.view.bounds.size.height * 14/18, self.view.bounds.size.width/3, self.view.bounds.size.height/18);
    label1.frame = CGRectMake(self.view.bounds.size.width * 2/3, self.view.bounds.size.height/2, self.view.bounds.size.width/3, self.view.bounds.size.height/18);
    label2.frame = CGRectMake(self.view.bounds.size.width * 2/3, self.view.bounds.size.height * 11/18, self.view.bounds.size.width/3, self.view.bounds.size.height/18);
    label3.frame = CGRectMake(self.view.bounds.size.width * 2/3, self.view.bounds.size.height * 13/18, self.view.bounds.size.width/3, self.view.bounds.size.height/18);
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
    if([pie.binding isEqual:@"sales"]){
        graph1.value = .88;
        graph2.value = .97;
        graph3.value = .67;
    }
    else if([pie.binding isEqual:@"downloads"]){
        graph1.value = .48;
        graph2.value = .77;
        graph3.value = .27;
    }
    if([pie.binding isEqual:@"expenses"]){
        graph1.value = .38;
        graph2.value = .91;
        graph3.value = .79;
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
