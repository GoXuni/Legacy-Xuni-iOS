//
//  DirectionController.m
//  Gauges101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "DirectionController.h"
#import "XuniGaugeKit/XuniGaugeKit.h"

@interface DirectionController (){
    UILabel *_title;
    NSMutableArray *_pickerData;
    bool _isHorizontal;
}

@end

@implementation DirectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIPickerView *pickerView;
    XuniLinearGauge *linearGauge;
    XuniBulletGraph *bulletGraph;
    
    double min;
    double max;
    double val;
    double bad;
    double good;
    double target;
    
    _isHorizontal = true;
    min = 0;
    max = 100;
    val = 25;
    bad = 45;
    good = 80;
    target = 90;
    
    
    _title =[[UILabel alloc] init];
    _title.textAlignment = NSTextAlignmentCenter;
    _title.textColor = [UIColor blackColor];
    _title.text = @"Direction";
    
    _pickerData =[[NSMutableArray alloc] initWithObjects:@"Right", @"Left", @"Down", @"Up", nil];
    
    pickerView = [[UIPickerView alloc] init];
    pickerView.delegate = self;
    pickerView.showsSelectionIndicator = YES;
    pickerView.hidden = false;
    pickerView.tag = 3;
    
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
    
    bulletGraph = [[XuniBulletGraph alloc] init];
    bulletGraph.isReadOnly = false;
    bulletGraph.tag = 2;
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
    
    [self.view addSubview:bulletGraph];
    [self.view addSubview:pickerView];
    [self.view addSubview:_title];
    [self.view addSubview:linearGauge];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    XuniLinearGauge *linearGauge = (XuniLinearGauge*) [self.view viewWithTag:1];
    XuniBulletGraph *bulletGraph = (XuniBulletGraph*) [self.view viewWithTag:2];
    UIPickerView *picker= (UIPickerView*) [self.view viewWithTag:3];

    XuniRect *r1 = [[XuniRect alloc] initLeft:0 top:(self.view.bounds.size.height/2) width:self.view.bounds.size.width height:self.view.bounds.size.height/8];
    XuniRect *r2 = [[XuniRect alloc] initLeft:0 top: (self.view.bounds.size.height*3/4) width:self.view.bounds.size.width height:self.view.bounds.size.height/6];
    _title.frame = CGRectMake(0, 55, self.view.bounds.size.width, 50);
    
    linearGauge.frame = CGRectMake(0, 2*(self.view.bounds.size.height/4), self.view.bounds.size.width, self.view.bounds.size.height/8);
    linearGauge.rectGauge = r1;
    bulletGraph.frame = CGRectMake(0, 3*(self.view.bounds.size.height/4), self.view.bounds.size.width, self.view.bounds.size.height/6);
    bulletGraph.rectGauge = r2;
    picker.frame = CGRectMake(self.view.bounds.size.width/4, 65, self.view.bounds.size.width/2, 162);
    
    [_title setNeedsDisplay];
    [linearGauge setNeedsDisplay];
    [bulletGraph setNeedsDisplay];
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
    XuniBulletGraph *bulletGraph = (XuniBulletGraph*) [self.view viewWithTag:2];
    XuniRect *r1;
    XuniRect *r2;
    
    if (row == 0) {
        linearGauge.direction = XuniGaugeDirectionRight;
        bulletGraph.direction = XuniGaugeDirectionRight;
        if (_isHorizontal == false) {
            linearGauge.frame = CGRectMake(0, (self.view.bounds.size.height/2), self.view.bounds.size.width, self.view.bounds.size.height/8);
            bulletGraph.frame = CGRectMake(0, (self.view.bounds.size.height*3/4), self.view.bounds.size.width, self.view.bounds.size.height/6);
            r1 = [[XuniRect alloc] initLeft:0 top:(self.view.bounds.size.height/2) width:self.view.bounds.size.width height:self.view.bounds.size.height/8];
            r2 = [[XuniRect alloc] initLeft:0 top:(self.view.bounds.size.height*3/4) width:self.view.bounds.size.width height:self.view.bounds.size.height/6];
            linearGauge.rectGauge = r1;
            bulletGraph.rectGauge = r2;
            [linearGauge setNeedsDisplay];
            [bulletGraph setNeedsDisplay];
            _isHorizontal = true;
        }
    }
    else if (row == 1){
        linearGauge.direction = XuniGaugeDirectionLeft;
        bulletGraph.direction = XuniGaugeDirectionLeft;
        if (_isHorizontal == false) {
            linearGauge.frame = CGRectMake(0, 2*(self.view.bounds.size.height/4), self.view.bounds.size.width, self.view.bounds.size.height/8);
            bulletGraph.frame = CGRectMake(0, 3*(self.view.bounds.size.height/4), self.view.bounds.size.width, self.view.bounds.size.height/6);
            r1 = [[XuniRect alloc] initLeft:0 top:(self.view.bounds.size.height/2) width:self.view.bounds.size.width height:self.view.bounds.size.height/8];
            r2 = [[XuniRect alloc] initLeft:0 top:(self.view.bounds.size.height*3/4) width:self.view.bounds.size.width height:self.view.bounds.size.height/6];
            linearGauge.rectGauge = r1;
            bulletGraph.rectGauge = r2;
            [linearGauge setNeedsDisplay];
            [bulletGraph setNeedsDisplay];
            _isHorizontal = true;
        }
    }
    else if (row == 2){
        linearGauge.direction = XuniGaugeDirectionDown;
        bulletGraph.direction = XuniGaugeDirectionDown;
        if (_isHorizontal == true) {
            linearGauge.frame = CGRectMake(0, self.view.bounds.size.height/2, self.view.bounds.size.width/4, self.view.bounds.size.height/2);
            bulletGraph.frame = CGRectMake(self.view.bounds.size.width/4, self.view.bounds.size.height/2, self.view.bounds.size.width/4, self.view.bounds.size.height/2);
            r1 = [[XuniRect alloc] initLeft:0 top:self.view.bounds.size.height/2 width:self.view.bounds.size.width/4 height:self.view.bounds.size.height/2];
            r2 = [[XuniRect alloc] initLeft:self.view.bounds.size.width/4 top:self.view.bounds.size.height/2 width:self.view.bounds.size.width/4 height:self.view.bounds.size.height/2];
            linearGauge.rectGauge = r1;
            bulletGraph.rectGauge = r2;
            [linearGauge setNeedsDisplay];
            [bulletGraph setNeedsDisplay];
            _isHorizontal = false;
        }
    }
    else if (row == 3){
        linearGauge.direction = XuniGaugeDirectionUp;
        bulletGraph.direction = XuniGaugeDirectionUp;
        if (_isHorizontal == true) {
            linearGauge.frame = CGRectMake(0, self.view.bounds.size.height/2, self.view.bounds.size.width/4, self.view.bounds.size.height/2);
            bulletGraph.frame = CGRectMake(self.view.bounds.size.width/4, self.view.bounds.size.height/2, self.view.bounds.size.width/4, self.view.bounds.size.height/2);
            r1 = [[XuniRect alloc] initLeft:0 top:self.view.bounds.size.height/2 width:self.view.bounds.size.width/4 height:self.view.bounds.size.height/2];
            r2 = [[XuniRect alloc] initLeft:self.view.bounds.size.width/4 top:self.view.bounds.size.height/2 width:self.view.bounds.size.width/4 height:self.view.bounds.size.height/2];
            linearGauge.rectGauge = r1;
            bulletGraph.rectGauge = r2;
            [linearGauge setNeedsDisplay];
            [bulletGraph setNeedsDisplay];
            _isHorizontal = false;
        }
    }
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [_pickerData objectAtIndex:row];
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
