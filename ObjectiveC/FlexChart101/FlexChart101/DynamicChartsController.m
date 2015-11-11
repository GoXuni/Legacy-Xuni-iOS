//
//  DynamicChartsController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//


#import "DynamicChartsController.h"
#import "XuniFlexChartKit/XuniFlexChartKit.h"
#import "DynamicChartData.h"

@interface DynamicChartsController (){
    NSMutableArray *chartData;
}

@end

@implementation DynamicChartsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Dynamic Charts"];
    
    // Do any additional setup after loading the view.
    FlexChart *chart = [[FlexChart alloc] init];
    chartData = [DynamicChartData demoData];
    chart.bindingX = @"time";
    XuniSeries *trucks = [[XuniSeries alloc] initForChart:chart binding:@"trucks, trucks" name:@"Trucks"];
    XuniSeries *ships = [[XuniSeries alloc] initForChart:chart binding:@"ships, ships" name:@"Ships"];
    XuniSeries *planes = [[XuniSeries alloc] initForChart:chart binding:@"planes, planes" name:@"Planes"];
    
    [chart.series addObject:trucks];
    [chart.series addObject:ships];
    [chart.series addObject:planes];
    
    chart.itemsSource = chartData;
    chart.chartType = XuniChartTypeLine;
    chart.palette = [XuniPalettes coral];
    chart.tooltip.isVisible = false;
    
    NSDate *d = [NSDate dateWithTimeIntervalSinceNow: chart.loadAnimation.duration + 0.1];
    NSTimer *timer = [[NSTimer alloc] initWithFireDate:d
                                              interval:1
                                                target:self
                                              selector:@selector(onTick)
                                              userInfo:nil
                                               repeats:YES];
    NSRunLoop *runner = [NSRunLoop currentRunLoop];
    [runner addTimer:timer forMode: NSDefaultRunLoopMode];
    
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

-(void)onTick{
    FlexChart *chart = (FlexChart *)[self.view viewWithTag:1];
    chart.isAnimated = NO;
    chart.itemsSource = [DynamicChartData dynamicData:chartData];
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
