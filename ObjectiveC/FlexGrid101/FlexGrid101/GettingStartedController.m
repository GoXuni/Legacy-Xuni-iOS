//
//  EditingController.m
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "GettingStartedController.h"
#import "CustomerData.h"
#import "XuniFlexGridDynamicKit/XuniFlexGridDynamicKit.h"



@interface GettingStartedController ()
@property (weak, nonatomic) IBOutlet FlexGrid *flex;

@end

@implementation GettingStartedController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.flex.columnHeaderFont = [UIFont boldSystemFontOfSize:self.flex.columnHeaderFont.pointSize];
    self.flex.isReadOnly = false;
    self.flex.delegate   = self;
    
    [self.flex.flexGridAutoGeneratingColumn addHandler:^(XuniEventContainer<GridAutoGeneratingColumnEventArgs *> *eventContainer) {
        if ([eventContainer.eventArgs.propertyInfo.name isEqualToString:@"country"] || [eventContainer.eventArgs.propertyInfo.name isEqualToString:@"name"] || [eventContainer.eventArgs.propertyInfo.name isEqualToString:@"orderAverage"]) {
            eventContainer.eventArgs.cancel = true;
        } else if ([eventContainer.eventArgs.propertyInfo.name isEqualToString:@"customerID"]) {
            eventContainer.eventArgs.column.isReadOnly = true;
        } else if ([eventContainer.eventArgs.propertyInfo.name isEqualToString:@"countryID"]) {
            eventContainer.eventArgs.column.header = @"Country";
            eventContainer.eventArgs.column.horizontalAlignment = NSTextAlignmentLeft;
            NSMutableArray *items = [NSMutableArray arrayWithArray:[CustomerData defaultCountries]];
            eventContainer.eventArgs.column.dataMap = [[GridDataMap alloc] initWithArray:items selectedValuePath:@"identifier" displayMemberPath:@"title"];
            
        } else if ([eventContainer.eventArgs.propertyInfo.name isEqualToString:@"orderTotal"]) {
            eventContainer.eventArgs.column.format = @"C2";
        } else if ([eventContainer.eventArgs.propertyInfo.name isEqualToString:@"address"]) {
            eventContainer.eventArgs.column.wordWrap = true;
        }
    } forObject:self];


    self.flex.itemsSource = [CustomerData getCustomerData:100];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (bool)prepareCellForEdit:(FlexGrid *)sender panel:(GridPanel *)panel forRange:(GridCellRange *)range {
    FlexGrid   *flex = self.flex;
    GridColumn *col  = [flex.columns objectAtIndex:range.col];
    if ([col.binding isEqualToString:@"lastOrderDate"]) {
        UITextField  *editor = (UITextField *)flex.activeEditor;
        UIDatePicker *picker = [[UIDatePicker alloc] init];
        NSDate       *d      = (NSDate *)[flex.cells getCellDataForRow:range.row inColumn:range.col formatted:NO];
        picker.opaque         = true;
        picker.datePickerMode = UIDatePickerModeDate;
        picker.date           = d;
        [picker addTarget:self action:@selector(onDatePickerChanged:) forControlEvents:UIControlEventValueChanged];
        editor.inputView = picker;
        UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, flex.frame.size.width, 44)];
        toolbar.barStyle = UIBarStyleDefault;
        UIBarButtonItem *done  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(endEditDatePicker:)];
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [toolbar setItems:@[space, done]];
        editor.inputAccessoryView = toolbar;
        editor.clearButtonMode    = UITextFieldViewModeNever;
    }
    return false;
}

- (void)onDatePickerChanged:(UIDatePicker *)sender {
    FlexGrid    *flex   = self.flex;
    UITextField *editor = (UITextField *)flex.activeEditor;
    GridColumn  *c      = [flex.columns objectAtIndex:flex.editRange.col];
    editor.text = (NSString *)[c getFormattedValue:sender.date];
}

- (BOOL)endEditDatePicker:(UITextField *)textField {
    FlexGrid     *flex   = self.flex;
    UITextField  *editor = (UITextField *)flex.activeEditor;
    UIDatePicker *picker = (UIDatePicker *)editor.inputView;
    [flex.cells setCellData:picker.date forRow:flex.editRange.row inColumn:flex.editRange.col];
    [flex finishEditing:true];
    return true;
}

@end
