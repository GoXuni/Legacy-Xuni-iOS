//
//  LineMarkerController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "LineMarkerController.h"
#import "ChartData.h"
@import XuniFlexChartDynamicKit;

@interface LineMarkerController ()
@property (weak, nonatomic) IBOutlet FlexChart *chart;
@property (weak, nonatomic) IBOutlet UISlider *positionSelect;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSelect;

@end

@implementation LineMarkerController
- (IBAction)modeSelected:(id)sender {
    int row = _modeSelect.selectedSegmentIndex;
    if (row == 0) {
        self.chart.lineMarker.interaction = XuniChartMarkerInteractionNone;
    }
    else if (row == 1){
        self.chart.lineMarker.interaction = XuniChartMarkerInteractionMove;
    }
    else if (row == 2){
        self.chart.lineMarker.interaction = XuniChartMarkerInteractionDrag;
    }
}

- (IBAction)positionChanged:(id)sender {
    double pos = self.positionSelect.value;
    if(pos == 0) pos = NAN;
    self.chart.lineMarker.verticalPosition = pos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Line Marker"];
    
    NSMutableArray *chartData = [ChartData demoData];
    self.chart.bindingX = @"name";
    
    XuniSeries *sales = [[XuniSeries alloc] initForChart:self.chart binding:@"sales, sales" name:@"Sales"];
    XuniSeries *expenses = [[XuniSeries alloc] initForChart:self.chart binding:@"expenses, expenses" name:@"Expenses"];
    XuniSeries *downloads = [[XuniSeries alloc] initForChart:self.chart binding:@"downloads, downloads" name:@"Downloads"];
    
    [self.chart.series addObject:sales];
    [self.chart.series addObject:expenses];
    [self.chart.series addObject:downloads];
    
    self.chart.itemsSource = chartData;
    self.chart.chartType = XuniChartTypeLine;
    
    // Implement Chart Line Marker.
    MyMarkerView *view = [[MyMarkerView alloc] initWithLineMarker:self.chart.lineMarker];
    view.markerRender = [[MyChartMarkerRender alloc] initWithView:view];
    self.chart.lineMarker.content = view;
    self.chart.lineMarker.isVisible = YES;
    self.chart.lineMarker.alignment = XuniChartMarkerAlignmentBottomRight;
    self.chart.lineMarker.lines = XuniChartMarkerLinesVertical;
    self.chart.lineMarker.interaction= XuniChartMarkerInteractionMove;
    self.chart.lineMarker.dragContent = YES;
    self.chart.lineMarker.seriesIndex = -1;
    self.chart.lineMarker.verticalLineColor = [UIColor grayColor];
    self.chart.lineMarker.verticalPosition = 0;
    [self.chart addSubview:view];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _modeSelect.selectedSegmentIndex = 1;
    _positionSelect.value = 0.001;
    
    [self modeSelected:nil];
    [self positionChanged:nil];
}



- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    FlexChart *chart = (FlexChart *)[self.view viewWithTag:1];
    
    if(pickerView.tag == 2){

    }
    else if(pickerView.tag == 3){
        if (row == 0) {
            chart.lineMarker.verticalPosition = NAN;
        }
        else if (row == 1){
            chart.lineMarker.verticalPosition = 0;
        }
        else if (row == 2){
            chart.lineMarker.verticalPosition = 0.25;
        }
        else if (row == 3){
            chart.lineMarker.verticalPosition = 0.5;
        }
        else if (row == 4){
            chart.lineMarker.verticalPosition = 0.75;
        }
        else if (row == 5){
            chart.lineMarker.verticalPosition = 1;
        }
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
        self.frame = CGRectMake(0, 0, 110, 60);
        
        _content = [[UILabel alloc] init];
        _content.frame = CGRectMake(5, 5, 100, 50);
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
            XuniChartDataPoint *point = data[0];
            str = [str stringByAppendingFormat:@"%@ \n", point.valueX];
            
            for (int i = 0; i < data.count - 1; i++) {
                point = data[i];
                str = [str stringByAppendingFormat:@"%@ : %.0f \n", point.seriesName, point.value];
            }
            point = data[data.count - 1];
            str = [str stringByAppendingFormat:@"%@ : %.0f", point.seriesName, point.value];
            
            view.content.text = str;
            view.content.numberOfLines = 4;
        }
    }
}

@end
