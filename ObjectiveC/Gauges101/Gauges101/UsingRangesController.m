//
//  UsingRangesController.m
//  Gauges101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "UsingRangesController.h"
#import "XuniGaugeKit/XuniGaugeKit.h"

@interface UsingRangesController (){
    UILabel *_title;
}

@end

@implementation UsingRangesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    XuniLinearGauge *linearGauge;
    XuniRadialGauge *radialGauge;
    UILabel *showRangesLabel;
    UIStepper *stepper;
    UISwitch *rangeSwitch;
    double min;
    double max;
    double val;
    
    min = 0;
    max = 100;
    val = 25;
    
    _title =[[UILabel alloc] init];
    _title.textAlignment = NSTextAlignmentCenter;
    _title.textColor = [UIColor blackColor];
    _title.text = @"Using Ranges";

    stepper =[[UIStepper alloc] init];
    stepper.maximumValue = max;
    stepper.minimumValue = min;
    stepper.value = val;
    stepper.tag = 5;
    stepper.stepValue = 25;
    [stepper addTarget:self action:@selector(stepperClicked:) forControlEvents:UIControlEventValueChanged];
    
    
    linearGauge = [[XuniLinearGauge alloc] init];
    linearGauge.tag = 1;
    linearGauge.showText = XuniShowTextNone;
    linearGauge.thickness = 0.6;
    linearGauge.min = min;
    linearGauge.max = max;
    linearGauge.value = val;
    linearGauge.loadAnimation.duration = 2;
    linearGauge.updateAnimation.duration = 0.5;
    linearGauge.showRanges = false;
    
    radialGauge = [[XuniRadialGauge alloc] init];
    radialGauge.tag = 2;
    radialGauge.showText = XuniShowTextNone;
    radialGauge.thickness = 0.6;
    radialGauge.min = min;
    radialGauge.max = max;
    radialGauge.value = val;
    radialGauge.loadAnimation.duration = 2;
    radialGauge.updateAnimation.duration = 0.5;
    radialGauge.showRanges = false;
    
    // Create ranges.
    XuniGaugeRange* lower = [[XuniGaugeRange alloc] initWithGauge:linearGauge];
    lower.min = 0;
    lower.max = 40;
    lower.color = [UIColor colorWithRed:0.133 green:0.694 blue:0.298 alpha:1];
    XuniGaugeRange* middle = [[XuniGaugeRange alloc] initWithGauge:linearGauge];
    middle.min = 40;
    middle.max = 80;
    middle.color = [UIColor colorWithRed:1 green:0.502 blue:0.502 alpha:1];
    XuniGaugeRange* upper = [[XuniGaugeRange alloc] initWithGauge:linearGauge];
    upper.min = 80;
    upper.max = 100;
    upper.color = [UIColor colorWithRed:0 green:0.635 blue:0.91 alpha:1];
    // Add ranges.
    [linearGauge.ranges addObject:lower];
    [linearGauge.ranges addObject:middle];
    [linearGauge.ranges addObject:upper];
    [radialGauge.ranges addObject:lower];
    [radialGauge.ranges addObject:middle];
    [radialGauge.ranges addObject:upper];
    
    
    showRangesLabel =[[UILabel alloc] initWithFrame:CGRectMake(5, 110, 200, 50)];
    showRangesLabel.tag = 3;
    showRangesLabel.textAlignment = NSTextAlignmentLeft;
    showRangesLabel.textColor = [UIColor blackColor];
    showRangesLabel.text = @"Show ranges";
    
    rangeSwitch = [[UISwitch alloc]init];
    rangeSwitch.tag = 4;
    [rangeSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:rangeSwitch];
    [self.view addSubview:showRangesLabel];
    [self.view addSubview:stepper];
    [self.view addSubview:_title];
    [self.view addSubview:linearGauge];
    [self.view addSubview:radialGauge];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    XuniLinearGauge *linearGauge = (XuniLinearGauge*) [self.view viewWithTag:1];
    XuniRadialGauge *radialGauge = (XuniRadialGauge*) [self.view viewWithTag:2];
    UILabel *showRangesLabel = (UILabel*) [self.view viewWithTag:3];
    UISwitch *rangeSwitch = (UISwitch*) [self.view viewWithTag:4];
    UIStepper *stepper = (UIStepper*)[self.view viewWithTag:5];
    
    
    XuniRect *r1 = [[XuniRect alloc] initLeft:0 top:250 width:self.view.bounds.size.width height:self.view.bounds.size.height/8];
    XuniRect *r2 = [[XuniRect alloc] initLeft:0 top:100 + (self.view.bounds.size.height/2) width:self.view.bounds.size.width height:((self.view.bounds.size.height/2) - 100)];
    
    _title.frame = CGRectMake(0, 50, self.view.bounds.size.width, 100);
    stepper.frame = CGRectMake(self.view.bounds.size.width/2 - 25, 170, 50, 50);

    linearGauge.frame = CGRectMake(0, 250, self.view.bounds.size.width, self.view.bounds.size.height/8);
    linearGauge.rectGauge = r1;
    radialGauge.frame = CGRectMake(0, 100 + (self.view.bounds.size.height/2), self.view.bounds.size.width, (self.view.bounds.size.height/2) - 100);
    radialGauge.rectGauge = r2;
    showRangesLabel.frame = CGRectMake(5, 110, 200, 50);
    rangeSwitch.frame = CGRectMake(self.view.bounds.size.width - 75, 120, 50, 50);
    
    [_title setNeedsDisplay];
    [linearGauge setNeedsDisplay];
    [showRangesLabel setNeedsDisplay];
    [radialGauge setNeedsDisplay];
    [stepper setNeedsDisplay];
    [rangeSwitch setNeedsDisplay];
}
-(void)stepperClicked:(id) sender{
    UIStepper *stepper =(UIStepper*)sender;
    XuniLinearGauge *linearGauge = (XuniLinearGauge*) [self.view viewWithTag:1];
    XuniRadialGauge *radialGauge = (XuniRadialGauge*) [self.view viewWithTag:2];
    linearGauge.value = stepper.value;
    radialGauge.value = stepper.value;
}

-(void)switchChanged:(UISwitch *) switchState{
    XuniLinearGauge *linearGauge = (XuniLinearGauge*) [self.view viewWithTag:1];
    XuniRadialGauge *radialGauge = (XuniRadialGauge*) [self.view viewWithTag:2];
    if ([switchState isOn]) {
        linearGauge.showRanges = true;
        radialGauge.showRanges = true;
    }
    else
    {
        linearGauge.showRanges = false;
        radialGauge.showRanges = false;
    }
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
