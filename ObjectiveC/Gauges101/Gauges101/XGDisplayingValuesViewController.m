//
//  XGDisplayingValuesViewController.m
//  Gauges101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//

#import "XGDisplayingValuesViewController.h"
#import "XuniGaugeKit/XuniGaugeKit.h"

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
    
    _radialGauge.thickness = 0.6;
    _radialGauge.min = _valueStepper.minimumValue;
    _radialGauge.max = _valueStepper.maximumValue;
    _radialGauge.value = _valueStepper.value;
    _radialGauge.loadAnimation.duration = 2;
    _radialGauge.updateAnimation.duration = 0.5;
    _radialGauge.isReadOnly = false;
    _radialGauge.startAngle = 90;
    _radialGauge.sweepAngle = 90;

    
    [_radialGauge.gaugeValueChanged addHandler:^(NSObject* sender, XuniEventArgs* args)
     {
         _valueStepper.value = _radialGauge.value;
         [self stepperValueChanged:nil];
     }
                                     forObject:self];
    
    _linearGauge.min = _valueStepper.minimumValue;
    _linearGauge.max = _valueStepper.maximumValue;
    _linearGauge.value = _valueStepper.value;
    _linearGauge.loadAnimation.duration = 2;
    _linearGauge.updateAnimation.duration = 0.5;
    _linearGauge.isReadOnly = false;
    _linearGauge.backgroundColor = [UIColor clearColor];
    [_linearGauge.gaugeValueChanged addHandler:^(NSObject* sender, XuniEventArgs* args)
     {
         _valueStepper.value = _linearGauge.value;
         [self stepperValueChanged:nil];
     }
                                     forObject:self];
    
    
    _radialGauge.backgroundColor = _linearGauge.backgroundColor = [UIColor clearColor];
    _radialGauge.pointerColor = _linearGauge.pointerColor =  [UIColor whiteColor];
    _radialGauge.faceBorderWidth = _linearGauge.faceBorderWidth =  1;
    _radialGauge.faceBorderColor = _linearGauge.faceBorderColor = [UIColor whiteColor];
    _radialGauge.faceColor = _linearGauge.faceColor = [UIColor clearColor];
    _radialGauge.valueFontColor = [UIColor whiteColor];
    _linearGauge.valueFontColor = [UIColor blueColor];
    _radialGauge.minFontColor = _linearGauge.minFontColor = [UIColor whiteColor];
    _radialGauge.maxFontColor = _linearGauge.maxFontColor = [UIColor whiteColor];
    _radialGauge.valueFont = _linearGauge.valueFont = [UIFont fontWithName:@"Optima" size:19];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
