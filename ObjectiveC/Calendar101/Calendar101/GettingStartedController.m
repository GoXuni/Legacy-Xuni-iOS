//
//  GettingStartedController.m
//  Calendar101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "GettingStartedController.h"
#import "XuniCalendarKit/XuniCalendarKit.h"

@interface GettingStartedController ()

@end

@implementation GettingStartedController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Getting Started"];
    
    // Do any additional setup after loading the view.
    XuniCalendar *calendar = [[XuniCalendar alloc] initWithFrame:CGRectZero];
    calendar.tag = 1;
    
    [self.view addSubview:calendar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGSize size = self.view.bounds.size;
    CGFloat width = fminf(size.width, size.height);
    XuniCalendar *calendar = (XuniCalendar *)[self.view viewWithTag:1];
    calendar.frame = CGRectMake(0, 75, width, width - 75);
}

@end
