//
//  ColumnLayoutController.m
//  FlexGrid101
//
//  Copyright © 2015 GrapeCity. All rights reserved.
//

#import "ColumnLayoutController.h"

@interface ColumnLayoutController ()
@property (weak, nonatomic) IBOutlet UIVisualEffectView *columnList;

@end

@implementation ColumnLayoutController
{
    UIBarButtonItem *editButton;
    UIBarButtonItem *restoreButton;
    GridColumnCollection* columnsInitial;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    editButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Edit Columns", nil) style:UIBarButtonItemStylePlain target:self action:@selector(editColumns:)];
    restoreButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Restore", nil) style:UIBarButtonItemStylePlain target:self action:@selector(restoreColumns:)];
    
    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:editButton, nil];
    
    self.columnList.hidden = true;
    
    self.flex.columnHeaderFont = [UIFont boldSystemFontOfSize:self.flex.columnHeaderFont.pointSize];
    self.flex.isReadOnly = true;
    self.flex.itemsSource = [CustomerData getCustomerData:100];
    columnsInitial = [[GridColumnCollection alloc] init];
    for(int i = 0; i < self.flex.columns.count; i++) [columnsInitial addObject:self.flex.columns[i]];
    [self.flex autoSizeColumns:0 to:self.flex.columns.count-1];
}

-(void)beginEditing
{
    [((ColumnReordererTableViewController*)self.childViewControllers.firstObject).tableView reloadData];
    
    self.columnList.alpha = 0;
    self.columnList.hidden = false;
    [UIView animateWithDuration:0.7 animations:^{
        self.columnList.alpha = 1;
    } completion:^(BOOL finished){
        
    }];
    
    
    editButton.title = NSLocalizedString(@"Done", nil);
    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:editButton, restoreButton, nil];
}

-(void)endEditing
{
    [UIView animateWithDuration:0.7 animations:^{
        self.columnList.alpha = 0;
    } completion:^(BOOL finished){
        self.columnList.hidden = true;
    }];
    
    
    editButton.title = NSLocalizedString(@"Edit Columns", nil);
    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:editButton, nil];
}

- (IBAction)restoreColumns:(id)sender
{
    [self.flex.columns removeAllObjects];
    for (int i = 0; i < columnsInitial.count; i++) {
        [self.flex.columns addObject:columnsInitial[i]];
    }
    
    [((ColumnReordererTableViewController*)self.childViewControllers.firstObject).tableView reloadData];
}

- (IBAction)editColumns:(id)sender
{
    if(self.columnList.hidden)
    {
        [self beginEditing];
    }
    else
    {
        [self endEditing];
    }
}


@end
