//
//  FrozenCellsController.m
//  FlexGrid101
//
//  Copyright © 2015 GrapeCity. All rights reserved.
//

#import "FrozenCellsController.h"
#import "CustomerData.h"
#import "XuniFlexGridDynamicKit/XuniFlexGridDynamicKit.h"

@interface FrozenCellsController ()
@property (weak, nonatomic) IBOutlet FlexGrid *flex;

@end

@implementation FrozenCellsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.flex.columnHeaderFont = [UIFont boldSystemFontOfSize:self.flex.columnHeaderFont.pointSize];
    self.flex.isReadOnly = true;
    self.flex.itemsSource = [CustomerData getCustomerData:100];
    
    self.flex.frozenColumns = 1;
    self.flex.frozenRows = 1;
    
    self.flex.allowMerging = GridAllowMergingCells;
    
    for(int i = 0; i<self.flex.columns.count; i++)
    {
        GridColumn* fc = [self.flex.columns objectAtIndex:i];
        if([fc.binding isEqualToString: @"country"]) fc.allowMerging = true;
    }
    
    [self.flex autoSizeColumns:0 to:self.flex.columns.count-1];
}

@end
