//
//  ConditionalFormattingController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "ConditionalFormattingController.h"
#import "ChartData.h"
@import XuniFlexChartDynamicKit;

@interface ConditionalFormattingController ()
@property (weak, nonatomic) IBOutlet FlexChart *chart;

@end

@implementation ConditionalFormattingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XuniSeries *sine = [[XuniSeries alloc] initForChart:self.chart binding:@"y" name:@"sine"];
    sine.bindingX = @"x";
    [self.chart.series addObject:sine];
    
    self.chart.chartType = XuniChartTypeLineSymbols;
    self.chart.bindingX = @"x";
    self.chart.itemsSource = [self getData];
    self.chart.loadAnimation.animationMode = XuniAnimationModePoint;
    self.chart.axisY.format = @"F1";
    self.chart.axisX.format = @"F1";
    
    [self.chart.plotElementLoading addHandler: ^(XuniEventContainer<XuniChartPlotElementEventArgs *> *eventContainer) {
        XuniChartPlotElementEventArgs *plotArgs = eventContainer.eventArgs;
        if (plotArgs.dataPoint != nil && plotArgs.defaultRender != nil) {
            double y = plotArgs.dataPoint.value;
            
            // change color values based on y-axis values
            CGFloat r = (y >= 0 ? 1 : ((1 + y)));
            CGFloat b = (y < 0 ? 1 : ((1 - y)));
            CGFloat g = (1 - fabs(y));
            CGFloat a = 0.8;
            
            [plotArgs.renderEngine setFill:[UIColor colorWithRed:r green:g blue:b alpha:a]];
            [plotArgs.defaultRender execute:nil];
        }
    } forObject:self];
    
}

- (NSMutableArray*)getData {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 30; i++){
        [array addObject:[[ChartPoint alloc] initWithX:[NSNumber numberWithFloat:(0.16 * i)] y:[NSNumber numberWithFloat:cosf(0.12 * i)]]];
    }
    
    return array;
}

@end
