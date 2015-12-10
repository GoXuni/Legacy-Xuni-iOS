//
//  FinancialDataController.m
//  XuniExplorer
//
//  Created by kelley.ricker on 10/15/15.
//  Copyright © 2015 GrapeCity. All rights reserved.
//

#import "FinancialDataController.h"
#import "XuniFlexGridKit/XuniFlexGridKit.h"
#import "StockData.h"
@interface FinancialDataController (){
    FlexGrid *flex;
    UITextField *filterField;
    UILabel *result;
    //bool *positiveChange;
}

@end

@implementation FinancialDataController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"Financial Data";
    flex = [[FlexGrid alloc] init];
    //positiveChange = false;
    flex.columnHeaderFont = [UIFont boldSystemFontOfSize:flex.columnHeaderFont.pointSize];
    flex.autoGenerateColumns = false;
    FlexColumn *c1 = [[FlexColumn alloc] init];
    c1.binding = @"symbol";
    c1.header = @"Symbol";
    c1.width = 55;
    FlexColumn *c2 = [[FlexColumn alloc] init];
    c2.binding = @"name";
    c2.header = @"Name";
    c2.width = 165;
    FlexColumn *c3 = [[FlexColumn alloc] init];
    c3.binding = @"lastSale";
    c3.header = @"Last Sale";
    //c3.width = 50;
    c3.format = @"N1";
    FlexColumn *c4 = [[FlexColumn alloc] init];
    c4.binding = @"change";
    c4.header = @"Change";
    c4.format = @"n2";
    FlexColumn *c5 = [[FlexColumn alloc] init];
    c5.binding = @"bid";
    c5.header = @"Bid";
    //c5.width = 50;
    c5.format = @"c2";
    FlexColumn *c6 = [[FlexColumn alloc] init];
    c6.binding = @"ask";
    c6.header = @"Ask";
    //c6.width = 50;
    c6.format = @"c2";
    FlexColumn *c7 = [[FlexColumn alloc] init];
    c7.header = @"50MA";
    c7.isReadOnly = true;
    c7.width = 50;
    
    FlexColumn *c8 = [[FlexColumn alloc] init];
    c8.binding = @"volume";
    //c8.width = 150;
    c8.format = @"n0";
    c8.header = @"Volume";
    
    FlexColumn *c9 = [[FlexColumn alloc] init];
    c9.binding = @"tradeTime";
    c9.header = @"Trade Time";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm:ss a"];
    c9.formatter = dateFormatter;
    [flex.columns addObject:c1];
    [flex.columns addObject:c2];
    [flex.columns addObject:c3];
    [flex.columns addObject:c4];
    [flex.columns addObject:c5];
    [flex.columns addObject:c6];
    [flex.columns addObject:c7];
    [flex.columns addObject:c8];
    [flex.columns addObject:c9];
    

    flex.itemsSource = [StockData demoData];
    flex.isReadOnly = false;
    flex.delegate = self;
    flex.selectionMode = FlexSelectionModeRowRange;
    //[flex autoSizeColumn:1 to:(flex.columns.count - 1)];
    result = [[UILabel alloc] init];
    if(UI_USER_INTERFACE_IDIOM()  == UIUserInterfaceIdiomPad){
        result.text = @"Select rows for last sale sum";
    }
    else{
        result.text = @"Select rows for\n last sale sum";
        result.font = [UIFont systemFontOfSize:11];
        result.numberOfLines = 0;
    }
    flex.frozenColumns = 1;
    //result.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
    filterField = [[UITextField alloc] init];
    filterField.delegate = self;
    filterField.text = @"Enter text to Filter";
    filterField.returnKeyType = UIReturnKeyDone;
    filterField.keyboardType = UIKeyboardTypeDefault;
    filterField.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
    //[filterField addTarget:self action:@selector(filter:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:filterField];
    [self.view addSubview:result];
    [self.view addSubview:flex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    filterField.frame = CGRectMake(5, 5, ((2* self.view.bounds.size.width) / 3) - 10, 35);
    result.frame = CGRectMake(((2 * self.view.bounds.size.width) / 3), 5, ((self.view.bounds.size.width / 3) - 5), 35);
    flex.frame = CGRectMake(0, 45, self.view.bounds.size.width, self.view.bounds.size.height - 45);
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
- (void)prepareCellForEdit:(FlexCellRangeEventArgs*)args {
    FlexColumn *col = [flex.columns objectAtIndex:args.col];
    if ([col.binding isEqualToString:@"tradeTime"]) {
        UITextField *editor = (UITextField*)flex.activeEditor;
        UIDatePicker *picker = [[UIDatePicker alloc] init];
        picker.datePickerMode = UIDatePickerModeTime;
        NSDate *d = (NSDate*)[flex.cells getCellDataForRow:args.row inColumn:args.col formatted:NO];
        picker.opaque = true;
        //picker.datePickerMode = UIDatePickerModeDate;
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
}
- (void)onDatePickerChanged:(UIDatePicker*)sender {
    UITextField *editor = (UITextField*)flex.activeEditor;
    FlexColumn *c = [flex.columns objectAtIndex:flex.editRange.col];
    editor.text = (NSString*)[c getFormattedValue:sender.date];
}

- (BOOL)endEditDatePicker:(UITextField *)textField {
    UITextField *editor = (UITextField*)flex.activeEditor;
    UIDatePicker *picker = (UIDatePicker*)editor.inputView;
    [flex.cells setCellData:picker.date forRow:flex.editRange.row inColumn:flex.editRange.col];
    [flex finishEditing:true];
    return true;
}

-(void)filter:(UITextField *)textField{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"M/d/yy"];
    flex.collectionView.filter = ^ BOOL (NSObject *item){
        StockData *d = (StockData*)item;
        if ([[NSString stringWithFormat:@"%@", d.bid] rangeOfString:textField.text].location != NSNotFound) {
            return true;
        }
        else if ([[NSString stringWithFormat:@"%@", d.ask] rangeOfString:textField.text].location != NSNotFound) {
            return true;
        }
        else if ([[NSString stringWithFormat:@"%@", d.lastSale] rangeOfString:textField.text].location != NSNotFound) {
            return true;
        }
        else if ([[NSString stringWithFormat:@"%@", d.change] rangeOfString:textField.text].location != NSNotFound) {
            return true;
        }
        else if ([[NSString stringWithFormat:@"%@", d.bidSize] rangeOfString:textField.text].location != NSNotFound) {
            return true;
        }
        else if ([[NSString stringWithFormat:@"%@", d.askSize] rangeOfString:textField.text].location != NSNotFound) {
            return true;
        }
        else if ([[NSString stringWithFormat:@"%@", d.lastSize] rangeOfString:textField.text].location != NSNotFound) {
            return true;
        }
        else if ([[NSString stringWithFormat:@"%@", d.volume] rangeOfString:textField.text].location != NSNotFound) {
            return true;
        }
        else if ([d.symbol rangeOfString:textField.text].location != NSNotFound) {
            return true;
        }
        else if ([d.name rangeOfString:textField.text].location != NSNotFound)
        {
            return true;
        }
        else if ([[dateFormat stringFromDate:d.quoteTime] rangeOfString:textField.text].location != NSNotFound) {
            return true;
        }
        else if ([[dateFormat stringFromDate:d.tradeTime] rangeOfString:textField.text].location != NSNotFound) {
            return true;
        }
        else {
            return false;
        }
    };

}
-(void)selectionChanged:(FlexCellRangeEventArgs *)args{
    if(args.cellRange.row != -1){
        //int rowsSelected = abs(args.cellRange.row2 - args.cellRange.row) + 1;
        NSNumber *totalSale = @0;
        NSNumber *lastSale = @0;
        int upperRow = args.cellRange.row;
        int lowerRow = args.cellRange.row2;
        if (args.cellRange.row2 < args.cellRange.row) {
            upperRow = args.cellRange.row2;
            lowerRow = args.cellRange.row;
        }
        for (int i = upperRow; i <= lowerRow; i++) {
            lastSale = (NSNumber *)[args.panel getCellDataForRow:i inColumn:2 formatted:false];
            totalSale = [NSNumber numberWithFloat:([totalSale floatValue] + [lastSale floatValue])];
        }
        result.text = [@"Last sale sum: " stringByAppendingString: [totalSale stringValue]];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if(UI_USER_INTERFACE_IDIOM()  == UIUserInterfaceIdiomPad){
        result.text = @"Select rows for last sale sum";
    }
    else{
        result.text = @"Select rows for\n last sale sum";
    }
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"M/d/yy"];
    flex.selection.row = -1;
    flex.selection.col= -1;
    if (![textField.text isEqualToString:@""]) {
        flex.collectionView.filter = ^ BOOL (NSObject *item){
            StockData *d = (StockData*)item;
            NSString *lowercase = [textField.text lowercaseString];
            if ([[NSString stringWithFormat:@"%@", d.bid] rangeOfString:textField.text].location != NSNotFound) {
                return true;
            }
            else if ([[NSString stringWithFormat:@"%@", d.ask] rangeOfString:textField.text].location != NSNotFound) {
                return true;
            }
            else if ([[NSString stringWithFormat:@"%@", d.lastSale] rangeOfString:textField.text].location != NSNotFound) {
                return true;
            }
            else if ([[NSString stringWithFormat:@"%@", d.change] rangeOfString:textField.text].location != NSNotFound) {
                return true;
            }
            else if ([[NSString stringWithFormat:@"%@", d.bidSize] rangeOfString:textField.text].location != NSNotFound) {
                return true;
            }
            else if ([[NSString stringWithFormat:@"%@", d.askSize] rangeOfString:textField.text].location != NSNotFound) {
                return true;
            }
            else if ([[NSString stringWithFormat:@"%@", d.lastSize] rangeOfString:textField.text].location != NSNotFound) {
                return true;
            }
            else if ([[NSString stringWithFormat:@"%@", d.volume] rangeOfString:textField.text].location != NSNotFound) {
                return true;
            }
            else if ([[d.symbol lowercaseString] rangeOfString:lowercase].location != NSNotFound) {
                return true;
            }
            else if ([[d.name lowercaseString] rangeOfString:lowercase].location != NSNotFound)
            {
                return true;
            }
            else if ([[dateFormat stringFromDate:d.quoteTime] rangeOfString:textField.text].location != NSNotFound) {
                return true;
            }
            else if ([[dateFormat stringFromDate:d.tradeTime] rangeOfString:textField.text].location != NSNotFound) {
                return true;
            }
            else {
                return false;
            }
        };
    }
    else{
        flex.collectionView.filter = ^ BOOL (NSObject *item){return true;};
    }
    [flex setNeedsDisplay];

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
}
- (void)formatItem:(FlexFormatItemEventArgs*)args{
    if (!([filterField.text isEqualToString:@"Enter text to Filter"]) || !([filterField.text isEqualToString:@""])) {
        NSObject *v = (NSObject *)[args.panel getCellDataForRow:args.row inColumn:args.col formatted:true];
        if((![v.description  isEqual: @"Symbol"]) && (![v.description  isEqual: @"Name"]) && (![v.description  isEqual: @"LastSale"]) && (![v.description  isEqual: @"Change"]) && (![v.description  isEqual: @"Bid"]) && (![v.description  isEqual: @"Ask"]) && (![v.description  isEqual: @"50MA"]) && (![v.description  isEqual: @"Volume"]) && (![v.description  isEqual: @"TradeTime"])){
            NSString *lowercase = [filterField.text lowercaseString];
            if ([[v.description lowercaseString] rangeOfString:lowercase].location != NSNotFound){

                [args.panel.textAttributes setValue:[UIColor blueColor] forKey:NSForegroundColorAttributeName];
            }
        }
    }
    FlexColumn *col = [flex.columns objectAtIndex:args.col];
    if ([col.binding isEqualToString:@"lastSale"]) {
        NSObject *v = (NSObject *)[args.panel getCellDataForRow:args.row inColumn:args.col formatted:false];
        if (!([v.description isEqual: @"Last Sale"])) {
            if([v.description doubleValue] > 500){
                [args.panel.textAttributes setValue:[UIColor colorWithRed:0 green:.518 blue:0 alpha:1] forKey:NSForegroundColorAttributeName];
            }
            else{
                [args.panel.textAttributes setValue:[UIColor redColor] forKey:NSForegroundColorAttributeName];
            }
            
        }
    }
    else if ([col.binding isEqualToString:@"change"]) {
        NSObject *v = (NSObject *)[args.panel getCellDataForRow:args.row inColumn:args.col formatted:false];
        if (!([v.description isEqual: @"Change"])) {
            if([v.description doubleValue] > 0){
                 [args.panel.textAttributes setValue:[UIColor colorWithRed:0 green:.518 blue:0 alpha:1] forKey:NSForegroundColorAttributeName];
                //positiveChange = true;
            }
            else if([v.description doubleValue]  < 0){
                [args.panel.textAttributes setValue:[UIColor redColor] forKey:NSForegroundColorAttributeName];
                //positiveChange = false;
            }

        }
    }
    else if ([col.header isEqualToString:@"50MA"]) {
        NSObject *v = (NSObject *)[args.panel getCellDataForRow:args.row inColumn:args.col formatted:false];
        NSObject *change = (NSObject *)[args.panel getCellDataForRow:args.row inColumn:3 formatted:false];
        if (!([v.description isEqual: @"50MA"])) {
            
            CGRect r = [args.panel getCellRectForRow:args.row inColumn:args.col];
            
            r.origin.x += (r.size.width/2 - 10);
            r.origin.y += (r.size.height/2 - 10);
            
            r.size.width = 20;
            r.size.height = 20;
            
            UIImage *image = [[UIImage alloc] init];
            if([change.description doubleValue] > 0){
                image = [UIImage imageNamed:@"arrow-up-green"];
            }
            else{
                image = [UIImage imageNamed:@"arrow-down-red"];
            }
            [image drawInRect:r];
            args.cancel = true;
        }
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
