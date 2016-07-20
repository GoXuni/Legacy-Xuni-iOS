//
//  SelectionModesController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "SelectionModesController.h"
@import XuniFlexChartDynamicKit;
#import "ChartData.h"

@interface SelectionModesController (){
    NSMutableArray *chartTypePickerData;
    NSMutableArray *selectionModePickerData;
}
@property (weak, nonatomic) IBOutlet FlexChart *chart;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@end

@implementation SelectionModesController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    chartTypePickerData =[[NSMutableArray alloc] initWithObjects:@"Column", @"Bar", @"Scatter", @"Line", @"LineSymbol", @"Area", nil];
    selectionModePickerData = [[NSMutableArray alloc]initWithObjects: @"None", @"Series", @"Point", nil];

    
    self.picker.delegate = self;
    
    NSMutableArray *chartData = [ChartData demoData];
    FlexChart *chart = self.chart;
    
    XuniSeries *sales = [[XuniSeries alloc] initForChart:chart binding:@"sales, sales" name:@"Sales"];
    XuniSeries *expenses = [[XuniSeries alloc] initForChart:chart binding:@"expenses, expenses" name:@"Expenses"];
    XuniSeries *downloads = [[XuniSeries alloc] initForChart:chart binding:@"downloads, downloads" name:@"Downloads"];
 
    [chart.series addObject:sales];
    [chart.series addObject:expenses];
    [chart.series addObject:downloads];
    
    chart.bindingX = @"name";
    chart.itemsSource = chartData;
    chart.selectionMode = XuniSelectionModeSeries;
    chart.selectedBorderColor = [UIColor redColor];
    chart.selectedBorderWidth = 3;
    chart.selectedDashes = [[NSArray alloc] initWithObjects:@7.5, @2.5, nil];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.picker selectRow:0 inComponent:0 animated:NO];
    [self.picker selectRow:1 inComponent:1 animated:NO];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if(component == 0){
        return [chartTypePickerData count];
    }
    else{
        return [selectionModePickerData count];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    FlexChart *chart = self.chart;
    if(component == 0)
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
    else if(component == 1){
        if (row == 0) {
            chart.selectionMode = XuniSelectionModeNone;
        }
        else if (row == 1){
            chart.selectionMode = XuniSelectionModeSeries;
        }
        else if (row == 2){
            chart.selectionMode = XuniSelectionModePoint;
        }
    }
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(component == 0)
    {
        return [chartTypePickerData objectAtIndex:row];
    }
    else if(component == 1){
        return [selectionModePickerData objectAtIndex:row];
    }
    else{
        return @"error";
    }
}

@end
