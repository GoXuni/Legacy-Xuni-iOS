//
//  ColumnDefinitionsController.m
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "ColumnDefinitionsController.h"
#import "XuniFlexGridDynamicKit/XuniFlexGridDynamicKit.h"
#import "CustomerData.h"
@interface ColumnDefinitionsController ()
@property (weak, nonatomic) IBOutlet FlexGrid *flex;

@end

@implementation ColumnDefinitionsController
 
- (void)viewDidLoad {
    [super viewDidLoad];
    self.flex.columnHeaderFont = [UIFont boldSystemFontOfSize:self.flex.columnHeaderFont.pointSize];
    self.flex.autoGenerateColumns = false;
    
    GridColumn *active = [[GridColumn alloc] init];
    active.binding = @"active";
    active.widthType = GridColumnWidthPixel;
    active.width = 70;
    [self.flex.columns addObject:active];
    
    GridColumn *identifier = [[GridColumn alloc] init];
    identifier.binding = @"customerID";
    identifier.isReadOnly = true;
    identifier.widthType = GridColumnWidthPixel;
    identifier.width = 100;
    [self.flex.columns addObject:identifier];
    
    GridColumn *firstName = [[GridColumn alloc] init];
    firstName.binding = @"firstName";
    [self.flex.columns addObject:firstName];
    
    GridColumn *lastName = [[GridColumn alloc] init];
    lastName.binding = @"lastName";
    [self.flex.columns addObject:lastName];
    
    GridColumn *orderTotal = [[GridColumn alloc] init];
    orderTotal.binding = @"orderTotal";
    orderTotal.format = @"C2";
    [self.flex.columns addObject:orderTotal];
    
    GridColumn *countryID = [[GridColumn alloc] init];
    countryID.binding = @"countryID";
    countryID.header = @"Country";
    countryID.horizontalAlignment = NSTextAlignmentLeft;
    NSMutableArray *items = [NSMutableArray arrayWithArray:[CustomerData defaultCountries]];
    countryID.dataMap = [[GridDataMap alloc] initWithArray:items selectedValuePath:@"identifier" displayMemberPath:@"title"];
    [self.flex.columns addObject:countryID];
    
    GridColumn *lastOrderDate = [[GridColumn alloc] init];
    lastOrderDate.binding = @"lastOrderDate";
    [self.flex.columns addObject:lastOrderDate];
    
    GridColumn *lastOrderTime = [[GridColumn alloc] init];
    lastOrderTime.binding = @"lastOrderDate";
    lastOrderTime.header = @"Last Order Time";
    NSDateFormatter* datefmt           = [[NSDateFormatter alloc] init];
    [datefmt setDateFormat:@"hh:mm a"];
    lastOrderTime.formatter = datefmt;
    [self.flex.columns addObject:lastOrderTime];
    
    self.flex.itemsSource = [CustomerData getCustomerData:100];
    self.flex.isReadOnly = false;
}

@end