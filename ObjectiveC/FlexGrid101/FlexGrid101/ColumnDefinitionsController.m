//
//  ColumnDefinitionsController.m
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "ColumnDefinitionsController.h"
#import "XuniFlexGridKit/XuniFlexGridKit.h"
#import "CustomerData.h"
@interface ColumnDefinitionsController ()

@end

@implementation ColumnDefinitionsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    FlexGrid *flex = [[FlexGrid alloc] init];
    flex.columnHeaderFont = [UIFont boldSystemFontOfSize:flex.columnHeaderFont.pointSize];
    flex.autoGenerateColumns = false;
    FlexColumn *c1 = [[FlexColumn alloc] init];
    c1.binding = @"customerID";
    c1.header = @"ID";
    c1.width = 100;
    FlexColumn *c2 = [[FlexColumn alloc] init];
    c2.binding = @"firstName";
    c2.header = @"First Name";
    FlexColumn *c3 = [[FlexColumn alloc] init];
    c3.binding = @"lastName";
    c3.header = @"Last Name";
    FlexColumn *c4 = [[FlexColumn alloc] init];
    c4.binding = @"orderTotal";
    c4.header = @"Order Total";
    c4.format = @"N1";
    [flex.columns addObject:c1];
    [flex.columns addObject:c2];
    [flex.columns addObject:c3];
    [flex.columns addObject:c4];
    flex.itemsSource = [CustomerData getCustomerData:100];
    flex.isReadOnly = true;
    flex.tag = 1;
    [self.view addSubview:flex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    FlexGrid *flex = (FlexGrid*)[self.view viewWithTag:1];
    
    CGFloat ss = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.intrinsicContentSize.height;
    
    flex.frame = CGRectMake(0, ss, self.view.bounds.size.width, self.view.bounds.size.height - ss);
    [flex setNeedsDisplay];
}
@end