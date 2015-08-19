//
//  GettingStartedController.m
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "GettingStartedController.h"
#import "CustomerData.h"
#import "FlexGridKit/FlexGridKit.h"

@interface GettingStartedController ()

@end

@implementation GettingStartedController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    FlexGrid *flex = [[FlexGrid alloc] init];
    flex.isReadOnly = true;
    flex.itemsSource = [CustomerData getCustomerData:100];
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
    flex.frame = CGRectMake(0, 65, self.view.bounds.size.width, self.view.bounds.size.height - 65);
    [flex setNeedsDisplay];
}
@end