//
//  XGGettingStartedViewController.m
//  Gauges101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//

#import "XGGettingStartedViewController.h"
#import "XuniGaugeKit/XuniGaugeKit.h"

@interface XGGettingStartedViewController ()
@property (weak, nonatomic) IBOutlet XuniRadialGauge *radialGauge;
@property (weak, nonatomic) IBOutlet XuniBulletGraph *bulletGraph;
@property (weak, nonatomic) IBOutlet XuniLinearGauge *linearGauge;
@property (weak, nonatomic) IBOutlet UIStepper *valueStepper;

@property (weak, nonatomic) IBOutlet UILabel *valueDisplay;

@end

@implementation XGGettingStartedViewController

- (IBAction)stepperValueChanged:(id)sender {
    _valueDisplay.text = [NSString stringWithFormat:@"%i", (int)_valueStepper.value];
    _radialGauge.value = _valueStepper.value;
    _linearGauge.value = _valueStepper.value;
    _bulletGraph.value = _valueStepper.value;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _valueDisplay.text = [NSString stringWithFormat:@"%i", (int)_valueStepper.value];
    
    _radialGauge.showText = XuniShowTextNone;
    _radialGauge.thickness = 0.6;
    _radialGauge.min = _valueStepper.minimumValue;
    _radialGauge.max = _valueStepper.maximumValue;
    _radialGauge.value = _valueStepper.value;
    _radialGauge.loadAnimation.duration = 2;
    _radialGauge.updateAnimation.duration = 0.5;
    _radialGauge.isReadOnly = false;
    _radialGauge.showText = XuniShowTextNone;
    
    
    [_radialGauge.gaugeValueChanged addHandler:^(NSObject* sender, XuniEventArgs* args)
    {
        _valueStepper.value = _radialGauge.value;
        [self stepperValueChanged:nil];
    }
                                     forObject:self];
    
    
    _linearGauge.showText = XuniShowTextNone;
    _linearGauge.min = _valueStepper.minimumValue;
    _linearGauge.max = _valueStepper.maximumValue;
    _linearGauge.value = _valueStepper.value;
    _linearGauge.loadAnimation.duration = 2;
    _linearGauge.updateAnimation.duration = 0.5;
    _linearGauge.isReadOnly = false;
    [_linearGauge.gaugeValueChanged addHandler:^(NSObject* sender, XuniEventArgs* args)
     {
         _valueStepper.value = _linearGauge.value;
         [self stepperValueChanged:nil];
     }
                                     forObject:self];
    
    _bulletGraph.showText = XuniShowTextNone;
    _bulletGraph.min = _valueStepper.minimumValue;
    _bulletGraph.max = _valueStepper.maximumValue;
    _bulletGraph.value = _valueStepper.value;
    _bulletGraph.loadAnimation.duration = 2;
    _bulletGraph.updateAnimation.duration = 0.5;
    _bulletGraph.isReadOnly = false;
    _bulletGraph.bad = 45;
    _bulletGraph.good = 80;
    _bulletGraph.target = 90;
    [_bulletGraph.gaugeValueChanged addHandler:^(NSObject* sender, XuniEventArgs* args)
     {
         _valueStepper.value = _bulletGraph.value;
         [self stepperValueChanged:nil];
     }
                                     forObject:self];
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
