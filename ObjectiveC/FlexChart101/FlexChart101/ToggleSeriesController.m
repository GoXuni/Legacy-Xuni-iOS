//
//  ToggleSeriesController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "ToggleSeriesController.h"
#import "ChartData.h"
#import "FlexChartKit/FlexChartKit.h"

@interface ToggleSeriesController ()

@end

@implementation ToggleSeriesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    FlexChart *chart = [[FlexChart alloc] init];
    UISwitch *salesSwitch = [[UISwitch alloc]init];
    UISwitch *expensesSwitch = [[UISwitch alloc]init];
    UISwitch *downloadsSwitch = [[UISwitch alloc]init];
    UILabel *salesLabel = [[UILabel alloc]init];
    UILabel *expensesLabel = [[UILabel alloc]init];
    UILabel *downloadsLabel = [[UILabel alloc]init];
    
    salesLabel.text = @"Sales";
    expensesLabel.text = @"Expenses";
    downloadsLabel.text = @"Downloads";

    [salesLabel sizeToFit];
    [expensesLabel sizeToFit];
    [downloadsLabel sizeToFit];
    NSMutableArray *chartData = [ChartData demoData];
    chart.bindingX = @"name";
    XuniSeries *sales = [[XuniSeries alloc] initForChart:chart binding:@"sales, sales" name:@"Sales"];
    XuniSeries *expenses = [[XuniSeries alloc] initForChart:chart binding:@"expenses, expenses" name:@"Expenses"];
    XuniSeries *downloads = [[XuniSeries alloc] initForChart:chart binding:@"downloads, downloads" name:@"Downloads"];
    
    [salesSwitch addTarget:self action:@selector(salesSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    [expensesSwitch addTarget:self action:@selector(expensesSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    [downloadsSwitch addTarget:self action:@selector(downloadsSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    salesSwitch.on = true;
    expensesSwitch.on = true;
    downloadsSwitch.on = true;
    
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
    salesSwitch.tag = 2;
    expensesSwitch.tag = 3;
    downloadsSwitch.tag = 4;
    salesLabel.tag = 5;
    expensesLabel.tag = 6;
    downloadsLabel.tag = 7;
    
    [self.view addSubview:chart];
    [self.view addSubview:salesSwitch];
    [self.view addSubview:expensesSwitch];
    [self.view addSubview:downloadsSwitch];
    [self.view addSubview:salesLabel];
    [self.view addSubview:expensesLabel];
    [self.view addSubview:downloadsLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    FlexChart *chart = (FlexChart*)[self.view viewWithTag:1];
    UISwitch *salesSwitch  = (UISwitch*)[self.view viewWithTag:2];
    UISwitch *expensesSwitch  = (UISwitch*)[self.view viewWithTag:3];
    UISwitch *downloadsSwitch = (UISwitch*)[self.view viewWithTag:4];
    UILabel *salesLabel = (UILabel*)[self.view viewWithTag:5];
    UILabel *expensesLabel = (UILabel*)[self.view viewWithTag:6];
    UILabel *downloadsLabel = (UILabel*)[self.view viewWithTag:7];
    
    chart.frame = CGRectMake(0, self.view.bounds.size.height*2/8, self.view.bounds.size.width, self.view.bounds.size.height - (self.view.bounds.size.height*2/8));
    salesSwitch.frame = CGRectMake(self.view.bounds.size.width/12, self.view.bounds.size.height*3/16, self.view.bounds.size.width/6, self.view.bounds.size.height/16);
    expensesSwitch.frame = CGRectMake(self.view.bounds.size.width/2 - self.view.bounds.size.width/12, self.view.bounds.size.height*3/16, self.view.bounds.size.width/6, self.view.bounds.size.height/16);
    downloadsSwitch.frame = CGRectMake(self.view.bounds.size.width*3/4, self.view.bounds.size.height*3/16, self.view.bounds.size.width/6, self.view.bounds.size.height/16);
    salesLabel.frame = CGRectMake(self.view.bounds.size.width/12, self.view.bounds.size.height/8, self.view.bounds.size.width/6, self.view.bounds.size.height/16);
    expensesLabel.frame = CGRectMake(self.view.bounds.size.width/2 - self.view.bounds.size.width/12, self.view.bounds.size.height/8, self.view.bounds.size.width/6, self.view.bounds.size.height/16);
    downloadsLabel.frame = CGRectMake(self.view.bounds.size.width*3/4, self.view.bounds.size.height/8, self.view.bounds.size.width/6, self.view.bounds.size.height/16);
    
    [chart setNeedsDisplay];
}

-(void)salesSwitchChanged:(UISwitch *) switchState{
    FlexChart *chart = (FlexChart*) [self.view viewWithTag:1];
    
    if ([switchState isOn]) {
        ((XuniSeries *)[chart.series objectAtIndex:0]).visibility = XuniSeriesVisibilityVisible;
    }
    else
    {
        ((XuniSeries *)[chart.series objectAtIndex:0]).visibility = XuniSeriesVisibilityHidden;
    }
}
-(void)expensesSwitchChanged:(UISwitch *) switchState{
    FlexChart *chart = (FlexChart*) [self.view viewWithTag:1];
    
    if ([switchState isOn]) {
        ((XuniSeries *)[chart.series objectAtIndex:1]).visibility = XuniSeriesVisibilityVisible;
    }
    else
    {
        ((XuniSeries *)[chart.series objectAtIndex:1]).visibility = XuniSeriesVisibilityHidden;
    }
}
-(void)downloadsSwitchChanged:(UISwitch *) switchState{
    FlexChart *chart = (FlexChart*) [self.view viewWithTag:1];
    
    if ([switchState isOn]) {
        ((XuniSeries *)[chart.series objectAtIndex:2]).visibility = XuniSeriesVisibilityVisible;
    }
    else
    {
        ((XuniSeries *)[chart.series objectAtIndex:2]).visibility = XuniSeriesVisibilityHidden;
    }
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
