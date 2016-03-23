//
//  UpdateAnimationController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "UpdateAnimationController.h"
#import "XuniFlexChartKit/XuniFlexChartKit.h"
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

@end

@implementation UpdateAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:NSLocalizedString(@"Update Animation", nil)];
    
    // Do any additional setup after loading the view.
    chartTypePickerData =[[NSMutableArray alloc] initWithObjects:@"Column", @"Area", @"Line", @"LineSymbols", @"Spline", @"SplineSymbols", @"SplineArea", @"Scatter", nil];
    updatePositionPickerData = [[NSMutableArray alloc]initWithObjects: @"Beginning", @"Middle", @"End", nil];
    chartData = [[NSMutableArray alloc] initWithArray:[UpdateData demoData]];
    
    UIPickerView *chartTypePicker = [[UIPickerView alloc] init];
    chartTypePicker.delegate = self;
    chartTypePicker.showsSelectionIndicator = YES;
    chartTypePicker.hidden = false;
    [chartTypePicker selectRow:0 inComponent:0 animated:false];
    
    UIPickerView *updatePositionPicker = [[UIPickerView alloc] init];
    updatePositionPicker.delegate = self;
    updatePositionPicker.showsSelectionIndicator = YES;
    updatePositionPicker.hidden = false;
    [updatePositionPicker selectRow:0 inComponent:0 animated:false];
    
    UIButton *addPointBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [addPointBtn setTitle:NSLocalizedString(@"Add Point", nil) forState:UIControlStateNormal];
    [addPointBtn addTarget:self action:@selector(addPointAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *removePointBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [removePointBtn setTitle:NSLocalizedString(@"Remove Point", nil) forState:UIControlStateNormal];
    [removePointBtn addTarget:self action:@selector(removePointAction) forControlEvents:UIControlEventTouchUpInside];
    
    FlexChart *chart = [[FlexChart alloc] init];
    XuniSeries *value = [[XuniSeries alloc] initForChart:chart binding:@"value" name:@"value"];
    [chart.series addObject:value];
    
    chart.bindingX = @"xValue";
    chart.itemsSource = chartData;
    chart.loadAnimation.animationMode = XuniAnimationModePoint;
    chart.legend.position = XuniChartLegendPositionNone;
    chart.palette = [XuniPalettes cocoa];
    chart.axisY.axisLineVisible = NO;
    chart.axisY.majorTickWidth = 0;
    
    chart.tag = 1;
    chartTypePicker.tag = 2;
    updatePositionPicker.tag = 3;
    addPointBtn.tag = 4;
    removePointBtn.tag = 5;
    
    [self.view addSubview:chartTypePicker];
    [self.view addSubview:updatePositionPicker];
    [self.view addSubview:addPointBtn];
    [self.view addSubview:removePointBtn];
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
    UIPickerView *updatePositionPicker = (UIPickerView*)[self.view viewWithTag:3];
    UIButton *addPointBtn = (UIButton*)[self.view viewWithTag:4];
    UIButton *removePointBtn = (UIButton*)[self.view viewWithTag:5];
    
    chartTypePicker.frame = CGRectMake(0, 44, self.view.bounds.size.width / 2, 162);
    updatePositionPicker.frame = CGRectMake(self.view.bounds.size.width / 2, 44, self.view.bounds.size.width / 2, 162);
    addPointBtn.frame = CGRectMake(20, 206, 120, 40);
    removePointBtn.frame = CGRectMake(160, 206, 150, 40);
    chart.frame = CGRectMake(0, 206 + 40, self.view.bounds.size.width, self.view.bounds.size.height - 206 - 40);
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
        return [updatePositionPickerData count];
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
    if(pickerView.tag == 2)
    {
        return [chartTypePickerData objectAtIndex:row];
    }
    else if(pickerView.tag == 3){
        return [updatePositionPickerData objectAtIndex:row];
    }
    else{
        return @"error";
    }
}

- (void)addPointAction {
    FlexChart *chart = (FlexChart*)[self.view viewWithTag:1];
    UIPickerView *updatePositionPicker = (UIPickerView*)[self.view viewWithTag:3];
    NSInteger row = [updatePositionPicker selectedRowInComponent:0];
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

- (void)removePointAction {
    FlexChart *chart = (FlexChart*)[self.view viewWithTag:1];
    UIPickerView *updatePositionPicker = (UIPickerView*)[self.view viewWithTag:3];
    NSInteger row = [updatePositionPicker selectedRowInComponent:0];
    
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end