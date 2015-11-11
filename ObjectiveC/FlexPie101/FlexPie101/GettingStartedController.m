//
//  GettingStartedController.m
//  FlexPie101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "GettingStartedController.h"
#import "XuniFlexPieKit/XuniFlexPieKit.h"
#import "PieChartData.h"

@interface GettingStartedController ()

@end

@implementation GettingStartedController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view.
    
    FlexPie *pieChart = [[FlexPie alloc] init];
    FlexPie *donutChart = [[FlexPie alloc] init];
    NSMutableArray *pieData = [PieChartData demoData];
    
    pieChart.binding = @"value";
    pieChart.bindingName = @"name";
    pieChart.itemsSource = pieData;
    pieChart.tooltip.isVisible = true;
    donutChart.binding = @"value";
    donutChart.bindingName = @"name";
    donutChart.itemsSource = pieData;
    donutChart.tooltip.isVisible = true;
    donutChart.innerRadius = 0.6;
    pieChart.tag = 1;
    donutChart.tag = 2;
    
    [self.view addSubview:pieChart];
    [self.view addSubview:donutChart];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    FlexPie *pieChart= (FlexPie*)[self.view viewWithTag:1];
    FlexPie *donutChart = (FlexPie*)[self.view viewWithTag:2];
    pieChart.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height/3);
    donutChart.frame = CGRectMake(0, self.view.bounds.size.height/2, self.view.bounds.size.width, self.view.bounds.size.height/3);
}/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
