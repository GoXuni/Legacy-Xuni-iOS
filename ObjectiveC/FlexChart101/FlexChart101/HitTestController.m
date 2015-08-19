//
//  HitTestController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "HitTestController.h"
#import "HitTestData.h"
#import "FlexChartKit/FlexChartKit.h"

@interface HitTestController ()

@end

@implementation HitTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *chartElementlabel = [[UILabel alloc] init];
    chartElementlabel.text = @" Chart element";
    UILabel *seriesLabel = [[UILabel alloc] init];
    seriesLabel.text = @" Series";
    
    UILabel *pointIndexlabel = [[UILabel alloc] init];
    pointIndexlabel.text = @" Point Index";
    UILabel *xyLabel = [[UILabel alloc] init];
    xyLabel.text = @" X Y Values";

    FlexChart *chart = [[FlexChart alloc] init];
    chart.bindingX = @"x";
    XuniSeries *seriesCosX = [[XuniSeries alloc] initForChart:chart binding:@"y, y" name:@"cos(x)"];
    XuniSeries *seriesSinX = [[XuniSeries alloc] initForChart:chart binding:@"y, y" name:@"sin(x)"];
    seriesCosX.itemsSource = [HitTestData cosData];
    seriesSinX.itemsSource = [HitTestData sinData];
    
    [chart.series addObject:seriesCosX];
    [chart.series addObject:seriesSinX];
    
    chart.delegate = self;
    chart.axisX.labelsVisible = true;
    chart.axisY.labelsVisible = true;
    chart.chartType = XuniChartTypeLineSymbols;
    chart.axisY.format = @"f";
    chart.header = @"Trigonometric Functions";
    chart.footer = @"Cartesian coordinates";
    chart.legend.orientation = XuniChartLegendOrientationAuto;
    chart.legend.position = XuniChartLegendPositionAuto;
    chart.tooltip.visible = true;
    
    chart.tag = 1;
    seriesLabel.tag = 2;
    pointIndexlabel.tag = 3;
    xyLabel.tag = 4;
    chartElementlabel.tag = 5;
    
    [self.view addSubview:chartElementlabel];
    [self.view addSubview:chart];
    [self.view addSubview:pointIndexlabel];
    [self.view addSubview:seriesLabel];
    [self.view addSubview:xyLabel];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    FlexChart *chart = (FlexChart*)[self.view viewWithTag:1];
    UILabel *seriesLabel = (UILabel *)[self.view viewWithTag:2];
    UILabel *pointIndexLabel = (UILabel *)[self.view viewWithTag:3];
    UILabel *xyLabel = (UILabel *)[self.view viewWithTag:4];
    UILabel *chartElementLabel = (UILabel *)[self.view viewWithTag:5];
    chart.frame = CGRectMake(0, self.view.bounds.size.height/8, self.view.bounds.size.width, self.view.bounds.size.height*5/8);
    seriesLabel.frame = CGRectMake(0, self.view.bounds.size.height*13/16, self.view.bounds.size.width, self.view.bounds.size.height/16);
    pointIndexLabel.frame = CGRectMake(0, self.view.bounds.size.height *14/16, self.view.bounds.size.width, self.view.bounds.size.height/16);
    xyLabel.frame = CGRectMake(0, self.view.bounds.size.height *15/16, self.view.bounds.size.width, self.view.bounds.size.height/16);
    chartElementLabel.frame = CGRectMake(0, self.view.bounds.size.height*6/8, self.view.bounds.size.width, self.view.bounds.size.height/16);
    [chart setNeedsDisplay];
}

- (void)selectionChanged:(XuniHitTestInfo*)hitTestInfo {

}
- (void)seriesVisibilityChanged:(XuniSeries*)series{

}

- (void)rendered{
    
}

- (BOOL)tapped:(XuniPoint*)point{
    FlexChart *chart = (FlexChart*)[self.view viewWithTag:1];
    UILabel *s = (UILabel *)[self.view viewWithTag:2];
    UILabel *pi = (UILabel *)[self.view viewWithTag:3];
    UILabel *xy = (UILabel *)[self.view viewWithTag:4];
    UILabel *ce = (UILabel *)[self.view viewWithTag:5];
    XuniHitTestInfo *hitTest = [chart hitTest:point];
    pi.text = [@" Point Index: " stringByAppendingString: [NSString stringWithFormat:@"%i", hitTest.pointIndex]];
    xy.text = [[NSString stringWithFormat:@" X:%1.2f", point.x] stringByAppendingString: [NSString stringWithFormat:@" Y:%1.2f", point.y]];
    if (hitTest.series != nil) {
        s.text = [@" Series: " stringByAppendingString: hitTest.series.name];
    }
    else
    {
        s.text = @" null";
    }
    ce.text = [@" Chart element: " stringByAppendingString: [self getChartTypeString:(hitTest.chartElement)]];
    return true;
}

-(NSString *)getChartTypeString: (XuniChartElement) chartElement{
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

- (void) axisRangeChanged:(NSObject *)axis{
    
}


- (void)handleTooltip:(XuniPoint*)point isVisible:(BOOL)isVisible data:(NSArray*)data{
    
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end