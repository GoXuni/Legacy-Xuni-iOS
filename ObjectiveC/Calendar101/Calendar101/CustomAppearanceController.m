//
//  CustomAppearanceController.m
//  Calendar101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "CustomAppearanceController.h"
#import "XuniCalendarKit/XuniCalendarKit.h"

@interface CustomAppearanceController ()

@end

@implementation CustomAppearanceController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Custom Appearance"];
    
    // Do any additional setup after loading the view.
    XuniCalendar *calendar = [[XuniCalendar alloc] initWithFrame:CGRectZero];
    calendar.borderColor = [UIColor blackColor];
    calendar.borderWidth = 5.0;
    
    calendar.headerBackgroundColor = [UIColor colorWithRed:61 / 255.0 green:131 / 255.0 blue:75 / 255.0 alpha:1.0];
    calendar.headerTextColor = [UIColor whiteColor];
    calendar.headerFont = [UIFont boldSystemFontOfSize:28.0];
    
    calendar.dayOfWeekFormat = XuniDayOfWeekFormatD;
    calendar.dayOfWeekBackgroundColor = [UIColor colorWithRed:99 / 255.0 green:166 / 255.0 blue:70 / 255.0 alpha:1.0];
    calendar.dayOfWeekTextColor = [UIColor whiteColor];
    calendar.dayOfWeekFont = [UIFont boldSystemFontOfSize:20.0];
    
    calendar.dayBorderColor = [UIColor colorWithRed:242 / 255.0 green:242 / 255.0 blue:242 / 255.0 alpha:1.0];
    calendar.dayBorderWidth = 2;
    
    calendar.adjacentDayTextColor = [UIColor grayColor];
    calendar.calendarFont = [UIFont systemFontOfSize:14.0];
    calendar.todayFont = [UIFont italicSystemFontOfSize:16.0];
    
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
    calendar.frame = CGRectMake(0, 70, width, width - 70);
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
