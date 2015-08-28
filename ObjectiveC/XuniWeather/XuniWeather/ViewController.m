//
//  ViewController.m
//  XuniWeather
//
//  Created by Chris Ripple on 8/26/15.
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "ViewController.h"
#import "WeatherData.h"
#import "FlexChartKit/FlexChartKit.h"
#import "FlexGridKit/FlexGridKit.h"

@interface ViewController (){
    UITextField *_locationField;
    FlexGrid *_grid;
    FlexChart *_chart;
    UILabel *_label;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _locationField = [[UITextField alloc] init];
    _locationField.delegate = self;
    _locationField.text = @"Enter ZIP Code";
    _locationField.returnKeyType = UIReturnKeyDone;
    _locationField.keyboardType = UIKeyboardTypeDefault;
    _locationField.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
    [self.view addSubview:_locationField];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _locationField.frame = CGRectMake(0, 44, self.view.bounds.size.width, 50);
    _chart.frame = CGRectMake(0, 94, self.view.bounds.size.width, (self.view.bounds.size.height - 94)/2);
    _grid.frame = CGRectMake(0, 94 + (self.view.bounds.size.height - 94)/2, self.view.bounds.size.width, (self.view.bounds.size.height - 94)/2);
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return true;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [textField selectAll:nil];
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return true;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if(_grid == nil && _chart == nil){
        _grid = [[FlexGrid alloc] init];
        _chart = [[FlexChart alloc]init];
        
        [self.view addSubview:_grid];
        [self.view addSubview:_chart];
    }
    [_chart.series removeAllObjects];
    
    NSMutableArray *fiveDay = [WeatherData demoData:textField.text];
    
    _grid.isReadOnly = true;
    _chart.bindingX = @"date";
    XuniSeries *humidity = [[XuniSeries alloc] initForChart:_chart binding:@"humidity, humidity" name:@"Humidity %"];
    XuniSeries *high = [[XuniSeries alloc] initForChart:_chart binding:@"highTemp, highTemp" name:@"High Temp (F)"];
    high.chartType = XuniChartTypeLine;
    
    [_chart.series addObject:humidity];
    [_chart.series addObject:high];
    
    _chart.axisX.labelsVisible = true;
    _chart.axisY.labelsVisible = true;
    
    _grid.itemsSource = fiveDay;
    _chart.itemsSource = fiveDay;
    
    _grid.alternatingRowBackgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
    humidity.chartType = XuniChartTypeArea;
    humidity.color = [UIColor colorWithRed:.74 green:.85 blue:.95 alpha:1];
    high.borderWidth = 2.5;
    _chart.legend.orientation = XuniChartLegendOrientationAuto;
    _chart.legend.position = XuniChartLegendPositionBottom;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"M-dd h:mm a"];
    FlexColumn *c = [_grid.columns objectAtIndex:0];
    c.formatter = dateFormatter;
    c.header = @"date/time";
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
}

@end
