//
//  GroupingController.m
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "GroupingController.h"
#import "CustomerData.h"
#import "XuniFlexGridDynamicKit/XuniFlexGridDynamicKit.h"

@interface GroupingController ()
@property (weak, nonatomic) IBOutlet FlexGrid *flex;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sortButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *collapseButton;

@end

@implementation GroupingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.flex.columnHeaderFont = [UIFont boldSystemFontOfSize:self.flex.columnHeaderFont.pointSize];
    self.flex.isReadOnly = true;
    self.flex.autoGenerateColumns = false;
    
    GridColumn *c1 = [[GridColumn alloc] init];
    c1.binding = @"active";
    c1.header = NSLocalizedString(@"Active", nil);
    c1.width = 100;
    
    GridColumn *c2 = [[GridColumn alloc] init];
    c2.binding = @"firstName";
    c2.header = NSLocalizedString(@"Name", nil);
    
    GridColumn *c3 = [[GridColumn alloc] init];
    c3.binding = @"orderTotal";
    c3.header = NSLocalizedString(@"Order Total", nil);
    c3.format = @"C";
    c3.aggregate = XuniAggregateSum;
    
    [self.flex.columns addObject:c1];
    [self.flex.columns addObject:c2];
    [self.flex.columns addObject:c3];
    
    
    XuniPropertyGroupDescription *gd = [[XuniPropertyGroupDescription alloc]initWithProperty:@"country"];

    self.flex.itemsSource = [CustomerData getCustomerData:100];
    [self.flex.collectionView.groupDescriptions addObject:gd];

    [self starSizing:self.flex];
}

-(void)starSizing:(FlexGrid*)g{
    for (int i = 0; i < g.columns.count; i++) {
        GridColumn *c = [g.columns objectAtIndex:i];
        c.widthType = GridColumnWidthStar;
        c.width = (i == 0) ? 2 : (i == 3) ? 3 : 4;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doSort:(id)sender {
    UIBarButtonItem* btn = (UIBarButtonItem*)sender;
    if([btn.title isEqualToString:NSLocalizedString(@"Z-A", nil)])
    {
        [self sortDescendingButtonClicked];
        btn.title = NSLocalizedString(@"A-Z", nil);
    }
    else
    {
        [self sortAscendingButtonClicked];
        btn.title = NSLocalizedString(@"Z-A", nil);
    }
}

- (IBAction)doCollapse:(id)sender {
    UIBarButtonItem* btn = (UIBarButtonItem*)sender;
    if([btn.title isEqualToString:NSLocalizedString(@"Collapse", nil)])
    {
        [self.flex collapseGroupsToLevel:0];
        btn.title = NSLocalizedString(@"Expand", nil);
        
    }
    else
    {
        if ([self.flex finishEditing:NO]) {
            for (int i = 0; i < self.flex.rows.count; i++) {
                GridRow *row = (GridRow *)[self.flex.rows objectAtIndex:i];
                if ([row isKindOfClass:[GridGroupRow class]]) {
                    GridGroupRow *group = (GridGroupRow *)row;
                    group.isCollapsed = false;
                }
            }
        }
        btn.title = NSLocalizedString(@"Collapse", nil);
    }
}

-(void)sortAscendingButtonClicked{
    [self.flex.collectionView.sortDescriptions removeAllObjects];
    XuniSortDescription *sd =[[XuniSortDescription alloc] initWithProperty:@"country" ascending:true];
    [self.flex.collectionView.sortDescriptions addObject:sd];
    self.collapseButton.title = NSLocalizedString(@"Collapse", nil);
}

-(void)sortDescendingButtonClicked{
    [self.flex.collectionView.sortDescriptions removeAllObjects];
    XuniSortDescription *sd =[[XuniSortDescription alloc] initWithProperty:@"country" ascending:false];
    [self.flex.collectionView.sortDescriptions addObject:sd];
    self.collapseButton.title = NSLocalizedString(@"Collapse", nil);
}

@end