//
//  FilterController.m
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "FilterController.h"
#import "CustomerData.h"
#import "FilterData.h"
#import "FilterGridViewController.h"

@interface FilterController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem    *filterButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem    *removeFilterButton;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *filterPane;

@end

@implementation FilterController

- (void)doDropFilter {
    self.filterButton.title         = NSLocalizedString(@"Filter", nil);
    self.removeFilterButton.enabled = false;
    self.filterPane.hidden          = true;
    self.flex.collectionView.filter = ^BOOL (NSObject *item){
        return true;
    };
}

- (void)doApplyFilter {
    self.filterButton.title         = NSLocalizedString(@"Change", nil);
    self.filterPane.hidden          = true;
    self.removeFilterButton.enabled = true;

    self.flex.collectionView.filter = ^BOOL (NSObject *item){
        NSMutableArray *shared = [FilterData sharedFilterData];
        bool           result  = true;
        for (int i = 0; i < shared.count; i++) {
            FilterData *fd = [shared objectAtIndex:i];

            GridColumn *col       = (GridColumn *)[self.flex.columns objectAtIndex:i];
            NSString   *thisprop  = [col getBoundValue:item].description.lowercaseString;
            NSString   *filterstr = fd.filterString.lowercaseString;

            if(filterstr.length>0){
                if (fd.filterOperation == 0) {
                    //contains
                    if (![thisprop containsString:filterstr]) {
                        result = false;
                        break;
                    }

                } else if (fd.filterOperation == 1) {
                    //starts
                    if (![thisprop hasPrefix:filterstr]) {
                        result = false;
                        break;
                    }
                } else if (fd.filterOperation == 2) {
                    //ends
                    if (![thisprop hasSuffix:filterstr]) {
                        result = false;
                        break;
                    }
                } else if (fd.filterOperation == 3) {
                    //equalstext
                    if (![thisprop isEqualToString:filterstr]) {
                        result = false;
                        break;
                    }
                }
            }
        }
        return result;
    };
}

- (void)doStartEditingFilter {
    if ([self.filterButton.title isEqualToString:NSLocalizedString(@"Filter", nil)]) {
        NSMutableArray *shared = [FilterData sharedFilterData];
        [shared removeAllObjects];
        for (int i = 0; i < self.flex.columns.count; i++) {
            GridColumn *c  = [self.flex.columns objectAtIndex:i];
            FilterData *fd = [[FilterData alloc]init];
            fd.filterColumn    = c.header;
            fd.filterOperation = 0;
            fd.filterString    = nil;
            [shared addObject:fd];
        }
    }

    FilterGridViewController *filterController = (FilterGridViewController *)self.childViewControllers.firstObject;
    filterController.flex.itemsSource = [FilterData sharedFilterData];

    GridColumn     *operID = (GridColumn *)[filterController.flex.columns objectAtIndex:1];
    NSMutableArray *items  = [NSMutableArray arrayWithArray:[FilterOperation defaultOperations]];
    operID.dataMap = [[GridDataMap alloc] initWithArray:items selectedValuePath:@"identifier" displayMemberPath:@"title"];

    self.filterButton.title         = NSLocalizedString(@"Done", nil);
    self.filterPane.hidden          = false;
    self.removeFilterButton.enabled = true;
}

- (IBAction)doFilter:(id)sender {
    if ([self.filterButton.title isEqualToString:NSLocalizedString(@"Done", nil)]) {
        [self doApplyFilter];
    } else {
        [self doStartEditingFilter];
    }
}

- (IBAction)removeFilter:(id)sender {
    [self doDropFilter];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.flex.columnHeaderFont = [UIFont boldSystemFontOfSize:self.flex.columnHeaderFont.pointSize];

    self.flex.isReadOnly  = true;
    self.flex.itemsSource = [CustomerData getCustomerData:100];

}

@end