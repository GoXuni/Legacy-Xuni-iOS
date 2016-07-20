//
//  XGDisplayingValuesViewController.m
//  Gauges101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//

#import "XGDisplayingValuesViewController.h"
@import XuniGaugeDynamicKit;

@interface XGDisplayingValuesViewController ()
@property (weak, nonatomic) IBOutlet UILabel *valueDisplay;
@property (weak, nonatomic) IBOutlet UIStepper *valueStepper;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSelector;
@property (weak, nonatomic) IBOutlet XuniLinearGauge *linearGauge;
@property (weak, nonatomic) IBOutlet XuniRadialGauge *radialGauge;

@end

@implementation XGDisplayingValuesViewController

- (IBAction)stepperValueChanged:(id)sender {
    _valueDisplay.text = [NSString stringWithFormat:@"%i", (int)_valueStepper.value];
    _radialGauge.value = _valueStepper.value;
    _linearGauge.value = _valueStepper.value;
}

- (IBAction)modeSelected:(id)sender {
    XuniShowText st = XuniShowTextAll;
    
    switch(_modeSelector.selectedSegmentIndex)
    {
        case 0:
            st = XuniShowTextAll;
            break;
        case 1:
            st = XuniShowTextMinMax;
            break;
        case 2:
            st = XuniShowTextValue;
            break;
        case 3:
            st = XuniShowTextNone;
            break;
    }
    
    _radialGauge.showText = st;
    _linearGauge.showText = st;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _valueDisplay.text = [NSString stringWithFormat:@"%i", (int)_valueStepper.value];
    
    [self modeSelected:nil];
    
    _radialGauge.loadAnimation.duration = 2;
    _radialGauge.updateAnimation.duration = 0.5;

    
    [_radialGauge.gaugeValueChanged addHandler:^(XuniEventContainer *eventContainer)
     {
         _valueStepper.value = _radialGauge.value;
         [self stepperValueChanged:nil];
     }
                                     forObject:self];
    
    _linearGauge.loadAnimation.duration = 2;
    _linearGauge.updateAnimation.duration = 0.5;
    
    [_linearGauge.gaugeValueChanged addHandler:^(XuniEventContainer *eventContainer)
     {
         _valueStepper.value = _linearGauge.value;
         [self stepperValueChanged:nil];
     }
                                     forObject:self];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
