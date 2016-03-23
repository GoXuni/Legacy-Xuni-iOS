//
//  VerticalOrientationController.m
//  Calendar101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "VerticalOrientationController.h"
#import "XuniCalendarKit/XuniCalendarKit.h"

@interface VerticalOrientationController ()

@end

@implementation VerticalOrientationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Vertical Orientation"];
    
    // Do any additional setup after loading the view.
    XuniCalendar *calendar = [[XuniCalendar alloc] initWithFrame:CGRectZero];
    calendar.orientation = XuniCalendarOrientationVertical;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
