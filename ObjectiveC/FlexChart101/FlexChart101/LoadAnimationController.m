//
//  LoadAnimationController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "LoadAnimationController.h"
#import "XuniFlexChartKit/XuniFlexChartKit.h"
#import "ChartData.h"

@interface LoadAnimationController () {
    NSMutableArray *chartTypePickerData;
    NSMutableArray *selectionModePickerData;
}

@end

@implementation LoadAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:NSLocalizedString(@"Load Animation Mode", nil)];
    
    // Do any additional setup after loading the view.
    chartTypePickerData =[[NSMutableArray alloc] initWithObjects:@"Column", @"Area", @"Line", @"LineSymbols", @"Spline", @"SplineSymbols", @"SplineArea", @"Scatter", nil];
    selectionModePickerData = [[NSMutableArray alloc]initWithObjects: @"All", @"Point", @"Series", nil];
    
    UIPickerView *chartTypePicker = [[UIPickerView alloc] init];
    chartTypePicker.delegate = self;
    chartTypePicker.showsSelectionIndicator = YES;
    chartTypePicker.hidden = false;
    [chartTypePicker selectRow:0 inComponent:0 animated:false];
    
    UIPickerView *selectionModePicker = [[UIPickerView alloc] init];
    selectionModePicker.delegate = self;
    selectionModePicker.showsSelectionIndicator = YES;
    selectionModePicker.hidden = false;
    [selectionModePicker selectRow:1 inComponent:0 animated:false];
    
    FlexChart *chart = [[FlexChart alloc] init];
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

    chart.tag = 1;
    chartTypePicker.tag = 2;
    selectionModePicker.tag = 3;
    
    [self.view addSubview:chartTypePicker];
    [self.view addSubview:selectionModePicker];
    [self.view addSubview:chart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    FlexChart *chart = (FlexChart*)[self.view viewWithTag:1];
    UIPickerView *chartTypePicker = (UIPickerView*)[self.view viewWithTag:2];
    UIPickerView *selectionModePicker = (UIPickerView*)[self.view viewWithTag:3];
    
    chartTypePicker.frame = CGRectMake(0, 44, self.view.bounds.size.width / 2, 162);
    selectionModePicker.frame = CGRectMake(self.view.bounds.size.width / 2, 44, self.view.bounds.size.width / 2, 162);
    chart.frame = CGRectMake(0, 206, self.view.bounds.size.width, self.view.bounds.size.height - 206);
    [chart setNeedsDisplay];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (pickerView.tag == 2) {
        return [chartTypePickerData count];
    }
    else {
        return [selectionModePickerData count];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    FlexChart *chart = (FlexChart *)[self.view viewWithTag:1];
    
    if (pickerView.tag == 2) {
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
    else if (pickerView.tag == 3) {
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
    if (pickerView.tag == 2) {
        return [chartTypePickerData objectAtIndex:row];
    }
    else if (pickerView.tag == 3) {
        return [selectionModePickerData objectAtIndex:row];
    }
    else {
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
