//
//  FilterFormController.m
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "FilterFormController.h"
#import "CustomerData.h"
#import "FilterController.h"
#import "FlexGridKit/FlexGridKit.h"
#import "SharedFilterData.h"

@interface FilterFormController (){
    NSMutableArray *pickerData;
    UITextField *_filterField;
    SharedFilterData *sharedData;
}

@end

@implementation FilterFormController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    sharedData = [SharedFilterData sharedInstance];
    pickerData =[[NSMutableArray alloc] initWithObjects:@"Contains", @"Begins with", @"Ends with", @"Equals", nil];
    UIPickerView *filterPicker = [[UIPickerView alloc] init];
    
    filterPicker.delegate = self;
    filterPicker.showsSelectionIndicator = YES;
    filterPicker.hidden = false;
    [filterPicker selectRow:0 inComponent:0 animated:false];

    _filterField = [[UITextField alloc] init];
    _filterField.delegate = self;
    _filterField.text = @"Enter text to Filter";
    _filterField.returnKeyType = UIReturnKeyDone;
    _filterField.keyboardType = UIKeyboardTypeDefault;
    _filterField.backgroundColor = [UIColor lightGrayColor];
    
    
    UIButton *filterButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [filterButton setTitle:@"Filter" forState:UIControlStateNormal];
    [filterButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [filterButton addTarget:self action:@selector(filterButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [filterButton setBackgroundColor:[UIColor blueColor]];
    filterButton.tintColor = [UIColor whiteColor];
    
    filterPicker.tag = 1;
    filterButton.tag = 2;
    
    [self.view addSubview:_filterField];
    [self.view addSubview:filterPicker];
    [self.view addSubview:filterButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    UIPickerView *filterPicker = (UIPickerView*)[self.view viewWithTag:1];
    UIButton *filterButton = (UIButton*)[self.view viewWithTag:2];
    _filterField.frame = CGRectMake(self.view.bounds.size.width/4, 65, self.view.bounds.size.width/2, 50);
    filterPicker.frame = CGRectMake(self.view.bounds.size.width/4, 100, self.view.bounds.size.width/2, 162);
    filterButton.frame = CGRectMake(self.view.bounds.size.width/4, 300, self.view.bounds.size.width/2, 50);
}
-(void)filterButtonClicked{
    sharedData.filterSet = true;
    [self.navigationController popViewControllerAnimated:true];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [pickerData count];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    sharedData.filterOperation = @(row);
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [pickerData objectAtIndex:row];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return true;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [textField selectAll:nil];
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return true;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    sharedData.filterString = textField.text;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
}

@end
