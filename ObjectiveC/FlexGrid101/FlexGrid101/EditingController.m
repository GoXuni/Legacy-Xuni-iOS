//
//  EditingController.m
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "EditingController.h"
#import "CustomerData.h"
#import "XuniFlexGridKit/XuniFlexGridKit.h"

@interface EditingController ()

@end

@implementation EditingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    FlexGrid *flex = [[FlexGrid alloc] init];
    flex.tag = 1;
    flex.isReadOnly = false;
    flex.delegate = self;
    flex.headersVisibility = FlexHeadersVisibilityColumn;
    flex.itemsSource = [CustomerData getCustomerData:100];
    [flex.columns removeObjectAtIndex:1];
    [self.view addSubview:flex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    FlexGrid *flex = (FlexGrid*)[self.view viewWithTag:1];
    flex.frame = CGRectMake(0, 65, self.view.bounds.size.width, self.view.bounds.size.height - 65);
    [flex setNeedsDisplay];
}

-(bool)prepareCellForEdit:(FlexGrid *)sender panel:(FlexGridPanel *)panel forRange:(FlexCellRange *)range
 {
    FlexGrid *flex = (FlexGrid*)[self.view viewWithTag:1];
    FlexColumn *col = [flex.columns objectAtIndex:range.col];
    if ([col.binding isEqualToString:@"lastOrderDate"]) {
        UITextField *editor = (UITextField*)flex.activeEditor;
        UIDatePicker *picker = [[UIDatePicker alloc] init];
        NSDate *d = (NSDate*)[flex.cells getCellDataForRow:range.row inColumn:range.col formatted:NO];
        picker.opaque = true;
        picker.datePickerMode = UIDatePickerModeDate;
        picker.date = d;
        [picker addTarget:self action:@selector(onDatePickerChanged:) forControlEvents:UIControlEventValueChanged];
        editor.inputView = picker;
        UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, flex.frame.size.width, 44)];
        toolbar.barStyle = UIBarStyleDefault;
        UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(endEditDatePicker:)];
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [toolbar setItems:@[space, done]];
        editor.inputAccessoryView = toolbar;
        editor.clearButtonMode = UITextFieldViewModeNever;
    }
     return false;
}

- (void)onDatePickerChanged:(UIDatePicker*)sender {
    FlexGrid *flex = (FlexGrid*)[self.view viewWithTag:1];
    UITextField *editor = (UITextField*)flex.activeEditor;
    FlexColumn *c = [flex.columns objectAtIndex:flex.editRange.col];
    editor.text = (NSString*)[c getFormattedValue:sender.date];
}

- (BOOL)endEditDatePicker:(UITextField *)textField {
    FlexGrid *flex = (FlexGrid*)[self.view viewWithTag:1];
    UITextField *editor = (UITextField*)flex.activeEditor;
    UIDatePicker *picker = (UIDatePicker*)editor.inputView;
    [flex.cells setCellData:picker.date forRow:flex.editRange.row inColumn:flex.editRange.col];
    [flex finishEditing:true];
    return true;
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
