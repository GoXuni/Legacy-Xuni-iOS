//
//  XGGettingStartedViewController.m
//  Gauges101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//

#import "XGGettingStartedViewController.h"

@import XuniGaugeDynamicKit;

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
    
    _radialGauge.loadAnimation.duration = 2;
    _radialGauge.updateAnimation.duration = 0.5;
    
     [_radialGauge.gaugeValueChanged addHandler:^(XuniEventContainer *eventContainer) {
         _valueStepper.value = _radialGauge.value;
         [self stepperValueChanged:nil];
     } forObject:self];
    
    
    
    _linearGauge.loadAnimation.duration = 2;
    _linearGauge.updateAnimation.duration = 0.5;
    
    
    [_linearGauge.gaugeValueChanged addHandler:^(XuniEventContainer *eventContainer)
     {
         _valueStepper.value = _linearGauge.value;
         [self stepperValueChanged:nil];
     }
                                     forObject:self];
    

    _bulletGraph.loadAnimation.duration = 2;
    _bulletGraph.updateAnimation.duration = 0.5;
    
    [_bulletGraph.gaugeValueChanged addHandler:^(XuniEventContainer *eventContainer)
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
