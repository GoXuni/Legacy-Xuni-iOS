//
//  AutomaticScalingController.m
//  Gauges101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "AutomaticScalingController.h"
#import "XuniGaugeKit/XuniGaugeKit.h"
@interface AutomaticScalingController ()
{
    UILabel *_title;
}
@end

@implementation AutomaticScalingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    XuniRadialGauge *radialGauge;
    UILabel *startLabel;
    UILabel *sweepLabel;
    UIStepper *startAngleStepper;
    UIStepper *sweepAngleStepper;
    
    double min;
    double max;
    double val;
    
    min = 0;
    max = 200;
    val = 25;
    
    _title =[[UILabel alloc] init];
    _title.textAlignment = NSTextAlignmentCenter;
    _title.textColor = [UIColor blackColor];
    _title.text = @"Automatic Scaling";
    
    radialGauge = [[XuniRadialGauge alloc] init];
    radialGauge.tag = 1;
    radialGauge.showText = XuniShowTextAll;
    radialGauge.min = min;
    radialGauge.max = max;
    radialGauge.value = val;
    radialGauge.loadAnimation.duration = 2;
    radialGauge.updateAnimation.duration = 2;
    
    startAngleStepper =[[UIStepper alloc] init];
    startAngleStepper.tag = 4;
    startAngleStepper.maximumValue = 360;
    startAngleStepper.minimumValue = 0;
    startAngleStepper.value = 0;
    startAngleStepper.stepValue = 45;
    [startAngleStepper addTarget:self action:@selector(startAngleStepperClicked:) forControlEvents:UIControlEventValueChanged];
    
    sweepAngleStepper =[[UIStepper alloc] init];
    sweepAngleStepper.tag = 5;
    sweepAngleStepper.maximumValue = 360;
    sweepAngleStepper.minimumValue = 45;
    sweepAngleStepper.value = 180;
    sweepAngleStepper.stepValue = 45;
    [sweepAngleStepper addTarget:self action:@selector(sweepAngleStepperClicked:) forControlEvents:UIControlEventValueChanged];
    
    startLabel =[[UILabel alloc] init];
    startLabel.tag = 2;
    startLabel.textAlignment = NSTextAlignmentLeft;
    startLabel.textColor = [UIColor blackColor];
    startLabel.text = [@"Start Angle " stringByAppendingString:[NSString stringWithFormat:@"%.f", startAngleStepper.value]];
    
    sweepLabel =[[UILabel alloc] init];
    sweepLabel.tag = 3;
    sweepLabel.textAlignment = NSTextAlignmentLeft;
    sweepLabel.textColor = [UIColor blackColor];
    sweepLabel.text = [@"Sweep Angle " stringByAppendingString:[NSString stringWithFormat:@"%.f", sweepAngleStepper.value]];
    
    [self.view addSubview:startLabel];
    [self.view addSubview:sweepLabel];
    [self.view addSubview:startAngleStepper];
    [self.view addSubview:sweepAngleStepper];
    [self.view addSubview:_title];
    [self.view addSubview:radialGauge];
    [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(generateRandomNumber:) userInfo:nil repeats:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    XuniRadialGauge *radialGauge = (XuniRadialGauge*) [self.view viewWithTag:1];
    UILabel *startLabel = (UILabel*) [self.view viewWithTag:2];
    UILabel *sweepLabel = (UILabel*) [self.view viewWithTag:3];
    UIStepper *startAngleStepper = (UIStepper*)[self.view viewWithTag:4];
    UIStepper *sweepAngleStepper = (UIStepper*)[self.view viewWithTag:5];

    XuniRect *r1 = [[XuniRect alloc] initLeft:0 top:self.view.bounds.size.height/2 width:self.view.bounds.size.width height:(self.view.bounds.size.height/2)];
    
    _title.frame = CGRectMake(0, 45, self.view.bounds.size.width, 100);
    startAngleStepper.frame = CGRectMake(self.view.bounds.size.width - 100, 120, 50, 50);
    sweepAngleStepper.frame = CGRectMake(self.view.bounds.size.width - 100, 170, 50, 50);
    
    radialGauge.frame = CGRectMake(0, self.view.bounds.size.height/2, self.view.bounds.size.width, self.view.bounds.size.height/2);
    radialGauge.rectGauge = r1;
    startLabel.frame = CGRectMake(0, 110, 200, 50);
    sweepLabel.frame = CGRectMake(0, 160, 200, 50);
    
    [_title setNeedsDisplay];
    [startLabel setNeedsDisplay];
    [sweepLabel setNeedsDisplay];
    [radialGauge setNeedsDisplay];
    [startAngleStepper setNeedsDisplay];
    [sweepAngleStepper setNeedsDisplay];
}

-(void)generateRandomNumber:(id) sender{
    XuniRadialGauge *radialGauge = (XuniRadialGauge*) [self.view viewWithTag:1];
    radialGauge.value = (arc4random()% 201);
    
}

-(void)startAngleStepperClicked:(id) sender{
    UIStepper *stepper =(UIStepper*)sender;
    UILabel *start = (UILabel*) [self.view viewWithTag:2];
    XuniRadialGauge *radialGauge = (XuniRadialGauge*) [self.view viewWithTag:1];
    radialGauge.startAngle = stepper.value;
    start.text = [@"Start Angle " stringByAppendingString:[NSString stringWithFormat:@"%.f", stepper.value]];
}

-(void)sweepAngleStepperClicked:(id) sender{
    UIStepper *stepper =(UIStepper*)sender;
    UILabel *sweep = (UILabel*) [self.view viewWithTag:3];
    XuniRadialGauge *radialGauge = (XuniRadialGauge*) [self.view viewWithTag:1];
    radialGauge.sweepAngle = stepper.value;
    sweep.text = [@"Sweep Angle " stringByAppendingString:[NSString stringWithFormat:@"%.f", stepper.value]];
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
