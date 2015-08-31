//
//  DisplayingValuesController.m
//  Gauges101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "DisplayingValuesController.h"
#import "XuniGaugeKit/XuniGaugeKit.h"

@interface DisplayingValuesController ()
{
    UILabel *_title;
    NSMutableArray *_pickerData;
}

@end

@implementation DisplayingValuesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIPickerView *pickerView;
    XuniLinearGauge *linearGauge;
    XuniRadialGauge *radialGauge;
    UILabel *showTextLabel;
    UIStepper *stepper;
    double min;
    double max;
    double val;
    
    min = 0;
    max = 1;
    val = .25;
    
    _pickerData =[[NSMutableArray alloc] initWithObjects:@"All", @"MinMax", @"Value", @"None", nil];
    
    
    pickerView = [[UIPickerView alloc] init];
    pickerView.delegate = self;
    pickerView.showsSelectionIndicator = YES;
    pickerView.hidden = false;
    pickerView.tag = 5;
    
    _title =[[UILabel alloc] init];
    _title.textAlignment = NSTextAlignmentCenter;
    _title.textColor = [UIColor blackColor];
    _title.text = @"Displaying Values";
    
    showTextLabel =[[UILabel alloc] initWithFrame:CGRectMake(5, 110, 110, 50)];
    showTextLabel.textAlignment = NSTextAlignmentLeft;
    showTextLabel.textColor = [UIColor blackColor];
    showTextLabel.text = @"Show text";
    showTextLabel.tag = 4;
    stepper =[[UIStepper alloc] init];
    stepper.maximumValue = max;
    stepper.minimumValue = min;
    stepper.value = val;
    stepper.tag = 3;
    stepper.stepValue = .25;
    [stepper addTarget:self action:@selector(stepperClicked:) forControlEvents:UIControlEventValueChanged];
    
    linearGauge = [[XuniLinearGauge alloc] init];
    linearGauge.tag = 1;
    linearGauge.showText = XuniShowTextAll;
    linearGauge.thickness = 0.6;
    linearGauge.min = min;
    linearGauge.max = max;
    linearGauge.value = val;
    linearGauge.loadAnimation.duration = 2;
    linearGauge.updateAnimation.duration = 0.5;
    linearGauge.format = @"P0";
    
    radialGauge = [[XuniRadialGauge alloc] init];
    radialGauge.tag = 2;
    radialGauge.showText = XuniShowTextAll;
    radialGauge.thickness = 0.6;
    radialGauge.min = min;
    radialGauge.max = max;
    radialGauge.value = val;
    radialGauge.loadAnimation.duration = 2;
    radialGauge.updateAnimation.duration = 0.5;
    radialGauge.format = @"P0";
    
    [self.view addSubview:pickerView];
    [self.view addSubview:showTextLabel];
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
    UILabel *showTextLabel = (UILabel*) [self.view viewWithTag:4];
    UIStepper *stepper = (UIStepper*)[self.view viewWithTag:3];
    UIPickerView *picker = (UIPickerView*)[self.view viewWithTag:5];
    XuniRect *r1 = [[XuniRect alloc] initLeft:0 top:250 width:self.view.bounds.size.width height:self.view.bounds.size.height/8];
    XuniRect *r2 = [[XuniRect alloc] initLeft:0 top:100 + (self.view.bounds.size.height/2) width:self.view.bounds.size.width height:((self.view.bounds.size.height/2) - 100)];
    
    _title.frame = CGRectMake(0, 45, self.view.bounds.size.width, 100);
    stepper.frame = CGRectMake(self.view.bounds.size.width/2 - 25, 200, 50, 50);
    linearGauge.frame = CGRectMake(0, 250, self.view.bounds.size.width, self.view.bounds.size.height/8);
    linearGauge.rectGauge = r1;
    
    radialGauge.frame = CGRectMake(0, 100 + (self.view.bounds.size.height/2), self.view.bounds.size.width, (self.view.bounds.size.height/2) - 100);
    radialGauge.rectGauge = r2;
    showTextLabel.frame = CGRectMake(5, 110, 110, 50);
    picker.frame = CGRectMake(self.view.bounds.size.width - 120, 60, 100, 162);
    [_title setNeedsDisplay];
    [stepper setNeedsDisplay];
    [linearGauge setNeedsDisplay];
    [radialGauge setNeedsDisplay];
    [showTextLabel setNeedsDisplay];
    [picker setNeedsDisplay];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_pickerData count];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    XuniLinearGauge *linearGauge = (XuniLinearGauge*) [self.view viewWithTag:1];
    XuniRadialGauge *radialGauge = (XuniRadialGauge*) [self.view viewWithTag:2];
    
    if (row == 0) {
        linearGauge.showText = XuniShowTextAll;
        radialGauge.showText = XuniShowTextAll;
    }
    else if (row == 1){
        linearGauge.showText = XuniShowTextMinMax;
        radialGauge.showText = XuniShowTextMinMax;
    }
    else if (row == 2){
        linearGauge.showText = XuniShowTextValue;
        radialGauge.showText = XuniShowTextValue;
    }
    else if (row == 3){
        linearGauge.showText = XuniShowTextNone;
        radialGauge.showText = XuniShowTextNone;
    }
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [_pickerData objectAtIndex:row];
}

- (void)stepperClicked:(id) sender{
    UIStepper *stepper =(UIStepper*)sender;
    XuniLinearGauge *linearGauge = (XuniLinearGauge*) [self.view viewWithTag:1];
    XuniRadialGauge *radialGauge = (XuniRadialGauge*) [self.view viewWithTag:2];
    linearGauge.value = stepper.value;
    radialGauge.value = stepper.value;
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
