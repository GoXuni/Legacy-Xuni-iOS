//
//  UnboundSampleViewController.m
//  FlexGrid101
//
//  Created by Mykola Kotyuck on 16.06.16.
//  Copyright © 2016 GrapeCity. All rights reserved.
//

#import "UnboundSampleViewController.h"
#import "XuniFlexGridDynamicKit/XuniFlexGridDynamicKit.h"

@interface UnboundSampleViewController ()
@property (weak, nonatomic) IBOutlet FlexGrid *grid;

@end

@implementation UnboundSampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // allow merging
    _grid.allowMerging = GridAllowMergingAll;
    
    // add rows/columns to the unbound grid
    for (int i = 0; i < 12; i++) // three years, four quarters per year
    {
        [_grid.columns addObject:[[GridColumn alloc] init]];
    }
    for (int i = 0; i < 500; i++)
    {
        [_grid.rows addObject:[[GridRow alloc] init]];
    }
    
    // populate the unbound grid with some stuff
    for (int r = 0; r < _grid.rows.count; r++)
    {
        for (int c = 0; c < _grid.columns.count; c++)
        {
            _grid[r][c] = [NSString stringWithFormat:@"cell [%i, %i]", r, c];
        }
    }
    
    // set unbound column headers
    GridPanel* ch = _grid.columnHeaders;
    [ch.rows addObject:[[GridRow alloc] init]]; // one header row for years, one for quarters
    for (int c = 0; c < ch.columns.count; c++)
    {
        ch[0][c] = @(2016 + c / 4); // year
        ch[1][c] = [NSString stringWithFormat:@"Q %i", c%4+1]; // quarter
    }
    
    // allow merging the first fixed row
    ch.rows[0].allowMerging = true;
    
    // set unbound row headers
    GridPanel* rh = _grid.rowHeaders;
    [rh.columns addObject:[[GridColumn alloc] init]];
    for (int c = 0; c < rh.columns.count; c++)
    {
        rh.columns[c].width = 60;
        for (int r = 0; r < rh.rows.count; r++)
        {
            rh[r][c] = [NSString stringWithFormat:@"hdr %i, %i", c == 0 ? r / 2 : r, c];
        }
    }
    
    // allow merging the first fixed column
    rh.columns[0].allowMerging = true;
    
    [_grid autoSizeColumns:0 to:1 header:true];
    [_grid autoSizeColumns];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
