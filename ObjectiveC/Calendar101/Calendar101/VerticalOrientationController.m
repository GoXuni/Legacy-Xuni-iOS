//
//  VerticalOrientationController.m
//  Calendar101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "VerticalOrientationController.h"
@import XuniCalendarDynamicKit;

@interface VerticalOrientationController ()
@property (weak, nonatomic) IBOutlet XuniCalendar *calendar;

@end

@implementation VerticalOrientationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.calendar.orientation = XuniCalendarOrientationVertical;
}

@end
