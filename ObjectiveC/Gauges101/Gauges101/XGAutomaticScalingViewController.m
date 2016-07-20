//
//  XGAutomaticScalingViewController.m
//  Gauges101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//

#import "XGAutomaticScalingViewController.h"
@import XuniGaugeDynamicKit;

@interface XGAutomaticScalingViewController ()
@property (weak, nonatomic) IBOutlet UIStepper *startAngleStepper;
@property (weak, nonatomic) IBOutlet UILabel *startAngleDisplay;
@property (weak, nonatomic) IBOutlet UILabel *sweepAngleDisplay;
@property (weak, nonatomic) IBOutlet UIStepper *sweepAngleStepper;
@property (weak, nonatomic) IBOutlet XuniRadialGauge *radialGauge;

@end

@implementation XGAutomaticScalingViewController

- (IBAction)angleChanged:(id)sender {
    _radialGauge.startAngle = self.startAngleStepper.value;
    _radialGauge.sweepAngle = self.sweepAngleStepper.value;
    
    self.startAngleDisplay.text = [NSString stringWithFormat:@"%i", (int)_radialGauge.startAngle];
    self.sweepAngleDisplay.text = [NSString stringWithFormat:@"%i", (int)_radialGauge.sweepAngle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    _radialGauge.loadAnimation.duration = 2;
    _radialGauge.updateAnimation.duration = 3.5;
    
    
    [self angleChanged:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(generateRandomNumber:) userInfo:nil repeats:true];


}

-(void)generateRandomNumber:(id) sender{
    _radialGauge.value = (arc4random()% 201);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
