//
//  BasicFeaturesController.m
//  FlexPie101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "BasicFeaturesController.h"
#import "FlexPieKit/FlexPieKit.h"
#import "PieChartData.h"
@interface BasicFeaturesController ()

@end

@implementation BasicFeaturesController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UILabel *innerRadiusLabel =[[UILabel alloc] init];
    UIStepper *stepper=[[UIStepper alloc] init];
    UILabel *offsetLabel =[[UILabel alloc] init];
    UISlider *offsetSlider = [[UISlider alloc]init];
    UILabel *startAngleLabel =[[UILabel alloc] init];
    UISlider *startAngleSlider = [[UISlider alloc]init];
    UILabel *reversedLabel =[[UILabel alloc] init];
    UISwitch *reversedSwitch = [[UISwitch alloc]init];
    FlexPie *pieChart = [[FlexPie alloc] init];
    NSMutableArray *pieData = [PieChartData demoData];
    
    pieChart.binding = @"value";
    pieChart.bindingName = @"name";
    pieChart.itemsSource = pieData;
    
    stepper.maximumValue = .99;
    stepper.minimumValue = 0;
    stepper.value = 0;
    stepper.stepValue = .1;
    [stepper addTarget:self action:@selector(stepperClicked:) forControlEvents:UIControlEventValueChanged];

    innerRadiusLabel.text = [@"Inner Radius " stringByAppendingString:[NSString stringWithFormat:@"%1.1f", stepper.value]];
    [innerRadiusLabel sizeToFit];
    
    offsetLabel.text = @"Offset";
    
    [offsetSlider addTarget:self action:@selector(offsetSliderChanged:) forControlEvents:UIControlEventValueChanged];
    offsetSlider.minimumValue = 0.0;
    offsetSlider.maximumValue = 1.0;
    
    startAngleLabel.text = @"Start Angle";
    
    [startAngleSlider addTarget:self action:@selector(startAngleSliderChanged:) forControlEvents:UIControlEventValueChanged];
    startAngleSlider.minimumValue = 0.0;
    startAngleSlider.maximumValue = 360.0;
    
    reversedLabel.text = @"Reversed?";
    [reversedSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    
    pieChart.tag = 1;
    innerRadiusLabel.tag = 2;
    stepper.tag = 3;
    offsetLabel.tag = 4;
    offsetSlider.tag = 5;
    startAngleLabel.tag = 6;
    startAngleSlider.tag = 7;
    reversedLabel.tag = 8;
    reversedSwitch.tag = 9;
    
    [self.view addSubview:pieChart];
    [self.view addSubview:stepper];
    [self.view addSubview:innerRadiusLabel];
    [self.view addSubview:reversedLabel];
    [self.view addSubview:reversedSwitch];
    [self.view addSubview:offsetLabel];
    [self.view addSubview:offsetSlider];
    [self.view addSubview:startAngleLabel];
    [self.view addSubview:startAngleSlider];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    FlexPie *pieChart = (FlexPie*)[self.view viewWithTag:1];
    UILabel *innerRadiusLabel = (UILabel*)[self.view viewWithTag:2];
    UIStepper *stepper = (UIStepper*)[self.view viewWithTag:3];
    UILabel *offsetLabel = (UILabel*)[self.view viewWithTag:4];
    UISlider *offsetSlider = (UISlider*)[self.view viewWithTag:5];
    UILabel *startAngleLabel = (UILabel*)[self.view viewWithTag:6];
    UISlider *startAngleSlider = (UISlider*)[self.view viewWithTag:7];
    UILabel *reversedLabel = (UILabel*)[self.view viewWithTag:8];
    UISwitch *reversedSwitch = (UISwitch*)[self.view viewWithTag:9];
    innerRadiusLabel.frame = CGRectMake(5, 5, 100, 50);
    [innerRadiusLabel sizeToFit];
    stepper.frame = CGRectMake(self.view.bounds.size.width/2 - 25, 5, 50, 50);
    offsetLabel.frame = CGRectMake(5, self.view.bounds.size.height/8, 100, 50);
    offsetSlider.frame = CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height/8, self.view.bounds.size.width/2 -5, 50);
    startAngleLabel.frame = CGRectMake(5, self.view.bounds.size.height/4, 100, 50);
    startAngleSlider.frame = CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height/4, self.view.bounds.size.width/2 -5, 50);
    reversedLabel.frame = CGRectMake(5, self.view.bounds.size.height*3/8, 100, 50);
    reversedSwitch.frame = CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height*3/8, 50, 50);
    pieChart.frame = CGRectMake(0, self.view.bounds.size.height/2, self.view.bounds.size.width, self.view.bounds.size.height/2);
}

-(void)stepperClicked:(id) sender{
    UIStepper *stepper =(UIStepper*)sender;
    FlexPie *pie = (FlexPie*) [self.view viewWithTag:1];
    UILabel *innerRadiusLabel = (UILabel*) [self.view viewWithTag:2];
    
    pie.innerRadius = stepper.value;
    innerRadiusLabel.text = [@"Inner Radius " stringByAppendingString:[NSString stringWithFormat:@"%1.1f", stepper.value]];
    [innerRadiusLabel sizeToFit];
}

-(void)switchChanged:(UISwitch *) switchState{
    FlexPie *pie = (FlexPie*) [self.view viewWithTag:1];

    if ([switchState isOn]) {
        pie.reversed = true;
    }
    else
    {
        pie.reversed = false;
    }
}

-(void)offsetSliderChanged:(id) sender{
    UISlider *slider =(UISlider*)sender;
    FlexPie *pie = (FlexPie*) [self.view viewWithTag:1];
    pie.offset = slider.value;
}
-(void)startAngleSliderChanged:(id) sender{
    UISlider *slider =(UISlider*)sender;
    FlexPie *pie = (FlexPie*) [self.view viewWithTag:1];
    pie.startAngle = slider.value;
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
