//
//  GettingStartedController.m
//  Gauages101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "GettingStartedController.h"
#import "XuniGaugeKit/XuniGaugeKit.h"

@interface GettingStartedController ()
{
    UILabel *_title;
}
@end

@implementation GettingStartedController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    XuniLinearGauge *linearGauge;
    XuniBulletGraph *bulletGraph;
    XuniRadialGauge *radialGauge;
    UILabel *value;
    UIStepper *stepper;
    
    double min;
    double max;
    double val;
    
    min = 0;
    max = 100;
    val = 25;
    
    _title =[[UILabel alloc] init];
    _title.textAlignment = NSTextAlignmentCenter;
    _title.textColor = [UIColor blackColor];
    _title.text = @"Getting Started";
    
    stepper =[[UIStepper alloc] init];
    stepper.maximumValue = max;
    stepper.minimumValue = min;
    stepper.value = val;
    stepper.stepValue = 25;
    stepper.tag = 5;
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


    bulletGraph = [[XuniBulletGraph alloc] init];
    bulletGraph.tag = 2;
    bulletGraph.showText = XuniShowTextNone;
    bulletGraph.thickness = 0.6;
    bulletGraph.min = min;
    bulletGraph.max = max;
    bulletGraph.bad = 45;
    bulletGraph.good = 80;
    bulletGraph.target = 90;
    bulletGraph.value = val;
    bulletGraph.pointer.thickness = 0.5;
    bulletGraph.loadAnimation.duration = 2;
    bulletGraph.updateAnimation.duration = 0.5;

    
    radialGauge = [[XuniRadialGauge alloc] init];
    radialGauge.tag = 3;
    radialGauge.showText = XuniShowTextNone;
    radialGauge.thickness = 0.6;
    radialGauge.min = min;
    radialGauge.max = max;
    radialGauge.value = val;
    radialGauge.loadAnimation.duration = 2;
    radialGauge.updateAnimation.duration = 0.5;

    
    value =[[UILabel alloc] init];
    value.tag = 4;
    value.textAlignment = NSTextAlignmentLeft;
    value.textColor = [UIColor blackColor];
    value.text = [@"Value " stringByAppendingString:[NSString stringWithFormat:@"%.f", val]];


    [self.view addSubview:value];
    [self.view addSubview:stepper];
    [self.view addSubview:_title];
    [self.view addSubview:linearGauge];
    [self.view addSubview:bulletGraph];
    [self.view addSubview:radialGauge];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)stepperClicked:(id) sender{
    UIStepper *stepper =(UIStepper*)sender;
    UILabel *value = (UILabel*) [self.view viewWithTag:4];
    XuniLinearGauge *linearGauge = (XuniLinearGauge*) [self.view viewWithTag:1];
    XuniBulletGraph *bulletGraph = (XuniBulletGraph*) [self.view viewWithTag:2];
    XuniRadialGauge *radialGauge = (XuniRadialGauge*) [self.view viewWithTag:3];
    linearGauge.value = stepper.value;
    bulletGraph.value = stepper.value;
    radialGauge.value = stepper.value;
    value.text = [@"Value " stringByAppendingString:[NSString stringWithFormat:@"%.f", stepper.value]];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    XuniLinearGauge *linearGauge = (XuniLinearGauge*) [self.view viewWithTag:1];
    XuniBulletGraph *bulletGraph = (XuniBulletGraph*) [self.view viewWithTag:2];
    XuniRadialGauge *radialGauge = (XuniRadialGauge*) [self.view viewWithTag:3];
    UILabel *value = (UILabel*) [self.view viewWithTag:4];
    UIStepper *stepper = (UIStepper*)[self.view viewWithTag:5];
    
    XuniRect *r1 = [[XuniRect alloc] initLeft:0 top:150 width:self.view.bounds.size.width height:self.view.bounds.size.height/8];
    XuniRect *r2 = [[XuniRect alloc] initLeft:0 top:100 + (self.view.bounds.size.height/4) width:self.view.bounds.size.width height:self.view.bounds.size.height/8];
    XuniRect *r3 = [[XuniRect alloc] initLeft:0 top:100 + (self.view.bounds.size.height/2) width:self.view.bounds.size.width height:((self.view.bounds.size.height/2) - 100)];

    
    _title.frame = CGRectMake(0, 50, self.view.bounds.size.width, 100);
    stepper.frame = CGRectMake(self.view.bounds.size.width - 100, 120, 50, 50);
    linearGauge.frame = CGRectMake(0, 150, self.view.bounds.size.width, self.view.bounds.size.height/8);
    linearGauge.rectGauge = r1;
    bulletGraph.frame = CGRectMake(0, 100 + (self.view.bounds.size.height/4), self.view.bounds.size.width, self.view.bounds.size.height/8);
    bulletGraph.rectGauge = r2;
    radialGauge.frame = CGRectMake(0, 100 + (self.view.bounds.size.height/2), self.view.bounds.size.width, (self.view.bounds.size.height/2) - 100);
    radialGauge.rectGauge = r3;
    value.frame = CGRectMake(0, 110, 200, 50);
    
    [_title setNeedsDisplay];
    [stepper setNeedsDisplay];
    [linearGauge setNeedsDisplay];
    [bulletGraph setNeedsDisplay];
    [radialGauge setNeedsDisplay];
    [value setNeedsDisplay];
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
