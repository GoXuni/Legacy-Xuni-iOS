//
//  ThemingController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "ThemingController.h"
@import XuniFlexChartDynamicKit;
#import "ChartData.h"

@interface ThemingController (){
    NSMutableArray *pickerData;
}
@property (weak, nonatomic) IBOutlet FlexChart *chart;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@end

@implementation ThemingController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:NSLocalizedString(@"Theming", nil)];
    
    pickerData =[[NSMutableArray alloc] initWithObjects:@"Standard", @"Cocoa", @"Coral", @"Dark", @"HighContrast", @"Light", @"Midnight", @"Minimal", @"Modern", @"Organic", @"Slate", @"Zen", @"Cyborg", @"Superhero", @"Flatly", @"Darkly", @"Cerulean", nil];

    self.picker.delegate = self;
    
    FlexChart *chart = self.chart;
    XuniSeries *sales = [[XuniSeries alloc] initForChart:chart binding:@"sales, sales" name:@"Sales"];
    XuniSeries *expenses = [[XuniSeries alloc] initForChart:chart binding:@"expenses, expenses" name:@"Expenses"];
    XuniSeries *downloads = [[XuniSeries alloc] initForChart:chart binding:@"downloads, downloads" name:@"Downloads"];
    
    [chart.series addObject:sales];
    [chart.series addObject:expenses];
    [chart.series addObject:downloads];
    
    chart.bindingX = @"name";
    chart.itemsSource = [ChartData demoData];
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [pickerData count];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    FlexChart *chart = self.chart;
     switch (row) {
        case 0:
            chart.palette = [XuniPalettes standard];
            break;
        case 1:
            chart.palette = [XuniPalettes cocoa];
            break;
        case 2:
            chart.palette = [XuniPalettes coral];
            break;
        case 3:
            chart.palette = [XuniPalettes dark];
            break;
        case 4:
            chart.palette = [XuniPalettes highcontrast];
            break;
        case 5:
            chart.palette = [XuniPalettes light];
            break;
        case 6:
            chart.palette = [XuniPalettes midnight];
            break;
        case 7:
            chart.palette = [XuniPalettes minimal];
            break;
        case 8:
            chart.palette = [XuniPalettes modern];
            break;
        case 9:
            chart.palette = [XuniPalettes organic];
            break;
        case 10:
            chart.palette = [XuniPalettes slate];
            break;
        case 11:
            chart.palette = [XuniPalettes zen];
            break;
        case 12:
            chart.palette = [XuniPalettes cyborg];
            break;
        case 13:
            chart.palette = [XuniPalettes superhero];
            break;
        case 14:
            chart.palette = [XuniPalettes flatly];
            break;
        case 15:
            chart.palette = [XuniPalettes darkly];
            break;
        case 16:
            chart.palette = [XuniPalettes cerulean];
            break;
        default:
            break;
    }
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [pickerData objectAtIndex:row];
}

@end
