//
//  SelectionModesController.m
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "SelectionModesController.h"
#import "CustomerData.h"
#import "FlexGridKit/FlexGridKit.h"

@interface SelectionModesController (){
    NSMutableArray *pickerData;
}
@end

@implementation SelectionModesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    pickerData =[[NSMutableArray alloc] initWithObjects:@"None", @"Cell", @"Cell Range", @"Row", @"Row Range", nil];
    UIPickerView *selectionModePicker = [[UIPickerView alloc] init];
    FlexGrid *flex = [[FlexGrid alloc] init];
    flex.isReadOnly = true;
    flex.itemsSource = [CustomerData getCustomerData:100];

    selectionModePicker.delegate = self;
    selectionModePicker.showsSelectionIndicator = YES;
    selectionModePicker.hidden = false;
    [selectionModePicker selectRow:0 inComponent:0 animated:false];
    
    flex.tag = 1;
    selectionModePicker.tag = 2;
    
    [self.view addSubview:selectionModePicker];
    [self.view addSubview:flex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    FlexGrid *flex = (FlexGrid*)[self.view viewWithTag:1];
    UIPickerView *selectionModePicker = (UIPickerView*)[self.view viewWithTag:2];
    flex.frame = CGRectMake(0, 206, self.view.bounds.size.width, (self.view.bounds.size.height-206));
    selectionModePicker.frame = CGRectMake(self.view.bounds.size.width/4, 44, self.view.bounds.size.width/2, 162);
    [flex setNeedsDisplay];
    [selectionModePicker setNeedsDisplay];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [pickerData count];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    FlexGrid *flex = (FlexGrid *)[self.view viewWithTag:1];
    
    
    if (row == 0) {
        flex.selectionMode = FlexSelectionModeNone;
    }
    else if (row == 1){
        flex.selectionMode = FlexSelectionModeCell;
    }
    else if (row == 2){
        flex.selectionMode = FlexSelectionModeCellRange;
    }
    else if (row == 3){
        flex.selectionMode = FlexSelectionModeRow;
    }
    else if (row == 4){
        flex.selectionMode = FlexSelectionModeRowRange;
    }
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    return [pickerData objectAtIndex:row];
  
}
@end