//
//  ConditionalFormattingController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "ConditionalFormattingController.h"
#import "ChartData.h"
#import "XuniFlexChartKit/XuniFlexChartKit.h"

@interface ConditionalFormattingController ()

@end

@implementation ConditionalFormattingController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Conditional Formatting"];
    
    // Do any additional setup after loading the view.
    FlexChart *chart = [[FlexChart alloc] init];
    XuniSeries *sine = [[XuniSeries alloc] initForChart:chart binding:@"y" name:@"sine"];
    sine.bindingX = @"x";
    [chart.series addObject:sine];
    
    chart.chartType = XuniChartTypeLineSymbols;
    chart.bindingX = @"x";
    chart.itemsSource = [self getData];
    chart.loadAnimation.animationMode = XuniAnimationModePoint;
    chart.axisY.format = @"F1";
    chart.axisX.format = @"F1";
    
    IXuniEventHandler plotElementLoadingHandler = ^(NSObject *sender, XuniEventArgs *args)
    {
        XuniChartPlotElementEventArgs *plotArgs = (XuniChartPlotElementEventArgs*)args;
        if (plotArgs.dataPoint != nil && plotArgs.defaultRender != nil) {
            double y = plotArgs.dataPoint.dataY;
            
            // change color values based on y-axis values
            CGFloat r = (y >= 0 ? 1 : ((1 + y)));
            CGFloat b = (y < 0 ? 1 : ((1 - y)));
            CGFloat g = (1 - fabs(y));
            CGFloat a = 0.8;
            
            ((DefaultPlotElementRender*)plotArgs.defaultRender).fillColor = [UIColor colorWithRed:r green:g blue:b alpha:a];
            [plotArgs.defaultRender execute:nil];
        }
    };
    [chart.plotElementLoading addHandler:plotElementLoadingHandler forObject:self];
    
    chart.tag = 1;
    [self.view addSubview:chart];
}

- (NSMutableArray*)getData {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 30; i++){
        [array addObject:[[ChartPoint alloc] initWithX:[NSNumber numberWithFloat:(0.16 * i)] y:[NSNumber numberWithFloat:cosf(0.12 * i)]]];
    }
    
    return array;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    FlexChart *chart = (FlexChart*)[self.view viewWithTag:1];
    chart.frame = CGRectMake(0, 65, self.view.bounds.size.width, self.view.bounds.size.height - 65);
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
