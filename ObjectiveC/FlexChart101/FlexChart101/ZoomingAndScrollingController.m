//
//  ZoomingAndScrollingController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "ZoomingAndScrollingController.h"
#import "FlexChartKit/FlexChartKit.h"
#import "ChartData.h"

@interface ZoomingAndScrollingController (){
    NSMutableArray *pickerData;
}

@end

@implementation ZoomingAndScrollingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    pickerData =[[NSMutableArray alloc] initWithObjects:@"X", @"Y", @"XY", @"Disabled", nil];
    UILabel *label = [[UILabel alloc] init];
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    FlexChart *chart = [[FlexChart alloc] init];
    NSMutableArray *chartData = [ChartData demoData];
    
    label.text = @"Zoom Mode";
    
    pickerView.delegate = self;
    pickerView.showsSelectionIndicator = YES;
    pickerView.hidden = false;
    [pickerView selectRow:2 inComponent:0 animated:false];
    
    chart.zoomMode = XuniZoomModeXY;
    
    chart.bindingX = @"name";
    XuniSeries *sales = [[XuniSeries alloc] initForChart:chart binding:@"sales, sales" name:@"Sales"];
    XuniSeries *expenses = [[XuniSeries alloc] initForChart:chart binding:@"expenses, expenses" name:@"Expenses"];
    XuniSeries *downloads = [[XuniSeries alloc] initForChart:chart binding:@"downloads, downloads" name:@"Downloads"];
    sales.chartType = XuniChartTypeArea;
    expenses.chartType = XuniChartTypeArea;
    downloads.chartType = XuniChartTypeArea;
    
    [chart.series addObject:sales];
    [chart.series addObject:expenses];
    [chart.series addObject:downloads];
    
    chart.itemsSource = chartData;
    chart.axisX.scale = 0.5;
    chart.axisY.displayedRange = 16000;
    chart.axisX.labelsVisible = true;
    chart.axisY.labelsVisible = true;
    
    chart.legend.orientation = XuniChartLegendOrientationAuto;
    chart.legend.position = XuniChartLegendPositionAuto;
    chart.chartType = XuniChartTypeArea;
    chart.stacking = XuniStackingStacked;
    
    chart.tag = 1;
    pickerView.tag = 2;
    label.tag = 3;
    
    [self.view addSubview:label];
    [self.view addSubview:pickerView];
    [self.view addSubview:chart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    FlexChart *chart = (FlexChart*)[self.view viewWithTag:1];
    UIPickerView *pickerView = (UIPickerView*)[self.view viewWithTag:2];
    UILabel *label = (UILabel*)[self.view viewWithTag:3];
    label.frame = CGRectMake(10, 110, 50, 25);
    [label sizeToFit];
    pickerView.frame = CGRectMake(self.view.bounds.size.width/3, 44, self.view.bounds.size.width/2, 162);
    chart.frame = CGRectMake(0, 206, self.view.bounds.size.width, self.view.bounds.size.height - 206);
    [chart setNeedsDisplay];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [pickerData count];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    FlexChart *chart = (FlexChart *)[self.view viewWithTag:1];
    if (row == 0) {
        chart.zoomMode = XuniZoomModeX;
    }
    else if (row == 1){
        chart.zoomMode = XuniZoomModeY;
    }
    else if (row == 2){
        chart.zoomMode = XuniZoomModeXY;
    }
    else if (row == 3){
        chart.zoomMode = XuniZoomModeDisabled;
    }
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [pickerData objectAtIndex:row];
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
