//
//  EmployeeDataController.m
//  XuniExplorer
//
//  Created by kelley.ricker on 10/15/15.
//  Copyright © 2015 GrapeCity. All rights reserved.
//

#import "EmployeeDataController.h"
#import "EmployeeDataParser.h"
#import "DepartmentsDataParser.h"
#import "XuniFlexGridKit/XuniFlexGridKit.h"
#import "XuniGaugeKit/XuniGaugeKit.h"

@interface EmployeeDataController (){
    UIButton *group;
    UIButton *reorder;
    UIButton *edit;
    BOOL groupToggle;
    
}
@property (weak, nonatomic) IBOutlet UIVisualEffectView *columnList;

@end

EmployeeDataController* employeeDataController;

@implementation EmployeeDataController

- (void)viewDidLoad {
    employeeDataController = self;
    
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //self.columnList.hidden = true;
    self.title = @"Employee Data";
    
    group = [UIButton buttonWithType:UIButtonTypeSystem];

    [group setTitle:@"Group" forState:UIControlStateNormal];
    [group addTarget:self action:@selector(groupClicked) forControlEvents:UIControlEventTouchUpInside];
    [group.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    self.flex = [[FlexGrid alloc] init];
    self.flex.autoGenerateColumns = true;
    self.flex.delegate = self;
    self.flex.alternatingRowBackgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.0];
    self.flex.selectionMode = FlexSelectionModeRow;
    self.flex.headersVisibility = FlexHeadersVisibilityColumn;
    NSMutableArray *employeeArray = [[NSMutableArray alloc] init];
    EmployeeDataParser *employeeParser = [[EmployeeDataParser alloc] initWithArray:employeeArray];
    [employeeParser parseXMLFile];
    self.flex.itemsSource = employeeArray;
    self.flex.isReadOnly = false;
    self.flex.rows.defaultSize = 100;
    self.flex.rows.defaultGroupSize = 40;
    self.flex.allowSorting = true;
    
    self.flex.autoGenerateColumns = false;
    FlexColumn *c1 = [[FlexColumn alloc] init];
    c1.binding = @"thumbnailImage";
    c1.header = @"Thumbnail";
    FlexColumn *c2 = [[FlexColumn alloc] init];
    c2.binding = @"name";
    c2.header = @"Name";
    FlexColumn *c3 = [[FlexColumn alloc] init];
    c3.binding = @"departmentID";
    c3.header = @"Department";
    NSMutableArray *departmentsArray = [[NSMutableArray alloc] init];
    DepartmentsDataParser *departmentsParser = [[DepartmentsDataParser alloc] initWithArray:departmentsArray];
    [departmentsParser parseXMLFile];
    c3.dataMap = [[FlexDataMap alloc] initWithArray:departmentsArray selectedValuePath:@"departmentID" displayMemberPath:@"name"];
    FlexColumn *c4 = [[FlexColumn alloc] init];
    c4.binding = @"hireDate";
    c4.header = @"Hire Date";
    
    FlexColumn *c5 = [[FlexColumn alloc] init];
    c5.binding = @"fulltime";
    c5.header = @"Fulltime";
    
    FlexColumn *c6 = [[FlexColumn alloc] init];
    c6.binding = @"status";
    c6.header = @"Status";
    
    [self.flex.columns addObject:c1];
    [self.flex.columns addObject:c2];
    [self.flex.columns addObject:c3];
    [self.flex.columns addObject:c4];
    [self.flex.columns addObject:c5];
    [self.flex.columns addObject:c6];
    
    if(UI_USER_INTERFACE_IDIOM()  == UIUserInterfaceIdiomPad){
        
        [self starSizing:self.flex];
        
    }
    
    groupToggle = false;
    
    [self.view addSubview:group];
    [self.view addSubview:self.flex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    group.frame = CGRectMake(0, 0, self.view.bounds.size.width, 35);
    self.flex.frame = CGRectMake(0, 35, self.view.bounds.size.width, self.view.bounds.size.height - 35);
}

-(void)starSizing:(FlexGrid*)g{
    for (int i = 0; i < g.columns.count; i++) {
        FlexColumn *c = [g.columns objectAtIndex:i];
        c.widthType = FlexColumnWidthStar;
        // c.width = (i == 0) ? 5 : (i == 3) ? 3 : 4;
    }
}

- (void)formatItem:(FlexFormatItemEventArgs*)args{
    FlexColumn *col = [self.flex.columns objectAtIndex:args.col];
    if ([col.binding isEqualToString:@"thumbnailImage"]) {
        NSObject *v = [args.panel getCellDataForRow:args.row inColumn:args.col formatted:false];
        if (v != nil) {
            if (![v.description isEqual: @"Thumbnail"]){
                
                CGRect r = [args.panel getCellRectForRow:args.row inColumn:args.col];
                
                
                r.origin.x+=(r.size.width/2 - 45);
                r.origin.y+=(r.size.height/2 - 45);
                
                r.size.width = 90;
                r.size.height = 90;
                
                UIImage *image = [[UIImage alloc] init];
                image = [UIImage imageNamed:v.description];
                [image drawInRect:r];
                args.cancel = YES;
            }
        }
    }
    else if ([col.binding isEqualToString:@"status"]) {
        NSObject *v = [args.panel getCellDataForRow:args.row inColumn:args.col formatted:false];
        if (v != nil) {
            if (![v.description isEqual: @"Status"]){
                
                XuniLinearGauge *linearGauge = [[XuniLinearGauge alloc] init];
                
                linearGauge.showText = XuniShowTextNone;
                linearGauge.thickness = 0.6;
                linearGauge.min = 0;
                linearGauge.max = 1;
                linearGauge.loadAnimation = nil;
                linearGauge.value =[v.description doubleValue];
                linearGauge.showRanges = false;
                
                CGRect r = [args.panel getCellRectForRow:args.row inColumn:args.col];
                
                
                r.origin.x+=4;
                r.origin.y+=r.size.height/2 - 20;
                
                r.size.width-=8;
                r.size.height = 40;
                
                
                XuniRect *t = [[XuniRect alloc] initLeft:0 top:0 width:r.size.width height:r.size.height];
                linearGauge.rectGauge = t;
                linearGauge.frame = CGRectMake(0, 0, r.size.width, r.size.height);
                
                UIImage *image = [[UIImage alloc] init];
                image = [UIImage imageWithData:[linearGauge getImage]];
                [image drawInRect:r];
                args.cancel = YES;
                
            }
        }
    }
}
- (void)prepareCellForEdit:(FlexCellRangeEventArgs*)args {
    FlexColumn *col = [self.flex.columns objectAtIndex:args.col];
    if ([col.binding isEqualToString:@"hireDate"]) {
        UITextField *editor = (UITextField*)self.flex.activeEditor;
        UIDatePicker *picker = [[UIDatePicker alloc] init];
        NSDate *d = (NSDate*)[self.flex.cells getCellDataForRow:args.row inColumn:args.col formatted:NO];
        picker.opaque = true;
        picker.datePickerMode = UIDatePickerModeDate;
        picker.date = d;
        [picker addTarget:self action:@selector(onDatePickerChanged:) forControlEvents:UIControlEventValueChanged];
        editor.inputView = picker;
        UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.flex.frame.size.width, 44)];
        toolbar.barStyle = UIBarStyleDefault;
        UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(endEditDatePicker:)];
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [toolbar setItems:@[space, done]];
        editor.inputAccessoryView = toolbar;
        editor.clearButtonMode = UITextFieldViewModeNever;
    }
}
- (void)onDatePickerChanged:(UIDatePicker*)sender {
    UITextField *editor = (UITextField*)self.flex.activeEditor;
    FlexColumn *c = [self.flex.columns objectAtIndex:self.flex.editRange.col];
    editor.text = (NSString*)[c getFormattedValue:sender.date];
}

- (BOOL)endEditDatePicker:(UITextField *)textField {
    UITextField *editor = (UITextField*)self.flex.activeEditor;
    UIDatePicker *picker = (UIDatePicker*)editor.inputView;
    [self.flex.cells setCellData:picker.date forRow:self.flex.editRange.row inColumn:self.flex.editRange.col];
    [self.flex finishEditing:true];
    return true;
}
- (void)groupClicked{
    if (groupToggle == false) {
        XuniPropertyGroupDescription *gd = [[XuniPropertyGroupDescription alloc] initWithProperty:@"departmentID"];
        [self.flex.collectionView.groupDescriptions addObject:gd];
        [group  setTitle:@"Ungroup" forState:UIControlStateNormal];
        groupToggle = true;
    }
    else{
        [self.flex.collectionView.groupDescriptions removeAllObjects];
        [group  setTitle:@"Group" forState:UIControlStateNormal];
        groupToggle = false;
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
