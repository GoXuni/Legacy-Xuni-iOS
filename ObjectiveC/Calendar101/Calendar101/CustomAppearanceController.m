//
//  CustomAppearanceController.m
//  Calendar101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "CustomAppearanceController.h"
@import XuniCalendarDynamicKit;

@interface CustomAppearanceController ()
@property (weak, nonatomic) IBOutlet XuniCalendar *calendar;

@end

@implementation CustomAppearanceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     // Do any additional setup after loading the view.
    self.calendar.borderColor = [UIColor blackColor];
    self.calendar.borderWidth = 5.0;
    
    self.calendar.headerBackgroundColor = [UIColor colorWithRed:61 / 255.0 green:131 / 255.0 blue:75 / 255.0 alpha:1.0];
    self.calendar.headerTextColor = [UIColor whiteColor];
    self.calendar.headerFont = [UIFont boldSystemFontOfSize:28.0];
    
    self.calendar.dayOfWeekFormat = XuniDayOfWeekFormatD;
    self.calendar.dayOfWeekBackgroundColor = [UIColor colorWithRed:99 / 255.0 green:166 / 255.0 blue:70 / 255.0 alpha:1.0];
    self.calendar.dayOfWeekTextColor = [UIColor whiteColor];
    self.calendar.dayOfWeekFont = [UIFont boldSystemFontOfSize:20.0];
    
    self.calendar.dayBorderColor = [UIColor colorWithRed:242 / 255.0 green:242 / 255.0 blue:242 / 255.0 alpha:1.0];
    self.calendar.dayBorderWidth = 2;
    
    self.calendar.adjacentDayTextColor = [UIColor grayColor];
    self.calendar.calendarFont = [UIFont systemFontOfSize:14.0];
    self.calendar.todayFont = [UIFont italicSystemFontOfSize:16.0];
}

@end
