//
//  BasicChartTypesController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "BasicChartTypesController.h"
#import "ChartData.h"
@import XuniFlexChartDynamicKit;
@interface BasicChartTypesController (){
    NSMutableArray *chartTypePickerData;
    NSMutableArray *stackingPickerData;
}
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet FlexChart *chart;

@end

@implementation BasicChartTypesController

- (IBAction)reverseSwitched:(id)sender {
    UISwitch * switchState = (UISwitch *)sender;

    NSString *temp = [[NSString alloc] init];
    if ([switchState isOn]) {
        self.chart.rotated = true;
    }
    else
    {
        self.chart.rotated = false;
    }
    temp = self.chart.axisX.format;
    self.chart.axisX.format = self.chart.axisY.format;
    self.chart.axisY.format = temp;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    chartTypePickerData =[[NSMutableArray alloc] initWithObjects:@"Column", @"Bar", @"Scatter", @"Line", @"LineSymbol", @"Area", nil];
    stackingPickerData = [[NSMutableArray alloc]initWithObjects: @"None", @"Stacked", @"Stacked100pc", nil];
    
    NSMutableArray *chartData = [ChartData demoData];
    
    _picker.delegate = self;
    
    self.chart.bindingX = @"name";
    XuniSeries *sales = [[XuniSeries alloc] initForChart: self.chart binding:@"sales, sales" name:@"Sales"];
    XuniSeries *expenses = [[XuniSeries alloc] initForChart: self.chart binding:@"expenses, expenses" name:@"Expenses"];
    XuniSeries *downloads = [[XuniSeries alloc] initForChart: self.chart binding:@"downloads, downloads" name:@"Downloads"];
    
    [self.chart.series addObject:sales];
    [self.chart.series addObject:expenses];
    [self.chart.series addObject:downloads];
    
    self.chart.itemsSource = chartData;
    self.chart.chartType = XuniChartTypeArea;
    self.chart.stacking = XuniStackingStacked;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.picker selectRow:5 inComponent:0 animated:NO];
    [self.picker selectRow:1 inComponent:1 animated:NO];
    
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(component == 0) {
        return [chartTypePickerData count];
    }
    else {
        return [stackingPickerData count];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    
    if (component == 0)
    {
        if (row == 0) {
            self.chart.chartType = XuniChartTypeColumn;
        }
        else if (row == 1) {
            self.chart.chartType = XuniChartTypeBar;
        }
        else if (row == 2) {
            self.chart.chartType = XuniChartTypeScatter;
        }
        else if (row == 3) {
            self.chart.chartType = XuniChartTypeLine;
        }
        else if (row == 4) {
            self.chart.chartType = XuniChartTypeLineSymbols;
        }
        else if (row == 5) {
            self.chart.chartType = XuniChartTypeArea;
        }
    }
    else if (component==1) {
        if (row == 0) {
            self.chart.stacking = XuniStackingNone;

        }
        else if (row == 1) {
            self.chart.stacking= XuniStackingStacked;
        }
        else if (row == 2) {
            self.chart.stacking = XuniStackingStacked100pc;
        }
    }
    
    [self setAxisFormatting];
}

- (void)setAxisFormatting {
    
    if (self.chart.chartType == XuniChartTypeBar) {
        if (self.chart.stacking == XuniStackingStacked100pc && self.chart.rotated == false) {
            self.chart.axisX.format = @"F2";
            self.chart.axisY.format = @"D";
        }
        else if (self.chart.stacking == XuniStackingStacked100pc && self.chart.rotated == true) {
            self.chart.axisX.format = @"D";
            self.chart.axisY.format = @"F2";
        }
        else {
            self.chart.axisX.format = @"D";
            self.chart.axisY.format = @"D";
        }
    }
    else {
        if (self.chart.stacking == XuniStackingStacked100pc && self.chart.rotated == false) {
            self.chart.axisX.format = @"D";
            self.chart.axisY.format = @"F2";
        }
        else if (self.chart.stacking == XuniStackingStacked100pc && self.chart.rotated == true) {
            self.chart.axisX.format = @"F2";
            self.chart.axisY.format = @"F2";
        }
        else {
            self.chart.axisX.format = @"D";
            self.chart.axisY.format = @"D";
        }
    }
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(component == 0)
    {
        return [chartTypePickerData objectAtIndex:row];
    }
    else if(component == 1){
        return [stackingPickerData objectAtIndex:row];
    }
    else{
        return @"error";
    }
}

@end
