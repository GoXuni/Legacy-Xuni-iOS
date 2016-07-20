//
//  StarSizingController.m
//  FlexGrid101
//
//  Copyright © 2015 GrapeCity. All rights reserved.
//

#import "StarSizingController.h"
#import "CustomerData.h"
#import "XuniFlexGridDynamicKit/XuniFlexGridDynamicKit.h"

@interface StarSizingController ()
@property (weak, nonatomic) IBOutlet FlexGrid *flex;

@end

@implementation StarSizingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.flex.columnHeaderFont = [UIFont boldSystemFontOfSize:self.flex.columnHeaderFont.pointSize];
    self.flex.autoGenerateColumns = false;
    
    GridColumn *c1 = [[GridColumn alloc] init];
    c1.binding = @"firstName";
    c1.header = NSLocalizedString(@"First Name", nil);
    c1.widthType = GridColumnWidthStar;
    c1.width = 3;
    
    GridColumn *c2 = [[GridColumn alloc] init];
    c2.binding = @"lastName";
    c2.header = NSLocalizedString(@"Last Name", nil);
    c2.widthType = GridColumnWidthStar;
    c2.width = 3;
    
    GridColumn *c3 = [[GridColumn alloc] init];
    c3.binding = @"lastOrderDate";
    c3.header = NSLocalizedString(@"Last Date", nil);
    c3.widthType = GridColumnWidthStar;
    c3.width = 2;
    
    GridColumn *c4 = [[GridColumn alloc] init];
    c4.binding = @"orderTotal";
    c4.header = NSLocalizedString(@"Total", nil);
    c4.format = @"C";
    c4.headerHorizontalAlignment = NSTextAlignmentLeft;
    c4.widthType = GridColumnWidthStar;
    c4.width = 2;
    

    
    [self.flex.columns addObject:c1];
    [self.flex.columns addObject:c2];
    [self.flex.columns addObject:c3];
    [self.flex.columns addObject:c4];
    
    self.flex.itemsSource = [CustomerData getCustomerData:100];
    self.flex.isReadOnly = true;
}


@end
