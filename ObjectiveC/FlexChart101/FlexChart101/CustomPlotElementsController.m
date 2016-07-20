//
//  CustomPlotElementsController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "CustomPlotElementsController.h"
#import "ChartData.h"
@import XuniFlexChartDynamicKit;

@interface CustomPlotElementsController ()
@property (weak, nonatomic) IBOutlet FlexChart *chart;

@end

@implementation CustomPlotElementsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FlexChart *chart = self.chart;
    XuniSeries *devicesSold = [[XuniSeries alloc] initForChart:chart binding:@"devicesSold" name:@"Devices sold"];
    [chart.series addObject:devicesSold];
    
    chart.bindingX = @"name";
    chart.itemsSource = [CustomPoint getList];
    chart.isAnimated = NO;
    chart.legend.position = XuniChartLegendPositionNone;
    chart.axisY.axisLineVisible = NO;
    chart.axisY.majorTickWidth = 0;
    chart.axisY.title = @"Devices Sold (billions)";
    chart.axisY.titleFont = [UIFont italicSystemFontOfSize:16.0f];
    chart.axisX.majorTickWidth = 0;
    chart.axisX.minorTickWidth = 1;
    
    [chart.plotElementLoading addHandler: ^(XuniEventContainer<XuniChartPlotElementEventArgs *> *eventContainer) {
        XuniChartPlotElementEventArgs *plotArgs = eventContainer.eventArgs;
        if (plotArgs.renderEngine != nil && plotArgs.hitTestInfo != nil && plotArgs.defaultRender != nil) {
            [plotArgs.renderEngine setFill:[UIColor grayColor]];
            [plotArgs.defaultRender execute:nil];
            
            CGRect rect = [(DefaultBarElementRender*)(plotArgs.defaultRender) getBarRect];
            CustomPoint *customPoint = [chart.itemsSource objectAtIndex:plotArgs.dataPoint.pointIndex];
            if (customPoint != nil) {
                rect.origin.y += (rect.size.height - rect.size.width) / 2;
                rect.size.height = rect.size.width;
                [customPoint.logo drawInRect:rect];
            }
        }
    } forObject:self];
}


@end

@implementation CustomPoint

- (id)initWithName:(NSString*)name devicesSold:(int)devicesSold logo:(UIImage *)logo {
    self = [super init];
    if(self){
        _name = name;
        _devicesSold = devicesSold;
        _logo = logo;
    }
    return self;
}

+ (NSMutableArray*)getList {
    int n = 3;
    NSArray *nameList = [[NSArray alloc] initWithObjects:@"Apple", @"Google", @"Microsoft", nil];
    NSMutableArray *list = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < n; i++){
        NSString *imageName = [nameList objectAtIndex:i];
        [list addObject:[[CustomPoint alloc] initWithName:imageName devicesSold:(arc4random() % 10 + 10) logo:[UIImage imageNamed:imageName.lowercaseString]]];
    }
    
    return list;
}

@end
