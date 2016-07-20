//
//  HitTestController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "HitTestController.h"
#import "HitTestData.h"
@import XuniFlexChartDynamicKit;

@interface HitTestController ()
@property (weak, nonatomic) IBOutlet FlexChart *chart;
@property (weak, nonatomic) IBOutlet UILabel *chartElementLabel;
@property (weak, nonatomic) IBOutlet UILabel *seriesLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointIndexLabel;
@property (weak, nonatomic) IBOutlet UILabel *xyValuesLabel;

@end

@implementation HitTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    FlexChart *chart = self.chart;
    chart.bindingX = @"x";
    XuniSeries *seriesCosX = [[XuniSeries alloc] initForChart:chart binding:@"y, y" name:@"cos(x)"];
    XuniSeries *seriesSinX = [[XuniSeries alloc] initForChart:chart binding:@"y, y" name:@"sin(x)"];
    seriesCosX.itemsSource = [HitTestData cosData];
    seriesSinX.itemsSource = [HitTestData sinData];
    
    [chart.series addObject:seriesCosX];
    [chart.series addObject:seriesSinX];
    
    chart.delegate = self;
    chart.chartType = XuniChartTypeLineSymbols;
    chart.axisY.format = @"F";
    chart.header = @"Trigonometric Functions";
    chart.footer = @"Cartesian coordinates";

}



-(BOOL)tapped:(FlexChartBase *)sender point:(XuniPoint *)point
{
    FlexChart *chart = self.chart;
    UILabel *s = self.seriesLabel;
    UILabel *pi = self.pointIndexLabel;
    UILabel *xy = self.xyValuesLabel;
    UILabel *ce = self.chartElementLabel;
    XuniChartHitTestInfo *hitTest = [chart hitTest:point];
    pi.text = [@" Point Index: " stringByAppendingString: [NSString stringWithFormat:@"%i", hitTest.dataPoint.pointIndex]];
    xy.text = [[NSString stringWithFormat:@" X:%@", hitTest.dataPoint.valueX] stringByAppendingString: [NSString stringWithFormat:@" Y:%1.2f", hitTest.dataPoint.value]];
    if (hitTest.dataPoint.seriesIndex >= 0 && hitTest.dataPoint.seriesIndex < chart.series.count) {
        s.text = [@" Series: " stringByAppendingString: hitTest.dataPoint.seriesName];
    }
    else
    {
        s.text = @" Series: ";
    }
    ce.text = [@" Chart element: " stringByAppendingString: [self getChartTypeString:(hitTest.chartElement)]];
    
    return false;
}

-(NSString *)getChartTypeString: (XuniChartElement) chartElement {
    switch (chartElement) {
        case XuniChartElementPlotArea:
            return @"PlotArea";
            break;
        case XuniChartElementAxisX:
            return @"AxisX";
            break;
        case XuniChartElementAxisY:
            return @"AxisY";
            break;
        case XuniChartElementChartArea:
            return @"ChartArea";
            break;
        case XuniChartElementLegend:
            return @"Legend";
            break;
        case XuniChartElementHeader:
            return @"Header";
            break;
        case XuniChartElementFooter:
            return @"Footer";
            break;
        case XuniChartElementNone:
            return @"None";
            break;
        default:
            return @"Invalid Type";
            break;
    }
}


@end