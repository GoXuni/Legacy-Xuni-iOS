//
//  BasicFeaturesController.m
//  FlexPie101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "BasicFeaturesController.h"
@import XuniFlexPieDynamicKit;
#import "PieChartData.h"

@interface BasicFeaturesController ()
@property (weak, nonatomic) IBOutlet UIStepper *stepper;
@property (weak, nonatomic) IBOutlet UILabel *innerRadiusLabel;
@property (weak, nonatomic) IBOutlet UISlider *offsetSlider;
@property (weak, nonatomic) IBOutlet UISlider *startAngleSlider;
@property (weak, nonatomic) IBOutlet UISwitch *reversedSwitch;
@property (weak, nonatomic) IBOutlet FlexPie *pieChart;

@end

@implementation BasicFeaturesController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *pieData = [PieChartData demoData];
    
    self.pieChart.binding = @"value";
    self.pieChart.bindingName = @"name";
    self.pieChart.itemsSource = pieData;
    
}

- (IBAction)switchValueChanged:(id)sender {
    
    UISwitch* switchState = (UISwitch*)sender;
    if ([switchState isOn]) {
        self.pieChart.reversed = true;
    }
    else
    {
        self.pieChart.reversed = false;
    }
}

- (IBAction)valueChanged:(id)sender {
    UIStepper *stepper =(UIStepper*)sender;
    
    self.pieChart.innerRadius = stepper.value;
    self.innerRadiusLabel.text = [NSString stringWithFormat:@"%1.1f", stepper.value];
    [self.innerRadiusLabel sizeToFit];
}

- (IBAction)offsetChanged:(id)sender {
    UISlider *slider =(UISlider*)sender;
    self.pieChart.offset = slider.value;
}

- (IBAction)startAngleChanged:(id)sender {
    UISlider *slider =(UISlider*)sender;
    self.pieChart.startAngle = slider.value;
}

@end
