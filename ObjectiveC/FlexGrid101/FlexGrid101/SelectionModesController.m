//
//  SelectionModesController.m
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "SelectionModesController.h"
#import "CustomerData.h"
#import "XuniFlexGridDynamicKit/XuniFlexGridDynamicKit.h"

@interface SelectionModesController ()

@property (weak, nonatomic) IBOutlet FlexGrid           *flex;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSwitch;
@property (weak, nonatomic) IBOutlet UIBarButtonItem    *selected;
@property (weak, nonatomic) IBOutlet UIBarButtonItem    *selectedCount;

@end

@implementation SelectionModesController
- (IBAction)modeSwitched:(id)sender {
    NSInteger row = self.modeSwitch.selectedSegmentIndex;

    if (row == 0) {
        self.flex.selectionMode = GridSelectionModeNone;
    } else if (row == 1) {
        self.flex.selectionMode = GridSelectionModeCell;
    } else if (row == 2) {
        self.flex.selectionMode = GridSelectionModeCellRange;
    } else if (row == 3) {
        self.flex.selectionMode = GridSelectionModeRow;
    } else if (row == 4) {
        self.flex.selectionMode = GridSelectionModeRowRange;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.flex.isReadOnly       = true;
    self.flex.columnHeaderFont = [UIFont boldSystemFontOfSize:self.flex.columnHeaderFont.pointSize];
    self.flex.selectionMode    = GridSelectionModeNone;
    self.flex.itemsSource      = [CustomerData getCustomerData:100];
    
    [self.flex.flexGridSelectionChanged addHandler:^(XuniEventContainer<GridCellRangeEventArgs *> *eventContainer) {
        int selected = self.flex.selection.columnSpan * self.flex.selection.rowSpan;
        
        self.selectedCount.title = [NSString stringWithFormat:@"%i selected", selected];
    } forObject:self];
}

@end