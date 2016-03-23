//
//  XGUsingRangesViewController.m
//  Gauges101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//

#import "XGUsingRangesViewController.h"
#import <XuniGaugeKit/XuniGaugeKit.h>

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

    
    _radialGauge.thickness = 0.6;
    _radialGauge.min = _valueStepper.minimumValue;
    _radialGauge.max = _valueStepper.maximumValue;
    _radialGauge.value = _valueStepper.value;
    _radialGauge.loadAnimation.duration = 2;
    _radialGauge.updateAnimation.duration = 0.5;
    _radialGauge.isReadOnly = false;
    
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
