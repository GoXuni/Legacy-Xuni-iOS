//
//  LoadAnimationController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "LoadAnimationController.h"
@import XuniFlexChartDynamicKit;
#import "ChartData.h"

@interface LoadAnimationController () {
    NSMutableArray *chartTypePickerData;
    NSMutableArray *selectionModePickerData;
}
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet FlexChart *chart;

@end

@implementation LoadAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    chartTypePickerData =[[NSMutableArray alloc] initWithObjects:@"Column", @"Area", @"Line", @"LineSymbols", @"Spline", @"SplineSymbols", @"SplineArea", @"Scatter", nil];
    selectionModePickerData = [[NSMutableArray alloc]initWithObjects: @"All", @"Point", @"Series", nil];
    
    self.picker.delegate = self;
    
    FlexChart *chart = self.chart;
    NSMutableArray *chartData = [ChartData demoData];
    XuniSeries *sales = [[XuniSeries alloc] initForChart:chart binding:@"sales, sales" name:@"Sales"];
    XuniSeries *expenses = [[XuniSeries alloc] initForChart:chart binding:@"expenses, expenses" name:@"Expenses"];
    XuniSeries *downloads = [[XuniSeries alloc] initForChart:chart binding:@"downloads, downloads" name:@"Downloads"];

    [chart.series addObject:sales];
    [chart.series addObject:expenses];
    [chart.series addObject:downloads];
    
    chart.bindingX = @"name";
    chart.itemsSource = chartData;
    chart.loadAnimation.animationMode = XuniAnimationModePoint;
    chart.palette = [XuniPalettes modern];

}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return [chartTypePickerData count];
    }
    else {
        return [selectionModePickerData count];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    FlexChart *chart = self.chart;
    
    if (component == 0) {
        if (row == 0) {
            chart.chartType = XuniChartTypeColumn;
        }
        else if (row == 1) {
            chart.chartType = XuniChartTypeArea;
        }
        else if (row == 2) {
            chart.chartType = XuniChartTypeLine;
        }
        else if (row == 3) {
            chart.chartType = XuniChartTypeLineSymbols;
        }
        else if (row == 4) {
            chart.chartType = XuniChartTypeSpline;
        }
        else if (row == 5) {
            chart.chartType = XuniChartTypeSplineSymbols;
        }
        else if (row == 6) {
            chart.chartType = XuniChartTypeSplineArea;
        }
        else if (row == 7) {
            chart.chartType = XuniChartTypeScatter;
        }
    }
    else {
        if (row == 0) {
            chart.loadAnimation.animationMode = XuniAnimationModeAll;
            
        }
        else if (row == 1) {
            chart.loadAnimation.animationMode = XuniAnimationModePoint;

        }
        else if (row == 2) {
            chart.loadAnimation.animationMode = XuniAnimationModeSeries;

        }
    }
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        return [chartTypePickerData objectAtIndex:row];
    }
    else if (component == 1) {
        return [selectionModePickerData objectAtIndex:row];
    }
    else {
        return @"error";
    }
}


@end
