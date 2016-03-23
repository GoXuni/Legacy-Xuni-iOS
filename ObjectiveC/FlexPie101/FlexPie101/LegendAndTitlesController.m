//
//  LegendAndTitlesController.m
//  FlexPie101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "LegendAndTitlesController.h"
#import "XuniFlexPieKit/XuniFlexPieKit.h"
#import "PieChartData.h"

@interface LegendAndTitlesController (){
    NSMutableArray *pickerData;
    UITextField *_headerField;
    UITextField *_footerField;
}
@end

@implementation LegendAndTitlesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIPickerView *pickerView;
    
    UILabel *headerLabel = [[UILabel alloc] init];
    _headerField = [[UITextField alloc] init];
    
    UILabel *footerLabel = [[UILabel alloc] init];
    _footerField = [[UITextField alloc] init];
    pickerData =[[NSMutableArray alloc] initWithObjects:NSLocalizedString(@"None", nil),NSLocalizedString(@"Left", nil) , NSLocalizedString(@"Top", nil),NSLocalizedString(@"Right", nil), NSLocalizedString(@"Bottom", nil), nil];
    
    UILabel *legendlabel = [[UILabel alloc] init];
    pickerView = [[UIPickerView alloc] init];
    
    pickerView.delegate = self;
    pickerView.showsSelectionIndicator = YES;
    pickerView.hidden = false;
    [pickerView selectRow:3 inComponent:0 animated:false];
    
    headerLabel.text = NSLocalizedString(@"header", nil);
    footerLabel.text = NSLocalizedString(@"footer", nil);;
    legendlabel.text = NSLocalizedString(@"legend position", nil);
    
    _headerField.delegate = self;
    _headerField.text = NSLocalizedString(@"Fruit By Value", nil);
    _headerField.returnKeyType = UIReturnKeyDone;
    _headerField.keyboardType = UIKeyboardTypeDefault;
    _headerField.backgroundColor = [UIColor lightGrayColor];
    
    _footerField.delegate = self;
    _footerField.text = NSLocalizedString(@"GrapeCity inc.", nil);
    _footerField.returnKeyType = UIReturnKeyDone;
    _footerField.keyboardType = UIKeyboardTypeDefault;
    _footerField.backgroundColor = [UIColor lightGrayColor];
    
    FlexPie *pieChart = [[FlexPie alloc] init];
    NSMutableArray *pieData = [PieChartData demoData];
    pieChart.legend.position = XuniChartLegendPositionRight;
    pieChart.binding = @"value";
    pieChart.bindingName = @"name";
    pieChart.itemsSource = pieData;
    pieChart.tooltip.isVisible = true;
    pieChart.header = _headerField.text;
    pieChart.footer = _footerField.text;
    [pieChart sizeToFit];
    
    pieChart.tag = 1;
    headerLabel.tag = 2;
    footerLabel.tag = 3;
    legendlabel.tag = 4;
    pickerView.tag = 5;
    
    [self.view addSubview:pieChart];
    [self.view addSubview:headerLabel];
    [self.view addSubview:footerLabel];
    [self.view addSubview:legendlabel];
    [self.view addSubview:pickerView];
    [self.view addSubview:_headerField];
    [self.view addSubview:_footerField];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    FlexPie *pieChart = (FlexPie*)[self.view viewWithTag:1];
    UILabel *headerLabel = (UILabel*)[self.view viewWithTag:2];
    UILabel *footerLabel = (UILabel*)[self.view viewWithTag:3];
    UILabel *legendLabel = (UILabel*)[self.view viewWithTag:4];
    UIPickerView *pickerView = (UIPickerView*)[self.view viewWithTag:5];
     _headerField. frame = CGRectMake(0, 115, self.view.bounds.size.width/2 - 10, 50);
    _footerField.frame = CGRectMake(self.view.bounds.size.width/2, 115, self.view.bounds.size.width/2 - 10, 50);
    pieChart.frame = CGRectMake(self.view.bounds.size.width/4, 215, self.view.bounds.size.width*3/4, self.view.bounds.size.height - 215);
    headerLabel.frame = CGRectMake(0, 65, self.view.bounds.size.width/2 , 50);
    footerLabel.frame = CGRectMake(self.view.bounds.size.width/2, 65, self.view.bounds.size.width/2, 50);
    legendLabel.frame = CGRectMake(0, 165, self.view.bounds.size.width/2, 50);
    pickerView.frame = CGRectMake(0, 215, self.view.bounds.size.width/4, 162);
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
        pie.legend.position = XuniChartLegendPositionNone;
    }
    else if (row == 1){
        pie.legend.position = XuniChartLegendPositionLeft;
    }
    else if (row == 2){
        pie.legend.position = XuniChartLegendPositionTop;
    }
    else if (row == 3){
        pie.legend.position = XuniChartLegendPositionRight;
    }
    else if(row == 4){
        pie.legend.position = XuniChartLegendPositionBottom;
    }
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [pickerData objectAtIndex:row];
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return true;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return true;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    FlexPie *pie = (FlexPie*) [self.view viewWithTag:1];
    pie.header = _headerField.text;
    pie.footer = _footerField.text;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
}
-(void)headerFieldChanged:(id) sender{
    UITextField *headerField =(UITextField*)sender;
    FlexPie *pie = (FlexPie*) [self.view viewWithTag:1];
    pie.header = headerField.text;
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