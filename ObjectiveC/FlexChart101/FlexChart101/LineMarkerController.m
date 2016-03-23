//
//  LineMarkerController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "LineMarkerController.h"
#import "ChartData.h"
#import "XuniFlexChartKit/XuniFlexChartKit.h"

@interface LineMarkerController (){
    NSMutableArray *interactionPickerData;
    NSMutableArray *verticalPositionPickerData;
}

@end

@implementation LineMarkerController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:NSLocalizedString(@"Line Marker", nil)];
    
    // Do any additional setup after loading the view.
    interactionPickerData = [[NSMutableArray alloc] initWithObjects: @"None", @"Move", @"Drag", nil];
    verticalPositionPickerData = [[NSMutableArray alloc] initWithObjects: @"NaN", @"0", @"0.25",  @"0.5", @"0.75", @"1", nil];
    
    UIPickerView *interactionPicker = [[UIPickerView alloc] init];
    interactionPicker.delegate = self;
    
    UIPickerView *verticalPositionPicker = [[UIPickerView alloc] init];
    verticalPositionPicker.delegate = self;
    
    FlexChart *chart = [[FlexChart alloc] init];
    NSMutableArray *chartData = [ChartData demoData];
    chart.bindingX = @"name";
    
    XuniSeries *sales = [[XuniSeries alloc] initForChart:chart binding:@"sales, sales" name:@"Sales"];
    XuniSeries *expenses = [[XuniSeries alloc] initForChart:chart binding:@"expenses, expenses" name:@"Expenses"];
    XuniSeries *downloads = [[XuniSeries alloc] initForChart:chart binding:@"downloads, downloads" name:@"Downloads"];
    
    [chart.series addObject:sales];
    [chart.series addObject:expenses];
    [chart.series addObject:downloads];
    
    chart.itemsSource = chartData;
    chart.chartType = XuniChartTypeBar;
    
    // Implement Chart Line Marker.
    MyMarkerView *view = [[MyMarkerView alloc] initWithLineMarker:chart.lineMarker];
    view.markerRender = [[MyChartMarkerRender alloc] initWithView:view];
    chart.lineMarker.content = view;
    chart.lineMarker.isVisible = YES;
    chart.lineMarker.alignment = XuniChartMarkerAlignmentBottomRight;
    chart.lineMarker.lines = XuniChartMarkerLinesVertical;
    chart.lineMarker.interaction= XuniChartMarkerInteractionMove;
    chart.lineMarker.dragContent = YES;
    chart.lineMarker.seriesIndex = -1;
    chart.lineMarker.verticalLineColor = [UIColor grayColor];
    chart.lineMarker.verticalPosition = 0;
    [chart addSubview:view];
    
    chart.tag = 1;
    interactionPicker.tag = 2;
    verticalPositionPicker.tag = 3;
    
    [self.view addSubview:interactionPicker];
    [self.view addSubview:verticalPositionPicker];
    [self.view addSubview:chart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIPickerView *interactionPicker = (UIPickerView*)[self.view viewWithTag:2];
    [interactionPicker selectRow:1 inComponent:0 animated:NO];
    
    UIPickerView *verticalPositionPicker = (UIPickerView*)[self.view viewWithTag:3];
    [verticalPositionPicker selectRow:1 inComponent:0 animated:NO];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    FlexChart *chart = (FlexChart*)[self.view viewWithTag:1];
    UIPickerView *interactionPicker = (UIPickerView*)[self.view viewWithTag:2];
    UIPickerView *verticalPositionPicker = (UIPickerView*)[self.view viewWithTag:3];
    CGFloat halfWidth = self.view.bounds.size.width / 2;
    
    interactionPicker.frame = CGRectMake(0, 30, halfWidth, 162);
    verticalPositionPicker.frame = CGRectMake(halfWidth, 30, halfWidth, 162);
    chart.frame = CGRectMake(0, 162, self.view.bounds.size.width, self.view.bounds.size.height - 162);
    [chart setNeedsDisplay];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(pickerView.tag == 2){
        return [interactionPickerData count];
    }
    else if(pickerView.tag == 3){
        return [verticalPositionPickerData count];
    }
    else {
        return 0;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    FlexChart *chart = (FlexChart *)[self.view viewWithTag:1];
    
    if(pickerView.tag == 2){
        if (row == 0) {
            chart.lineMarker.interaction = XuniChartMarkerInteractionNone;
        }
        else if (row == 1){
            chart.lineMarker.interaction = XuniChartMarkerInteractionMove;
        }
        else if (row == 2){
            chart.lineMarker.interaction = XuniChartMarkerInteractionDrag;
        }
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

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(pickerView.tag == 2){
        return [interactionPickerData objectAtIndex:row];
    }
    else if(pickerView.tag == 3){
        return [verticalPositionPickerData objectAtIndex:row];
    }
    else{
        return @"error";
    }
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
