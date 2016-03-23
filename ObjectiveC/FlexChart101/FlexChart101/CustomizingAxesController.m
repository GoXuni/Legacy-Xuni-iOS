//
//  CustomizingAxesController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "CustomizingAxesController.h"
#import "XuniFlexChartKit/XuniFlexChartKit.h"
#import "ChartData.h"

@interface CustomizingAxesController ()

@end

@implementation CustomizingAxesController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:NSLocalizedString(@"Customizing Axes", nil)];
    
    // Do any additional setup after loading the view.
    NSNumber *max = [[NSNumber alloc] initWithInt:10000];
    FlexChart *chart = [[FlexChart alloc] init];
    NSMutableArray *chartData = [ChartData demoData];
    chart.bindingX = @"name";
    XuniSeries *sales = [[XuniSeries alloc] initForChart:chart binding:@"sales, sales" name:@"Sales"];
    XuniSeries *expenses = [[XuniSeries alloc] initForChart:chart binding:@"expenses, expenses" name:@"Expenses"];

    [chart.series addObject:sales];
    [chart.series addObject:expenses];
    
    chart.itemsSource = chartData;
    chart.axisX.title = @"Country";
    chart.axisX.lineWidth = 2;
    chart.axisX.minorTickWidth = 1;
    chart.axisX.majorTickWidth = 0;
    chart.axisY.lineWidth = 2;
    chart.axisY.minorGridVisible = YES;
    chart.axisY.minorGridWidth = 0.5;
    chart.axisY.minorGridDashes = [[NSArray alloc] initWithObjects:@4, @4, nil];
    chart.axisY.minorTickWidth = 1;
    chart.axisY.majorTickWidth = 2;
    chart.axisY.majorGridWidth = 1;
    chart.axisY.majorGridColor = [UIColor colorWithWhite:0.8 alpha:1];
    chart.axisY.majorGridFill = [UIColor colorWithWhite:0.6 alpha:0.2];
    chart.axisY.majorUnit = 1000;
    chart.axisY.max = max;
    
    IXuniEventHandler axisXLabelLoadingHandler = ^(NSObject *sender, XuniEventArgs *args) {
        XuniLabelLoadingEventArgs *labelArgs = (XuniLabelLoadingEventArgs*)args;
        labelArgs.label = nil;
        
        NSNumber *countryNum = [NSNumber numberWithDouble:labelArgs.value];
        UIImage *image = [UIImage imageNamed:[countryNum stringValue]];
        CGRect rect = CGRectMake(labelArgs.region.left, labelArgs.region.top, labelArgs.region.width, labelArgs.region.height);
        [image drawInRect:rect];
    };
    [chart.axisX.labelLoading addHandler:axisXLabelLoadingHandler forObject:self];
    
    IXuniEventHandler axisYLabelLoadingHandler = ^(NSObject *sender, XuniEventArgs *args) {
        XuniLabelLoadingEventArgs *labelArgs = (XuniLabelLoadingEventArgs*)args;
        if (labelArgs.value <= 3000) {
            [labelArgs.renderEngine setTextFill:[UIColor redColor]];
        }
        else if (labelArgs.value <= 10000 && labelArgs.value > 6000) {
            [labelArgs.renderEngine setTextFill:[UIColor greenColor]];
        }
        else {
            [labelArgs.renderEngine setTextFill:[UIColor blackColor]];
        }
        labelArgs.label = [NSString stringWithFormat:@"$%dK", (int)(labelArgs.value / 1000)];
        
    };
    [chart.axisY.labelLoading addHandler:axisYLabelLoadingHandler forObject:self];
    
    chart.tag = 1;
    [self.view addSubview:chart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    FlexChart *chart = (FlexChart*)[self.view viewWithTag:1];
    chart.frame = CGRectMake(0, 55, self.view.bounds.size.width, self.view.bounds.size.height - 55);
    [chart setNeedsDisplay];
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
