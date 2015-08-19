//
//  GroupingController.m
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "GroupingController.h"
#import "CustomerData.h"
#import "FlexGridKit/FlexGridKit.h"

@interface GroupingController ()

@end

@implementation GroupingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *sortAscendingButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    UIButton *sortDescendingButton = [UIButton buttonWithType:UIButtonTypeSystem];

    [sortAscendingButton setTitle:@"Ascending" forState:UIControlStateNormal];
    [sortDescendingButton setTitle:@"Descending" forState:UIControlStateNormal];
    [sortAscendingButton addTarget:self action:@selector(sortAscendingButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [sortDescendingButton addTarget:self action:@selector(sortDescendingButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [sortAscendingButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [sortAscendingButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    FlexGrid *flex = [[FlexGrid alloc] init];
    flex.isReadOnly = true;
    XuniPropertyGroupDescription *gd = [[XuniPropertyGroupDescription alloc]initWithProperty:@"last"];
    XuniSortDescription *sd =[[XuniSortDescription alloc] initWithProperty:@"last" ascending:true];

    flex.itemsSource = [CustomerData getCustomerData:100];
    [flex.collectionView.groupDescriptions addObject:gd];
    [flex.collectionView.sortDescriptions addObject:sd];
    flex.tag = 1;
    sortAscendingButton.tag = 2;
    sortDescendingButton.tag = 3;
    [self.view addSubview:sortAscendingButton];
    [self.view addSubview:sortDescendingButton];
    [self.view addSubview:flex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    FlexGrid *flex = (FlexGrid*)[self.view viewWithTag:1];
    UIButton *sortAscendingButton = (UIButton*)[self.view viewWithTag:2];
    UIButton *sortDescendingButton = (UIButton*)[self.view viewWithTag:3];
    sortAscendingButton.frame = CGRectMake(0, 60, self.view.bounds.size.width/2, 50);

    sortDescendingButton.frame = CGRectMake(self.view.bounds.size.width/2, 60, self.view.bounds.size.width/2, 50);

    flex.frame = CGRectMake(0, 110, self.view.bounds.size.width, self.view.bounds.size.height-110);
    [flex setNeedsDisplay];
}

-(void)sortAscendingButtonClicked{
    FlexGrid *flex =  (FlexGrid *)[self.view viewWithTag:1];
    [flex.collectionView.sortDescriptions removeAllObjects];
    XuniSortDescription *sd =[[XuniSortDescription alloc] initWithProperty:@"last" ascending:true];
    [flex.collectionView.sortDescriptions addObject:sd];
}

-(void)sortDescendingButtonClicked{
    FlexGrid *flex =  (FlexGrid *)[self.view viewWithTag:1];
    [flex.collectionView.sortDescriptions removeAllObjects];
    XuniSortDescription *sd =[[XuniSortDescription alloc] initWithProperty:@"last" ascending:false];
    [flex.collectionView.sortDescriptions addObject:sd];
}

@end