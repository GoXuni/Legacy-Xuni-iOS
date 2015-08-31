//
//  SelectionSampleController.m
//  FlexPie101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "SelectionSampleController.h"
#import "FlexPieKit/FlexPieKit.h"
#import "PieChartData.h"
@interface SelectionSampleController (){
    NSMutableArray *pickerData;
}
@end

@implementation SelectionSampleController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerData =[[NSMutableArray alloc] initWithObjects:@"None", @"Left", @"Top", @"Right", @"Bottom", nil];
    UILabel *offsetLabel = [[UILabel alloc] init];
    UILabel *positionLabel = [[UILabel alloc] init];
    UILabel *isAnimatedLabel = [[UILabel alloc] init];
    UIStepper *stepper = [[UIStepper alloc] init];
    UISwitch *isAnimatedSwitch = [[UISwitch alloc]init];

    pickerView.delegate = self;
    pickerView.showsSelectionIndicator = YES;
    pickerView.hidden = false;
    [pickerView selectRow:4 inComponent:0 animated:false];
    
    [isAnimatedSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    stepper.maximumValue = .5;
    stepper.minimumValue = 0;
    stepper.value = .2;
    stepper.stepValue = .1;
    [stepper addTarget:self action:@selector(stepperClicked:) forControlEvents:UIControlEventValueChanged];
    
    FlexPie *pieChart = [[FlexPie alloc] init];
    NSMutableArray *pieData = [PieChartData demoData];
    
    offsetLabel.tag = 2;
    offsetLabel.text = [@"Selected Item offset " stringByAppendingString:[NSString stringWithFormat:@"%1.1f", stepper.value]];
    
    positionLabel.text = @"Position";
    
    isAnimatedLabel.text = @"IsAnimated?";
    
    pieChart.binding = @"value";
    pieChart.bindingName = @"name";
    pieChart.itemsSource = pieData;
    pieChart.tooltip.isVisible = true;
    pieChart.selectedItemOffset = stepper.value;
    pieChart.selectedItemPosition = XuniPositionBottom;
    pieChart.isAnimated = false;
    
    pieChart.tag = 1;
    offsetLabel.tag = 2;
    positionLabel.tag = 3;
    isAnimatedLabel.tag = 4;
    stepper.tag = 5;
    pickerView.tag = 6;
    isAnimatedSwitch.tag = 7;
    
    [self.view addSubview:pickerView];
    [self.view addSubview:isAnimatedSwitch];
    [self.view addSubview:stepper];
    [self.view addSubview:pieChart];
    [self.view addSubview:offsetLabel];
    [self.view addSubview:positionLabel];
    [self.view addSubview:isAnimatedLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    FlexPie *pieChart = (FlexPie*)[self.view viewWithTag:1];
    UILabel *offsetLabel = (UILabel*)[self.view viewWithTag:2];
    UILabel *positionLabel = (UILabel*)[self.view viewWithTag:3];
    UILabel *isAnimatedLabel = (UILabel*)[self.view viewWithTag:4];
    UIStepper *stepper = (UIStepper*)[self.view viewWithTag:5];
    UIPickerView *pickerView = (UIPickerView*)[self.view viewWithTag:6];
    UISwitch *isAnimatedSwitch = (UISwitch*)[self.view viewWithTag:7];
    offsetLabel.frame = CGRectMake(0, 65, self.view.bounds.size.width/2, 50);
    [offsetLabel sizeToFit];
    positionLabel.frame = CGRectMake(0, 115, self.view.bounds.size.width/4, 50);
    [positionLabel sizeToFit];
    isAnimatedLabel.frame = CGRectMake(self.view.bounds.size.width/2, 115, self.view.bounds.size.width/4, 50);
    [isAnimatedLabel sizeToFit];
    stepper.frame = CGRectMake(self.view.bounds.size.width * 5/8, 65, self.view.bounds.size.width/4, 50);
    pickerView.frame = CGRectMake(0, 165, self.view.bounds.size.width/4, 162);
    isAnimatedSwitch.frame = CGRectMake((self.view.bounds.size.width * 3/4) + 5, 115, 50, 50);
    pieChart.frame = CGRectMake(self.view.bounds.size.width/4, 165, self.view.bounds.size.width*3/4, self.view.bounds.size.height-165);
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [pickerData count];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    FlexPie *pie = (FlexPie*)[self.view viewWithTag:1];
    if (row == 0) {
        pie.selectedItemPosition = XuniPositionNone;
    }
    else if (row == 1){
        pie.selectedItemPosition = XuniPositionLeft;
    }
    else if (row == 2){
        pie.selectedItemPosition  = XuniPositionTop;
    }
    else if (row == 3){
        pie.selectedItemPosition  = XuniPositionRight;
    }
    else if(row == 4){
        pie.selectedItemPosition  = XuniPositionBottom;
    }
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [pickerData objectAtIndex:row];
}

-(void)stepperClicked:(id) sender{
    UIStepper *stepper =(UIStepper*)sender;
    FlexPie *pie = (FlexPie*) [self.view viewWithTag:1];
    UILabel *offsetLabel = (UILabel*) [self.view viewWithTag:2];
    
    pie.selectedItemOffset = stepper.value;
    offsetLabel.text = [@"Selected Item offset " stringByAppendingString:[NSString stringWithFormat:@"%1.1f", stepper.value]];
    [offsetLabel sizeToFit];
}
-(void)switchChanged:(UISwitch *) switchState{
    FlexPie *pie = (FlexPie*) [self.view viewWithTag:1];
    
    if ([switchState isOn]) {
        pie.isAnimated = true;
    }
    else
    {
        pie.isAnimated = false;
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
