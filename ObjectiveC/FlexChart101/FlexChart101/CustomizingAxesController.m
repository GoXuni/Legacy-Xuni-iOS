//
//  CustomizingAxesController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "CustomizingAxesController.h"
@import XuniFlexChartDynamicKit;
#import "ChartData.h"

@interface CustomizingAxesController ()
@property (weak, nonatomic) IBOutlet FlexChart *chart;

@end

@implementation CustomizingAxesController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSNumber *max = [[NSNumber alloc] initWithInt:10000];
    NSMutableArray *chartData = [ChartData demoData];
    self.chart.bindingX = @"name";
    XuniSeries *sales = [[XuniSeries alloc] initForChart: self.chart binding:@"sales, sales" name:@"Sales"];
    XuniSeries *expenses = [[XuniSeries alloc] initForChart: self.chart binding:@"expenses, expenses" name:@"Expenses"];

    [self.chart.series addObject:sales];
    [self.chart.series addObject:expenses];
    
    self.chart.itemsSource = chartData;
    self.chart.axisX.title = @"Country";
    self.chart.axisX.lineWidth = 2;
    self.chart.axisX.minorTickWidth = 1;
    self.chart.axisX.majorTickWidth = 0;
    self.chart.axisY.lineWidth = 2;
    self.chart.axisY.minorGridVisible = YES;
    self.chart.axisY.minorGridWidth = 0.5;
    self.chart.axisY.minorGridDashes = [[NSArray alloc] initWithObjects:@4, @4, nil];
    self.chart.axisY.minorTickWidth = 1;
    self.chart.axisY.majorTickWidth = 2;
    self.chart.axisY.majorGridWidth = 1;
    self.chart.axisY.majorGridColor = [UIColor colorWithWhite:0.8 alpha:1];
    self.chart.axisY.majorGridFill = [UIColor colorWithWhite:0.6 alpha:0.2];
    self.chart.axisY.majorUnit = 1000;
    self.chart.axisY.max = max;
    
    [self.chart.axisX.labelLoading addHandler: ^(XuniEventContainer<XuniLabelLoadingEventArgs *> *eventContainer) {
        XuniLabelLoadingEventArgs *labelArgs = eventContainer.eventArgs;
        labelArgs.label = nil;
        
        NSNumber *countryNum = [NSNumber numberWithDouble:labelArgs.value];
        UIImage *image = [UIImage imageNamed:[countryNum stringValue]];
        CGRect rect = CGRectMake(labelArgs.region.left, labelArgs.region.top, labelArgs.region.width, labelArgs.region.height);
        [image drawInRect:rect];
    } forObject:self];
    
    [self.chart.axisY.labelLoading addHandler: ^(XuniEventContainer<XuniLabelLoadingEventArgs *> *eventContainer) {
        XuniLabelLoadingEventArgs *labelArgs = eventContainer.eventArgs;
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
    } forObject:self];
}


@end
