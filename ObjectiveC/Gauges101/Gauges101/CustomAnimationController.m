//
//  CustomAnimationController.m
//  Gauges101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "CustomAnimationController.h"
#import "XuniGaugeKit/XuniGaugeKit.h"

@interface CustomAnimationController (){
    UILabel *_title;
}
@end

@implementation CustomAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    XuniRadialGauge *radialGauge;
    XuniLinearGauge *linearGauge;
    double min;
    double max;
    double val;
    
    min = 0;
    max = 100;
    val = 25;
    
    _title =[[UILabel alloc] init];
    _title.textAlignment = NSTextAlignmentCenter;
    _title.textColor = [UIColor blackColor];
    _title.text = @"Custom Animations";
    
    linearGauge = [[XuniLinearGauge alloc] init];
    linearGauge.tag = 1;
    linearGauge.showText = XuniShowTextNone;
    linearGauge.thickness = 0.6;
    linearGauge.min = min;
    linearGauge.max = max;
    linearGauge.value = val;
    linearGauge.loadAnimation.duration = 2;
    linearGauge.updateAnimation.duration = 2;
    linearGauge.pointer.thickness = .5;
    
    radialGauge = [[XuniRadialGauge alloc] init];
    radialGauge.tag = 2;
    radialGauge.showText = XuniShowTextAll;
    radialGauge.thickness = 0.6;
    radialGauge.min = min;
    radialGauge.max = max;
    radialGauge.value = val;
    radialGauge.loadAnimation.duration = 2;
    radialGauge.updateAnimation.duration = 2;
    radialGauge.pointer.thickness = .5;
    
    [self.view addSubview:_title];
    [self.view addSubview:linearGauge];
    [self.view addSubview:radialGauge];
    
    [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(animateNextStep:) userInfo:nil repeats:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    XuniLinearGauge *linearGauge = (XuniLinearGauge*) [self.view viewWithTag:1];
    XuniRadialGauge *radialGauge = (XuniRadialGauge*) [self.view viewWithTag:2];
    
    XuniRect *r1 = [[XuniRect alloc] initLeft:0 top:150 width:self.view.bounds.size.width height:self.view.bounds.size.height/8];
    XuniRect *r2 = [[XuniRect alloc] initLeft:0 top:100 + (self.view.bounds.size.height/2) width:self.view.bounds.size.width height:(self.view.bounds.size.height/2)];
    
    
    _title.frame = CGRectMake(0, 50, self.view.bounds.size.width, 100);
    linearGauge.frame = CGRectMake(0, 150, self.view.bounds.size.width, self.view.bounds.size.height/8);
    linearGauge.rectGauge = r1;
    radialGauge.frame = CGRectMake(0, 100 + (self.view.bounds.size.height/2), self.view.bounds.size.width, self.view.bounds.size.height/2);
    radialGauge.rectGauge = r2;
    
    [_title setNeedsDisplay];
    [linearGauge setNeedsDisplay];
    [radialGauge setNeedsDisplay];
}

-(void)animateNextStep:(id) sender{
    XuniLinearGauge *linearGauge = (XuniLinearGauge*) [self.view viewWithTag:1];
    XuniRadialGauge *radialGauge = (XuniRadialGauge*) [self.view viewWithTag:2];
    double random = (arc4random()% 101);
    linearGauge.updateAnimation.easing = [XuniEasing EaseInOutCubic];
    radialGauge.updateAnimation.easing = [XuniEasing EaseInOutCubic];
    linearGauge.value = random;
    radialGauge.value = random;
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
