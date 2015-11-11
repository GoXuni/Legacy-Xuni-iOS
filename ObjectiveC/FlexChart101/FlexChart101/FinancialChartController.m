//
//  FinancialChartController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "FinancialChartController.h"
#import "XuniFlexChartKit/XuniFlexChartKit.h"
#import "FinancialData.h"

@interface FinancialChartController (){
    NSMutableArray *pickerData;
}
@end

@implementation FinancialChartController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Financial Chart"];
    
    // Do any additional setup after loading the view.
    UIPickerView *pickerView;
    pickerData =[[NSMutableArray alloc] initWithObjects:@"Candlestick", @"HLOC", nil];
    
    pickerView = [[UIPickerView alloc] init];
    pickerView.delegate = self;
    pickerView.showsSelectionIndicator = YES;
    pickerView.hidden = false;
    FlexChart *chart = [[FlexChart alloc] init];
    NSMutableArray *financialData = [FinancialData demoData];
    chart.bindingX = @"date";
    XuniSeries *finance = [[XuniSeries alloc] initForChart:chart binding: @"high,low,open,close" name: @"AAPL"];
    
    [chart.series addObject:finance];
    chart.itemsSource = financialData;
    chart.chartType = XuniChartTypeCandlestick;
    chart.selectionMode = XuniSelectionModePoint;
    chart.axisY.majorGridFill = [UIColor colorWithWhite:0.6 alpha:0.2];
    chart.legend.position = XuniChartLegendPositionNone;
    
    chart.tag = 1;
    pickerView.tag = 2;
    
    [self.view addSubview:chart];
    [self.view addSubview:pickerView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    FlexChart *chart = (FlexChart*)[self.view viewWithTag:1];
    UIPickerView *pickerView = (UIPickerView*)[self.view viewWithTag:2];
    pickerView.frame = CGRectMake(self.view.bounds.size.width/4, 44, self.view.bounds.size.width/2, 162);
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
    FlexChart *chart = (FlexChart*)[self.view viewWithTag:1];

    switch (row) {
        case 0:
            chart.chartType = XuniChartTypeCandlestick;
            break;
        case 1:
            chart.chartType = XuniChartTypeHighLowOpenClose;
            break;
        default:
            break;
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
