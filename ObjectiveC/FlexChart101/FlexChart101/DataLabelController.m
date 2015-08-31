//
//  DataLabelController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "DataLabelController.h"
#import "ChartData.h"
#import "FlexChartKit/FlexChartKit.h"

@interface DataLabelController (){
    NSMutableArray *chartTypePickerData;
    NSMutableArray *positionPickerData;
}

@end

@implementation DataLabelController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    chartTypePickerData =[[NSMutableArray alloc] initWithObjects:@"Column", @"Bar", @"Scatter", @"Line", @"LineSymbol", @"Area", nil];
    positionPickerData = [[NSMutableArray alloc]initWithObjects: @"Top", @"Bottom", @"Left", @"Right", @"None", nil];
    
    UIPickerView *chartTypePicker = [[UIPickerView alloc] init];
    UIPickerView *positionPicker = [[UIPickerView alloc] init];
    
    FlexChart *chart = [[FlexChart alloc] init];
    NSMutableArray *chartData = [ChartData demoData];
    
    chartTypePicker.delegate = self;
    chartTypePicker.showsSelectionIndicator = YES;
    chartTypePicker.hidden = false;
    positionPicker.delegate = self;
    positionPicker.showsSelectionIndicator = YES;
    positionPicker.hidden = false;
    
    chart.bindingX = @"name";
    XuniSeries *sales = [[XuniSeries alloc] initForChart:chart binding:@"sales, sales" name:@"Sales"];
    
    [chart.series addObject:sales];
    
    chart.itemsSource = chartData;
    chart.axisX.labelsVisible = true;
    chart.axisY.labelsVisible = true;
    
    chart.legend.orientation = XuniChartLegendOrientationAuto;
    chart.legend.position = XuniChartLegendPositionAuto;
    chart.tooltip.isVisible = true;
    chart.dataLabel.content= @"{seriesName}\n{y}";
    chart.dataLabel.dataLabelFormat = @"C";
    chart.dataLabel.position = FlexChartDataLabelPositionTop;
    chart.dataLabel.dataLabelFontColor = [UIColor redColor];
    chart.dataLabel.dataLabelBackgroundColor = [UIColor whiteColor];
    chart.dataLabel.dataLabelBorderColor = [UIColor grayColor];
    chart.dataLabel.dataLabelBorderWidth = .1;
    
    chart.tag = 1;
    chartTypePicker.tag = 2;
    positionPicker.tag = 3;
    
    [self.view addSubview:chartTypePicker];
    [self.view addSubview:positionPicker];
    [self.view addSubview:chart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    FlexChart *chart = (FlexChart*)[self.view viewWithTag:1];
    UIPickerView *chartTypePicker = (UIPickerView*)[self.view viewWithTag:2];
    UIPickerView *positionPicker = (UIPickerView*)[self.view viewWithTag:3];
    chartTypePicker.frame = CGRectMake(0, 44, self.view.bounds.size.width/2, 162);
    positionPicker.frame = CGRectMake(self.view.bounds.size.width/2, 44, self.view.bounds.size.width/2, 162);
    chart.frame = CGRectMake(0, 206, self.view.bounds.size.width, self.view.bounds.size.height - 206);
    [chart setNeedsDisplay];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if(pickerView.tag == 2){
        return [chartTypePickerData count];
    }
    else{
        return [positionPickerData count];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    FlexChart *chart = (FlexChart *)[self.view viewWithTag:1];
    
    if(pickerView.tag == 2)
    {
        if (row == 0) {
            chart.chartType = XuniChartTypeColumn;
        }
        else if (row == 1){
            chart.chartType = XuniChartTypeBar;
        }
        else if (row == 2){
            chart.chartType = XuniChartTypeScatter;
        }
        else if (row == 3){
            chart.chartType = XuniChartTypeLine;
        }
        else if (row == 4){
            chart.chartType = XuniChartTypeLineSymbols;
        }
        else if (row == 5){
            chart.chartType = XuniChartTypeArea;
        }
    }
    else if(pickerView.tag == 3){
        if (row == 0) {
            chart.dataLabel.position = FlexChartDataLabelPositionTop;
        }
        else if (row == 1){
            chart.dataLabel.position = FlexChartDataLabelPositionBottom;
        }
        else if (row == 2){
            chart.dataLabel.position = FlexChartDataLabelPositionLeft;
        }
        else if (row == 3){
            chart.dataLabel.position = FlexChartDataLabelPositionRight;
        }
        else if (row == 4){
            chart.dataLabel.position = FlexChartDataLabelPositionNone;
        }
    }
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(pickerView.tag == 2)
    {
        return [chartTypePickerData objectAtIndex:row];
    }
    else if(pickerView.tag == 3){
        return [positionPickerData objectAtIndex:row];
    }
    else{
        return @"error";
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
