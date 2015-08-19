//
//  ColumnDefinitionsController.m
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "ColumnDefinitionsController.h"
#import "FlexGridKit/FlexGridKit.h"
#import "CustomerData.h"
@interface ColumnDefinitionsController ()

@end

@implementation ColumnDefinitionsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    FlexGrid *flex = [[FlexGrid alloc] init];
    flex.autoGenerateColumns = false;
    FlexColumn *c1 = [[FlexColumn alloc] init];
    c1.binding = @"customerID";
    c1.width = 100;
    FlexColumn *c2 = [[FlexColumn alloc] init];
    c2.binding = @"first";
    FlexColumn *c3 = [[FlexColumn alloc] init];
    c3.binding = @"last";
    FlexColumn *c4 = [[FlexColumn alloc] init];
    c4.binding = @"weight";
    c4.format = @"N1";
    [flex.columns addObject:c1];
    [flex.columns addObject:c2];
    [flex.columns addObject:c3];
    [flex.columns addObject:c4];
    flex.itemsSource = [CustomerData getCustomerData:100];
    flex.isReadOnly = true;
    flex.tag = 1;
    [self starSizing:flex];
    [self.view addSubview:flex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)starSizing:(FlexGrid*)g{
    for (int i = 0; i < g.columns.count; i++) {
        FlexColumn *c = [g.columns objectAtIndex:i];
        c.widthType = FlexColumnWidthStar;
        c.width = (i == 0) ? 5 : (i == 3) ? 3 : 4;
    }
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    FlexGrid *flex = (FlexGrid*)[self.view viewWithTag:1];
    flex.frame = CGRectMake(0, 65, self.view.bounds.size.width, self.view.bounds.size.height - 65);
    [flex setNeedsDisplay];
}
@end