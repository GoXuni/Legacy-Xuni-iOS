//
//  UpdateAnimationController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "UpdateAnimationController.h"
@import XuniFlexChartDynamicKit;
#import "ChartData.h"

@implementation UpdateData

- (id)initWithXValue:(NSString *)xValue y:(NSNumber*)value {
    self = [super init];
    if(self){
        _xValue = xValue;
        _value = value;
    }
    return self;
}

+ (NSArray *)demoData {
    NSMutableArray *arrData = [[NSMutableArray alloc] init];
    int num;
    UpdateData *data;
    
    for (int i = 0; i < 8; i++) {
        num = 65 + rand() % (90 - 65 + 1);
        data = [[UpdateData alloc] initWithXValue:[NSString stringWithFormat:@"%c", num]
                                                y:[UpdateData randomNumberBetween:i max:(10 + i * i)]];
        [arrData addObject:data];
    }
    
    return arrData;
}

+ (NSNumber *)randomNumberBetween:(NSInteger)min max:(NSInteger)max {
    return [NSNumber numberWithInteger:(min + rand() % (max - min + 1))];
}

@end


@interface UpdateAnimationController () {
    NSMutableArray *chartTypePickerData;
    NSMutableArray *updatePositionPickerData;
    NSMutableArray *chartData;
}
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet FlexChart *chart;

@end

@implementation UpdateAnimationController

- (IBAction)addPoint:(id)sender {
    FlexChart *chart = self.chart;
    UIPickerView *updatePositionPicker = self.picker;
    NSInteger row = [updatePositionPicker selectedRowInComponent:1];
    int num = 65 + rand() % (90 - 65 + 1);
    UpdateData *data = [[UpdateData alloc] initWithXValue:[NSString stringWithFormat:@"%c", num]
                                                        y:[UpdateData randomNumberBetween:10 max:80]];
    
    if (row == 0) {
        [chart.collectionView insertObject:data atIndex:0];
    }
    else if (row == 1) {
        [chart.collectionView insertObject:data atIndex:chart.collectionView.itemCount / 2];
    }
    else if (row == 2) {
        [chart.collectionView addObject:data];
    }
}

- (IBAction)removePoint:(id)sender {
    FlexChart *chart = self.chart;
    UIPickerView *updatePositionPicker = self.picker;
    NSInteger row = [updatePositionPicker selectedRowInComponent:1];
    
    if (row == 0) {
        [chart.collectionView removeAt:0];
    }
    else if (row == 1) {
        [chart.collectionView removeAt:chart.collectionView.itemCount / 2];
    }
    else if (row == 2) {
        [chart.collectionView removeAt:chart.collectionView.itemCount - 1];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Update Animation"];
    
    // Do any additional setup after loading the view.
    chartTypePickerData =[[NSMutableArray alloc] initWithObjects:@"Column", @"Area", @"Line", @"LineSymbols", @"Spline", @"SplineSymbols", @"SplineArea", @"Scatter", nil];
    updatePositionPickerData = [[NSMutableArray alloc]initWithObjects: @"Beginning", @"Middle", @"End", nil];
    chartData = [[NSMutableArray alloc] initWithArray:[UpdateData demoData]];
    
    self.picker.delegate = self;
    
  
    [self.picker selectRow:0 inComponent:0 animated:false];
    
  
    [self.picker selectRow:0 inComponent:1 animated:false];
    
    FlexChart *chart = self.chart;
    XuniSeries *value = [[XuniSeries alloc] initForChart:chart binding:@"value" name:@"value"];
    [chart.series addObject:value];
    
    chart.bindingX = @"xValue";
    chart.itemsSource = chartData;
    chart.loadAnimation.animationMode = XuniAnimationModePoint;
    chart.legend.position = XuniChartLegendPositionNone;
    chart.palette = [XuniPalettes cocoa];
    chart.axisY.axisLineVisible = NO;
    chart.axisY.majorTickWidth = 0;
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if(component == 0){
        return [chartTypePickerData count];
    }
    else{
        return [updatePositionPickerData count];
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
            chart.chartType = XuniChartTypeArea;
        }
        else if (row == 2){
            chart.chartType = XuniChartTypeLine;
        }
        else if (row == 3){
            chart.chartType = XuniChartTypeLineSymbols;
        }
        else if (row == 4){
            chart.chartType = XuniChartTypeSpline;
        }
        else if (row == 5){
            chart.chartType = XuniChartTypeSplineSymbols;
        }
        else if (row == 6){
            chart.chartType = XuniChartTypeSplineArea;
        }
        else if (row == 7){
            chart.chartType = XuniChartTypeScatter;
        }
    }
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(component == 0)
    {
        return [chartTypePickerData objectAtIndex:row];
    }
    else if(component == 1){
        return [updatePositionPickerData objectAtIndex:row];
    }
    else{
        return @"error";
    }
}


@end