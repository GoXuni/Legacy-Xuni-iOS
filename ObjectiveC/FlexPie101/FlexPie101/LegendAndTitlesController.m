//
//  LegendAndTitlesController.m
//  FlexPie101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "LegendAndTitlesController.h"
@import XuniFlexPieDynamicKit;
#import "PieChartData.h"

@interface LegendAndTitlesController ()
@property (weak, nonatomic) IBOutlet UITextField *footerField;
@property (weak, nonatomic) IBOutlet UITextField *headerField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *legendModeSelector;
@property (weak, nonatomic) IBOutlet FlexPie *flexPie;

@end

@implementation LegendAndTitlesController

- (IBAction)changeLegendMode:(id)sender {
    FlexPie *pie = self.flexPie;
    int row = self.legendModeSelector.selectedSegmentIndex;
    if (row == 0) {
        pie.legend.position = XuniChartLegendPositionNone;
    }
    else if (row == 1){
        pie.legend.position = XuniChartLegendPositionLeft;
    }
    else if (row == 2){
        pie.legend.position = XuniChartLegendPositionTop;
    }
    else if (row == 3){
        pie.legend.position = XuniChartLegendPositionRight;
    }
    else if(row == 4){
        pie.legend.position = XuniChartLegendPositionBottom;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


    self.legendModeSelector.selectedSegmentIndex = 3;
    
    NSMutableArray *pieData = [PieChartData demoData];
    self.flexPie.legend.position = XuniChartLegendPositionRight;
    self.flexPie.binding = @"value";
    self.flexPie.bindingName = @"name";
    self.flexPie.itemsSource = pieData;
    self.flexPie.tooltip.isVisible = true;
    self.flexPie.header = self.headerField.text;
    self.flexPie.footer = self.footerField.text;
    
}

- (IBAction)endEdit:(id)sender {
    [(UITextField*)sender resignFirstResponder];
}

- (IBAction)edited:(id)sender {
    self.flexPie.header = self.headerField.text;
    self.flexPie.footer = self.footerField.text;
}



@end