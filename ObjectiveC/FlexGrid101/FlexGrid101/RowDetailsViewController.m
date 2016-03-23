//
//  RowDetailsViewController.m
//  FlexGrid101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//

#import "CustomerData.h"
#import "XuniFlexGridKit/XuniFlexGridKit.h"
#import "RowDetailsViewController.h"

@interface RowDetailsViewController ()
@property (weak, nonatomic) IBOutlet FlexGrid *grid;

@end

@implementation RowDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.grid.isReadOnly = true;
    self.grid.itemsSource = [CustomerData getCustomerData:100];
    
    IXuniEventHandler rowHeaderLoadingEventHandler = ^(NSObject *sender, XuniEventArgs *args)
    {
        FlexGridRowHeaderLoadingEventArgs *e=(FlexGridRowHeaderLoadingEventArgs*)args;
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"show"] forState:(UIControlStateNormal)];
        [btn setImage:[UIImage imageNamed:@"hide"] forState:(UIControlStateSelected)];
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        e.button=btn;
    };
    
    [self.grid.detailProvider.gridRowHeaderLoading addHandler:rowHeaderLoadingEventHandler forObject:self];
    
    
    IXuniEventHandler detailCellCreatingHandler = ^(NSObject *sender, XuniEventArgs *args)
    {
        FlexGridDetailCellCreatingEventArgs *e    = (FlexGridDetailCellCreatingEventArgs *)args;
        FlexGrid *flex = [[FlexGrid alloc] init];
        flex.itemsSource = [NSMutableArray arrayWithArray: [XuniReflector getProperties:e.row.dataItem]];
        e.view    = flex;
    };
    
    [self.grid.detailProvider.detailCellCreating addHandler:detailCellCreatingHandler forObject:self];
    
    
    self.grid.detailProvider.detailVisibilityMode = FlexGridDetailVisibilityModeExpandMultiple;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
