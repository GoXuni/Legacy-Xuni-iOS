//
//  DataLabelController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "DataLabelController.h"
#import "ChartData.h"
#import "XuniFlexChartKit/XuniFlexChartKit.h"

@interface DataLabelController (){
    NSMutableArray *positionPickerData;
}

@end

@implementation DataLabelController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Data Labels"];
    
    // Do any additional setup after loading the view.
    positionPickerData = [[NSMutableArray alloc]initWithObjects:@"None", @"Left", @"Top", @"Right", @"Bottom", @"Center", nil];
    
    UIPickerView *positionPicker = [[UIPickerView alloc] init];
    positionPicker.delegate = self;
    positionPicker.showsSelectionIndicator = YES;
    positionPicker.hidden = NO;
    
    FlexChart *chart = [[FlexChart alloc] init];
    NSMutableArray *chartData = [ChartData demoData];
    
    chart.bindingX = @"name";
    XuniSeries *expenses = [[XuniSeries alloc] initForChart:chart binding:@"expenses" name:@"Total Expenses"];
    [chart.series addObject:expenses];
    
    chart.itemsSource = chartData;
    chart.chartType = XuniChartTypeBar;
    chart.isAnimated = NO;
    chart.tooltip.isVisible = NO;
    chart.axisX.majorGridVisible = YES;
    chart.axisY.labelsVisible = NO;
    chart.axisY.majorGridVisible = NO;
    chart.axisY.minorGridVisible = NO;
    chart.axisY.majorTickWidth = 0;
    chart.palette = [XuniPalettes organic];
    
    chart.dataLabel.content= @"{x} {y}";
    chart.dataLabel.dataLabelFormat = @"F2";
    chart.dataLabel.position = FlexChartDataLabelPositionLeft;
    chart.dataLabel.dataLabelFontColor = [UIColor redColor];
    chart.dataLabel.dataLabelBackgroundColor = [UIColor whiteColor];
    chart.dataLabel.dataLabelBorderColor = [UIColor blueColor];
    chart.dataLabel.dataLabelBorderWidth = 1;
    chart.dataLabel.dataLabelFont = [UIFont systemFontOfSize:15];
    
    chart.tag = 1;
    positionPicker.tag = 2;
    
    [self.view addSubview:positionPicker];
    [self.view addSubview:chart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIPickerView *positionPicker = (UIPickerView*)[self.view viewWithTag:2];
    [positionPicker selectRow:1 inComponent:0 animated:NO];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    FlexChart *chart = (FlexChart*)[self.view viewWithTag:1];
    UIPickerView *positionPicker = (UIPickerView*)[self.view viewWithTag:2];
    positionPicker.frame = CGRectMake(0, 44, self.view.bounds.size.width, 162);
    chart.frame = CGRectMake(0, 206, self.view.bounds.size.width, self.view.bounds.size.height - 206);
    [chart setNeedsDisplay];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if(pickerView.tag == 2){
        return [positionPickerData count];
    }
    
    return 0;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    FlexChart *chart = (FlexChart *)[self.view viewWithTag:1];
    
    if(pickerView.tag == 2)
    {
        if (row == 0) {
            chart.dataLabel.position = FlexChartDataLabelPositionNone;
        }
        else if (row == 1){
            chart.dataLabel.position = FlexChartDataLabelPositionLeft;
        }
        else if (row == 2){
            chart.dataLabel.position = FlexChartDataLabelPositionTop;
        }
        else if (row == 3){
            chart.dataLabel.position = FlexChartDataLabelPositionRight;
        }
        else if (row == 4){
            chart.dataLabel.position = FlexChartDataLabelPositionBottom;
        }
        else if (row == 5){
            chart.dataLabel.position = FlexChartDataLabelPositionCenter;
        }
    }
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(pickerView.tag == 2)
    {
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
