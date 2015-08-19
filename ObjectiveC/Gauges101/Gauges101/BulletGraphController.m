//
//  BulletGraphController.m
//  Gauges101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "BulletGraphController.h"
#import "XuniGaugeKit/XuniGaugeKit.h"
@interface BulletGraphController (){
        UILabel *_title;

}

@end

@implementation BulletGraphController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    XuniBulletGraph *bulletGraph;
    UILabel *badLabel;
    UILabel *goodLabel;
    UILabel *targetLabel;
    UIStepper *badStepper;
    UIStepper *goodStepper;
    UIStepper *targetStepper;
    double min;
    double max;
    double val;
    double bad;
    double good;
    double target;
    min = 0;
    max = 100;
    val = 25;
    bad = 45;
    good = 80;
    target = 90;
    
    bulletGraph = [[XuniBulletGraph alloc] init];
    bulletGraph.isReadOnly = false;
    bulletGraph.tag = 1;
    bulletGraph.showText = XuniShowTextNone;
    bulletGraph.thickness = 0.6;
    bulletGraph.min = min;
    bulletGraph.max = max;
    bulletGraph.bad = bad;
    bulletGraph.good = good;
    bulletGraph.target = target;
    bulletGraph.value = val;
    bulletGraph.pointer.thickness = 0.5;
    bulletGraph.loadAnimation.duration = 2;
    bulletGraph.updateAnimation.duration = 0.5;
    
    _title =[[UILabel alloc] init];
    _title.textAlignment = NSTextAlignmentCenter;
    _title.textColor = [UIColor blackColor];
    _title.text = @"Bullet Graph";
    
    badLabel=[[UILabel alloc] init];
    badLabel.tag = 2;
    badLabel.textAlignment = NSTextAlignmentLeft;
    badLabel.textColor = [UIColor blackColor];
    badLabel.text = [@"Bad " stringByAppendingString:[NSString stringWithFormat:@"%.f", bad]];

    
    badStepper =[[UIStepper alloc] init];
    badStepper.maximumValue = max;
    badStepper.minimumValue = min;
    badStepper.value = bad;
    badStepper.stepValue = 5;
    badStepper.tag = 5;
    [badStepper addTarget:self action:@selector(badStepperClicked:) forControlEvents:UIControlEventValueChanged];
    
    goodLabel=[[UILabel alloc] init];
    goodLabel.tag = 3;
    goodLabel.textAlignment = NSTextAlignmentLeft;
    goodLabel.textColor = [UIColor blackColor];
    goodLabel.text = [@"Good " stringByAppendingString:[NSString stringWithFormat:@"%.f", good]];
    
    goodStepper =[[UIStepper alloc] init];
    goodStepper.maximumValue = max;
    goodStepper.minimumValue = min;
    goodStepper.value = good;
    goodStepper.stepValue = 5;
    goodStepper.tag = 6;
    [goodStepper addTarget:self action:@selector(goodStepperClicked:) forControlEvents:UIControlEventValueChanged];
    
    targetLabel=[[UILabel alloc] init];
    targetLabel.tag = 4;
    targetLabel.textAlignment = NSTextAlignmentLeft;
    targetLabel.textColor = [UIColor blackColor];
    targetLabel.text = [@"Target " stringByAppendingString:[NSString stringWithFormat:@"%.f", target]];
    
    targetStepper =[[UIStepper alloc] init];
    targetStepper.maximumValue = max;
    targetStepper.minimumValue = min;
    targetStepper.value = target;
    targetStepper.stepValue = 5;
    targetStepper.tag = 7;
    [targetStepper addTarget:self action:@selector(targetStepperClicked:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:badLabel];
    [self.view addSubview:goodLabel];
    [self.view addSubview:targetLabel];
    [self.view addSubview:badStepper];
    [self.view addSubview:goodStepper];
    [self.view addSubview:targetStepper];
    [self.view addSubview:_title];
    [self.view addSubview:bulletGraph];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    XuniBulletGraph *bulletGraph = (XuniBulletGraph*) [self.view viewWithTag:1];
    UILabel *badLabel = (UILabel *)[self.view viewWithTag:2];
    UILabel *goodLabel = (UILabel *)[self.view viewWithTag:3];
    UILabel *targetLabel = (UILabel *)[self.view viewWithTag:4];
    UIStepper *badStepper = (UIStepper *)[self.view viewWithTag:5];
    UIStepper *goodStepper = (UIStepper *)[self.view viewWithTag:6];
    UIStepper *targetStepper = (UIStepper *)[self.view viewWithTag:7];
    _title.frame = CGRectMake(0, 50, self.view.bounds.size.width, 100);
    
    badLabel.frame = CGRectMake(0, 120, 200, 50);
    goodLabel.frame = CGRectMake(0, 170, 200, 50);
    targetLabel.frame = CGRectMake(0, 220, 200, 50);
    
    badStepper.frame = CGRectMake(self.view.bounds.size.width - 100, 120, 50, 50);
    goodStepper.frame = CGRectMake(self.view.bounds.size.width - 100, 170, 50, 50);
    targetStepper.frame = CGRectMake(self.view.bounds.size.width - 100, 220, 50, 50);
    
    bulletGraph.frame = CGRectMake(0, 200 + (self.view.bounds.size.height/4), self.view.bounds.size.width, self.view.bounds.size.height/6);
    XuniRect *r = [[XuniRect alloc] initLeft:0 top:200 + (self.view.bounds.size.height/4) width:self.view.bounds.size.width height:self.view.bounds.size.height/6];
    bulletGraph.rectGauge = r;
    
    [_title setNeedsDisplay];
    [bulletGraph setNeedsDisplay];
    [badLabel setNeedsDisplay];
    [goodLabel setNeedsDisplay];
    [targetLabel setNeedsDisplay];
    [badStepper setNeedsDisplay];
    [goodStepper setNeedsDisplay];
    [targetStepper setNeedsDisplay];
}

-(void)badStepperClicked:(id) sender{
    UIStepper *stepper =(UIStepper*)sender;
    UILabel *badLabel = (UILabel*) [self.view viewWithTag:2];
    XuniBulletGraph *bulletGraph = (XuniBulletGraph*) [self.view viewWithTag:1];
    bulletGraph.bad = stepper.value;
    badLabel.text = [@"Bad " stringByAppendingString:[NSString stringWithFormat:@"%.f", stepper.value]];
}
-(void)goodStepperClicked:(id) sender{
    UIStepper *stepper =(UIStepper*)sender;
    UILabel *goodLabel = (UILabel*) [self.view viewWithTag:3];
    XuniBulletGraph *bulletGraph = (XuniBulletGraph*) [self.view viewWithTag:1];
    bulletGraph.good = stepper.value;
    goodLabel.text = [@"Good " stringByAppendingString:[NSString stringWithFormat:@"%.f", stepper.value]];
}
-(void)targetStepperClicked:(id) sender{
    UIStepper *stepper =(UIStepper*)sender;
    UILabel *targetLabel = (UILabel*) [self.view viewWithTag:4];
    XuniBulletGraph *bulletGraph = (XuniBulletGraph*) [self.view viewWithTag:1];
    bulletGraph.target= stepper.value;
    targetLabel.text = [@"Target " stringByAppendingString:[NSString stringWithFormat:@"%.f", stepper.value]];
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
