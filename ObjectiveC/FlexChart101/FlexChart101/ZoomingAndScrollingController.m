//
//  ZoomingAndScrollingController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "ZoomingAndScrollingController.h"
@import XuniFlexChartDynamicKit;
#import "ChartData.h"

@interface ZoomingAndScrollingController (){
    NSMutableArray *pickerData;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *zoomModeSelector;
@property (weak, nonatomic) IBOutlet FlexChart *chart;

@end

@implementation ZoomingAndScrollingController
- (IBAction)zoomModeChanged:(id)sender {
    int row = self.zoomModeSelector.selectedSegmentIndex;
    if (row == 0) {
        self.chart.zoomMode = XuniZoomModeX;
    }
    else if (row == 1){
        self.chart.zoomMode = XuniZoomModeY;
    }
    else if (row == 2){
        self.chart.zoomMode = XuniZoomModeXY;
    }
    else if (row == 3){
        self.chart.zoomMode = XuniZoomModeDisabled;
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    FlexChart *chart = self.chart;
    
    self.zoomModeSelector.selectedSegmentIndex = 2;
    [self zoomModeChanged:nil];
    
    XuniSeries *sales = [[XuniSeries alloc] initForChart:chart binding:@"y" name:@"Normal Distribution"];
    [chart.series addObject:sales];
    
    chart.itemsSource = [ChartPoint generateRandomPoints:500];
    chart.bindingX = @"x";
    chart.chartType = XuniChartTypeScatter;
    chart.zoomMode = XuniZoomModeXY;
    chart.isAnimated = NO;
    chart.header = @"Drag to scroll/Pinch to zoom";
    chart.headerFont = [UIFont systemFontOfSize:14];
    chart.headerTextAlignment = XuniHorizontalAlignmentCenter;
    chart.palette = [XuniPalettes superhero];
    chart.axisY.format = @"N2";

}


@end
