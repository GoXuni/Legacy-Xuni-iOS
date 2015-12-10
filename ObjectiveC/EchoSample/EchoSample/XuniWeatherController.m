//
//  XuniWeatherController.m
//  XuniExplorer
//
//  Created by kelley.ricker on 10/15/15.
//  Copyright © 2015 GrapeCity. All rights reserved.
//

#import "XuniWeatherController.h"
#import "WeatherData.h"
#import "XuniFlexChartKit/XuniFlexChartKit.h"
#import "XuniFlexGridKit/XuniFlexGridKit.h"

@interface XuniWeatherController (){
    UITextField *_locationField;
    FlexGrid *_grid;
    FlexChart *_chart;
}

@end

@implementation XuniWeatherController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = NSLocalizedString(@"Xuni Weather", @"Xuni Weather");
    /*
    _locationField = [[UITextField alloc] init];
    _locationField.delegate = self;
    _locationField.text = @"Enter ZIP Code";
    _locationField.returnKeyType = UIReturnKeyDone;
    _locationField.keyboardType = UIKeyboardTypeDefault;
    _locationField.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
    */
    _grid = [[FlexGrid alloc] init];
    _chart = [[FlexChart alloc]init];
    
    NSMutableArray *fiveDay = [WeatherData demoData:@"OfflineWeatherData"];
    
    _grid.isReadOnly = true;
    _chart.bindingX = @"date";
    XuniSeries *humidity = [[XuniSeries alloc] initForChart:_chart binding:@"humidity, humidity" name:@"Humidity %"];
    XuniSeries *high = [[XuniSeries alloc] initForChart:_chart binding:@"highTemp, highTemp" name:@"High Temp (F)"];
    high.chartType = XuniChartTypeLine;
    
    [_chart.series addObject:humidity];
    [_chart.series addObject:high];
    
    _chart.axisX.labelsVisible = true;
    _chart.axisY.labelsVisible = true;
    _chart.palette = [XuniPalettes organic];
    _chart.selectionMode = XuniSelectionModePoint;
    _chart.tooltip.isVisible = false;
    _chart.delegate = self;
    _grid.itemsSource = fiveDay;
    _chart.itemsSource = fiveDay;
    if(UI_USER_INTERFACE_IDIOM()  == UIUserInterfaceIdiomPad){
        [self starSizing:_grid];
    }
    else{
        [_grid autoSizeColumn:0 to:(_grid.columns.count-1)];
    }
    _grid.alternatingRowBackgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
    humidity.chartType = XuniChartTypeArea;
    humidity.color = [UIColor colorWithRed:.74 green:.85 blue:.95 alpha:1];
    high.borderWidth = 2.5;
    _chart.legend.orientation = XuniChartLegendOrientationAuto;
    _chart.legend.position = XuniChartLegendPositionBottom;
    
    MyMarkerView *view = [[MyMarkerView alloc] initWithLineMarker:_chart.lineMarker];
    view.markerRender = [[MyChartMarkerRender alloc] initWithView:view];
    _chart.lineMarker.content = view;
    _chart.lineMarker.isVisible = YES;
    _chart.lineMarker.alignment = XuniChartMarkerAlignmentBottomRight;
    _chart.lineMarker.lines = XuniChartMarkerLinesVertical;
    _chart.lineMarker.interaction= XuniChartMarkerInteractionMove;
    _chart.lineMarker.dragContent = YES;
    _chart.lineMarker.seriesIndex = -1;
    _chart.lineMarker.verticalLineColor = [UIColor grayColor];
    _chart.lineMarker.verticalPosition = 0;
    [_chart addSubview:view];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"M-dd h:mm a"];
    FlexColumn *c = [_grid.columns objectAtIndex:0];
    c.formatter = dateFormatter;
    c.header = @"date/time";
    [self.view addSubview:_grid];
    [self.view addSubview:_chart];
    
    [self.view addSubview:_locationField];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _chart.frame = CGRectMake(0, 0, self.view.bounds.size.width, (self.view.bounds.size.height)/2);
    _grid.frame = CGRectMake(0, (self.view.bounds.size.height)/2, self.view.bounds.size.width, (self.view.bounds.size.height )/2);
    [_grid setNeedsDisplay];
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
    if(UI_USER_INTERFACE_IDIOM()  == UIUserInterfaceIdiomPad){
        [self starSizing:_grid];
    }
    else{
        [_grid autoSizeColumn:0 to:(_grid.columns.count-1)];
    }
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


-(void)starSizing:(FlexGrid*)g{
    for (int i = 0; i < g.columns.count; i++) {
        FlexColumn *c = [g.columns objectAtIndex:i];
        c.widthType = FlexColumnWidthStar;
    }
}


@end


// Class MyMarkerView
@implementation MyMarkerView

- (id)initWithLineMarker:(XuniChartLineMarker *)lineMarker {
    self = [super initWithLineMarker:lineMarker];
    if (self) {
        _lineMarker = lineMarker;
        
        self.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
        self.frame = CGRectMake(0, 0, 115, 60);
        
        _content = [[UILabel alloc] init];
        _content.frame = CGRectMake(5, 5, 105, 50);
        _content.backgroundColor = [UIColor clearColor];
        _content.font = [UIFont systemFontOfSize:10.0];
        [self addSubview:_content];
    }
    
    return self;
}

@end

// Class MyChartMarkerRender
@implementation MyChartMarkerRender {
    XuniChartMarkerBaseView *_view;
}

- (id)initWithView:(XuniChartMarkerBaseView *)view {
    _view = view;
    return self;
}

- (void)renderMarker {
    if (_view != nil ) {
        MyMarkerView *view = (MyMarkerView *)_view;
        NSArray *data = view.lineMarker.dataPoints;
        
        if (data != nil && data.count > 0) {
            NSString *str = @"";
            XuniDataPoint *point = data[0];
            str = [str stringByAppendingFormat:@"%@ \n", point.dataXString];
            
            for (int i = 0; i < data.count - 1; i++) {
                point = data[i];
                str = [str stringByAppendingFormat:@"%@ : %.2f \n", point.seriesName, point.dataY];
            }
            point = data[data.count - 1];
            str = [str stringByAppendingFormat:@"%@ : %.2f", point.seriesName, point.dataY];
            
            view.content.text = str;
            view.content.numberOfLines = 4;
        }
    }
}

@end

