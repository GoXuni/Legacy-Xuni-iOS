//
//  SelectionSampleController.m
//  FlexPie101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "SelectionSampleController.h"
@import XuniFlexPieDynamicKit;
#import "PieChartData.h"
@interface SelectionSampleController (){
    NSMutableArray *pickerData;
}
@property (weak, nonatomic) IBOutlet UILabel *offsetLabel;
@property (weak, nonatomic) IBOutlet UISwitch *isAnimatedSwitch;
@property (weak, nonatomic) IBOutlet UISegmentedControl *positionSelector;
@property (weak, nonatomic) IBOutlet FlexPie *flexPie;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;
@end

@implementation SelectionSampleController
- (IBAction)positionChanged:(id)sender {
    FlexPie *pie = self.flexPie;
    int row = self.positionSelector.selectedSegmentIndex;
    if (row == 0) {
        pie.selectedItemPosition = XuniPositionNone;
    }
    else if (row == 1){
        pie.selectedItemPosition = XuniPositionLeft;
    }
    else if (row == 2){
        pie.selectedItemPosition  = XuniPositionTop;
    }
    else if (row == 3){
        pie.selectedItemPosition  = XuniPositionRight;
    }
    else if(row == 4){
        pie.selectedItemPosition  = XuniPositionBottom;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.positionSelector.selectedSegmentIndex = 4;
    
    NSMutableArray *pieData = [PieChartData demoData];
    
    self.offsetLabel.text = [NSString stringWithFormat:@"%1.1f", self.stepper.value];
    
    self.flexPie.binding = @"value";
    self.flexPie.bindingName = @"name";
    self.flexPie.itemsSource = pieData;
    self.flexPie.tooltip.isVisible = true;
    self.flexPie.selectedItemOffset = self.stepper.value;
    self.flexPie.selectedItemPosition = XuniPositionBottom;
    self.flexPie.isAnimated = false;

}

- (IBAction)switchAnimation:(id)sender {
    
    if ([self.isAnimatedSwitch isOn]) {
        self.flexPie.isAnimated = true;
    }
    else
    {
        self.flexPie.isAnimated = false;
    }
}

-(IBAction)stepperClicked:(id) sender{
    UIStepper *stepper =(UIStepper*)sender;
    self.flexPie.selectedItemOffset = stepper.value;
    self.offsetLabel.text = [NSString stringWithFormat:@"%1.1f", stepper.value];
    [self.offsetLabel sizeToFit];
}


@end
