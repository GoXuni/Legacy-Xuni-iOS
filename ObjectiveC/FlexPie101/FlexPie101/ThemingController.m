//
//  ThemingController.m
//  FlexPie101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "ThemingController.h"
@import XuniFlexPieDynamicKit;
#import "PieChartData.h"

@interface ThemingController (){
    NSMutableArray *pickerData;
}
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet FlexPie *pieChart;
@end

@implementation ThemingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    pickerData =[[NSMutableArray alloc] initWithObjects:@"Standard", @"Cocoa", @"Coral", @"Dark", @"HighContrast", @"Light", @"Midnight", @"Minimal", @"Modern", @"Organic", @"Slate", @"Zen", @"Cyborg", @"Superhero", @"Flatly", @"Darkly", @"Cerulean", nil];
    
    self.pickerView.delegate = self;
    self.pickerView.showsSelectionIndicator = YES;
    self.pickerView.hidden = false;
    
    
    NSMutableArray *pieData = [PieChartData demoData];
    
    self.pieChart.binding = @"value";
    self.pieChart.bindingName = @"name";
    self.pieChart.itemsSource = pieData;
    self.pieChart.tooltip.isVisible = true;

    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [pickerData count];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    FlexPie *chart = self.pieChart;
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
