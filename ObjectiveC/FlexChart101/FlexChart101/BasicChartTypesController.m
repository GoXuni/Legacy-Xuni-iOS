//
//  BasicChartTypesController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "BasicChartTypesController.h"
#import "ChartData.h"
#import "FlexChartKit/FlexChartKit.h"
@interface BasicChartTypesController (){
    NSMutableArray *chartTypePickerData;
    NSMutableArray *stackingPickerData;
}

@end

@implementation BasicChartTypesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    chartTypePickerData =[[NSMutableArray alloc] initWithObjects:@"Column", @"Bar", @"Scatter", @"Line", @"LineSymbol", @"Area", nil];
    stackingPickerData = [[NSMutableArray alloc]initWithObjects: @"None", @"Stacked", @"Stacked100pc", nil];
    
    UIPickerView *chartTypePicker = [[UIPickerView alloc] init];
    UIPickerView *stackingPicker = [[UIPickerView alloc] init];
    
    FlexChart *chart = [[FlexChart alloc] init];
    UISwitch *rotatedSwitch = [[UISwitch alloc]init];
    NSMutableArray *chartData = [ChartData demoData];
    
    [rotatedSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    chartTypePicker.delegate = self;
    chartTypePicker.showsSelectionIndicator = YES;
    chartTypePicker.hidden = false;
    [chartTypePicker selectRow:5 inComponent:0 animated:false];
    
    stackingPicker.delegate = self;
    stackingPicker.showsSelectionIndicator = YES;
    stackingPicker.hidden = false;
    [stackingPicker selectRow:0 inComponent:0 animated:false];
    
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
    
    chart.legend.orientation = XuniChartLegendOrientationAuto;
    chart.legend.position = XuniChartLegendPositionAuto;
    chart.tooltip.visible = true;
    
    chart.tag = 1;
    chartTypePicker.tag = 2;
    stackingPicker.tag = 3;
    rotatedSwitch.tag = 4;
    
    [self.view addSubview:rotatedSwitch];
    [self.view addSubview:chartTypePicker];
    [self.view addSubview:stackingPicker];
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
    UIPickerView *stackingPicker = (UIPickerView*)[self.view viewWithTag:3];
    UISwitch *rotatedSwitch = (UISwitch*)[self.view viewWithTag:4];
    chartTypePicker.frame = CGRectMake(0, 44, self.view.bounds.size.width*7/18, 162);
    stackingPicker.frame = CGRectMake(self.view.bounds.size.width*7/18, 44, self.view.bounds.size.width*4/9, 162);
    rotatedSwitch.frame = CGRectMake((self.view.bounds.size.width * 15/18) + 5, 110, self.view.bounds.size.width*3/18, 50);
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
        return [stackingPickerData count];
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
            chart.stacking = XuniStackingNone;

        }
        else if (row == 1){
            chart.stacking= XuniStackingStacked;
        }
        else if (row == 2){
            chart.stacking = XuniStackingStacked100pc;
        }
    }
    [self setAxisFormatting];
}
-(void)setAxisFormatting{
    FlexChart *chart = (FlexChart *)[self.view viewWithTag:1];
    if (chart.chartType == XuniChartTypeBar) {
        if (chart.stacking == XuniStackingStacked100pc  && chart.rotated == false) {
            chart.axisX.format = @"p";
            chart.axisY.format = @"d";
        }
        else if (chart.stacking == XuniStackingStacked100pc  && chart.rotated == true){
            chart.axisX.format = @"d";
            chart.axisY.format = @"p";
        }
        else{
            chart.axisX.format = @"d";
            chart.axisY.format = @"d";
        }
    }
    else{
        if(chart.stacking == XuniStackingStacked100pc && chart.rotated == false){
            chart.axisX.format = @"d";
            chart.axisY.format = @"p";
        }
        else if(chart.stacking == XuniStackingStacked100pc && chart.rotated == true){
            chart.axisX.format = @"p";
            chart.axisY.format = @"d";
        }
        else{
            chart.axisX.format = @"d";
            chart.axisY.format = @"d";
        }
    }
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(pickerView.tag == 2)
    {
        return [chartTypePickerData objectAtIndex:row];
    }
    else if(pickerView.tag == 3){
        return [stackingPickerData objectAtIndex:row];
    }
    else{
        return @"error";
    }
}

-(void)switchChanged:(UISwitch *) switchState{
    FlexChart *chart = (FlexChart *)[self.view viewWithTag:1];
    NSString *temp = [[NSString alloc] init];
    if ([switchState isOn]) {
        chart.rotated = true;
    }
    else
    {
         chart.rotated = false;
    }
    temp = chart.axisX.format;
    chart.axisX.format = chart.axisY.format;
    chart.axisY.format = temp;
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
