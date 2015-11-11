//
//  CustomPlotElementsController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "CustomPlotElementsController.h"
#import "ChartData.h"
#import "XuniFlexChartKit/XuniFlexChartKit.h"

@interface CustomPlotElementsController () {
}

@end

@implementation CustomPlotElementsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Custom Plot Elements"];
    
    // Do any additional setup after loading the view.
    FlexChart *chart = [[FlexChart alloc] init];
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
    
    IXuniEventHandler plotElementLoadingHandler = ^(NSObject *sender, XuniEventArgs *args)
    {
        XuniChartPlotElementEventArgs *plotArgs = (XuniChartPlotElementEventArgs*)args;
        if (plotArgs.renderEngine != nil && plotArgs.hitTestInfo != nil && plotArgs.defaultRender != nil) {
            [plotArgs.renderEngine setFill:[UIColor grayColor]];
            [plotArgs.defaultRender execute:nil];
            
            CGRect rect = [(DefaultBarElementRender*)(plotArgs.defaultRender) getBarRect];
            CustomPoint *customPoint = [chart.itemsSource objectAtIndex:plotArgs.hitTestInfo.pointIndex];
            if (customPoint != nil) {
                rect.origin.y += (rect.size.height - rect.size.width) / 2;
                rect.size.height = rect.size.width;
                [customPoint.logo drawInRect:rect];
            }
        }
    };
    [chart.plotElementLoading addHandler:plotElementLoadingHandler forObject:self];
    
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
