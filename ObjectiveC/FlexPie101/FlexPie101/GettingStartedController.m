//
//  GettingStartedController.m
//  FlexPie101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "GettingStartedController.h"
@import XuniFlexPieDynamicKit;
#import "PieChartData.h"

@interface GettingStartedController ()
@property (weak, nonatomic) IBOutlet FlexPie *pieChart;
@property (weak, nonatomic) IBOutlet FlexPie *donutChart;

@end

@implementation GettingStartedController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view.
    
    NSMutableArray *pieData = [PieChartData demoData];
    
    self.pieChart.binding = @"value";
    self.pieChart.bindingName = @"name";
    self.pieChart.itemsSource = pieData;
    self.pieChart.tooltip.isVisible = true;
    self.donutChart.binding = @"value";
    self.donutChart.bindingName = @"name";
    self.donutChart.itemsSource = pieData;
    self.donutChart.tooltip.isVisible = true;
    self.donutChart.innerRadius = 0.6;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
