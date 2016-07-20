//
//  XGUsingRangesViewController.m
//  Gauges101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//

#import "XGUsingRangesViewController.h"
@import XuniGaugeDynamicKit;

@interface XGUsingRangesViewController ()
@property (weak, nonatomic) IBOutlet UIStepper *valueStepper;
@property (weak, nonatomic) IBOutlet UILabel *valueDisplay;
@property (weak, nonatomic) IBOutlet XuniLinearGauge *linearGauge;
@property (weak, nonatomic) IBOutlet XuniRadialGauge *radialGauge;
@property (weak, nonatomic) IBOutlet UISwitch *rangesSelector;

@end

@implementation XGUsingRangesViewController

- (IBAction)stepperValueChanged:(id)sender {
    _valueDisplay.text = [NSString stringWithFormat:@"%i", (int)_valueStepper.value];
    _radialGauge.value = _valueStepper.value;
    _linearGauge.value = _valueStepper.value;
}

- (IBAction)rangesValueChanged:(id)sender {
    _radialGauge.showRanges = _linearGauge.showRanges = _rangesSelector.isOn;
    if(_rangesSelector.isOn)
    {
        _linearGauge.pointer.thickness = _radialGauge.pointer.thickness = 0.3;
    }
    else
    {
        _linearGauge.pointer.thickness = _radialGauge.pointer.thickness = 1;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _valueDisplay.text = [NSString stringWithFormat:@"%i", (int)_valueStepper.value];

    
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
    
    
    // Create ranges.
    XuniGaugeRange* lower = [[XuniGaugeRange alloc] initWithGauge:_linearGauge];
    lower.min = 0;
    lower.max = 40;
    lower.color = [UIColor colorWithRed:0.133 green:0.694 blue:0.298 alpha:1];
    lower.borderColor = [UIColor whiteColor];
    lower.borderWidth = 1;
    XuniGaugeRange* middle = [[XuniGaugeRange alloc] initWithGauge:_linearGauge];
    middle.min = 40;
    middle.max = 80;
    middle.color = [UIColor colorWithRed:1 green:0.502 blue:0.502 alpha:1];
    middle.borderColor = [UIColor whiteColor];
    middle.borderWidth = 1;
    XuniGaugeRange* upper = [[XuniGaugeRange alloc] initWithGauge:_linearGauge];
    upper.min = 80;
    upper.max = 100;
    upper.color = [UIColor colorWithRed:0 green:0.635 blue:0.91 alpha:1];
    upper.borderColor = [UIColor whiteColor];
    upper.borderWidth = 1;
    
    // Add ranges.
    [_linearGauge.ranges addObject:lower];
    [_linearGauge.ranges addObject:middle];
    [_linearGauge.ranges addObject:upper];
    [_radialGauge.ranges addObject:lower];
    [_radialGauge.ranges addObject:middle];
    [_radialGauge.ranges addObject:upper];
    
    
    [self stepperValueChanged:nil];
    [self rangesValueChanged:nil];
}


@end
