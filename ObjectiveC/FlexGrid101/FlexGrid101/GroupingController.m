//
//  GroupingController.m
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "GroupingController.h"
#import "CustomerData.h"
#import "XuniFlexGridKit/XuniFlexGridKit.h"

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
    
    flex.autoGenerateColumns = false;
    FlexColumn *c1 = [[FlexColumn alloc] init];
    c1.binding = @"firstName";
    c1.header = @"First Name";
    
    c1.width = 100;
    FlexColumn *c2 = [[FlexColumn alloc] init];
    c2.binding = @"lastName";
    c2.header = @"Last Name";
    FlexColumn *c3 = [[FlexColumn alloc] init];
    c3.binding = @"orderTotal";
    c3.header = @"Order Total";
    c3.format = @"C";
    c3.aggregate = XuniAggregateSum;
    [flex.columns addObject:c1];
    [flex.columns addObject:c2];
    [flex.columns addObject:c3];
    
    
    XuniPropertyGroupDescription *gd = [[XuniPropertyGroupDescription alloc]initWithProperty:@"country"];
    XuniSortDescription *sd =[[XuniSortDescription alloc] initWithProperty:@"country" ascending:true];

    flex.itemsSource = [CustomerData getCustomerData:100];
    [flex.collectionView.groupDescriptions addObject:gd];
    [flex.collectionView.sortDescriptions addObject:sd];
    flex.tag = 1;
    sortAscendingButton.tag = 2;
    sortDescendingButton.tag = 3;
    [self.view addSubview:sortAscendingButton];
    [self.view addSubview:sortDescendingButton];
    [self starSizing:flex];
    [self.view addSubview:flex];
}

-(void)starSizing:(FlexGrid*)g{
    for (int i = 0; i < g.columns.count; i++) {
        FlexColumn *c = [g.columns objectAtIndex:i];
        c.widthType = FlexColumnWidthStar;
        c.width = (i == 0) ? 3 : (i == 3) ? 3 : 4;
    }
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
    XuniSortDescription *sd =[[XuniSortDescription alloc] initWithProperty:@"country" ascending:true];
    [flex.collectionView.sortDescriptions addObject:sd];
}

-(void)sortDescendingButtonClicked{
    FlexGrid *flex =  (FlexGrid *)[self.view viewWithTag:1];
    [flex.collectionView.sortDescriptions removeAllObjects];
    XuniSortDescription *sd =[[XuniSortDescription alloc] initWithProperty:@"country" ascending:false];
    [flex.collectionView.sortDescriptions addObject:sd];
}

@end