//
//  CustomDayContentController.m
//  Calendar101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "CustomDayContentController.h"

@interface CustomDayContentController ()
@property (weak, nonatomic) IBOutlet XuniCalendar *calendar;

@end

@implementation CustomDayContentController {
    NSArray *weatherIcon;
    NSArray *dotIcon;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    weatherIcon = [[NSArray alloc] initWithObjects:@"sunny", @"cloudy", @"rainy", @"stomy", nil];
    dotIcon = [[NSArray alloc] initWithObjects:@"blue", @"red", @"green", nil];
    
    self.calendar.delegate = self;
    self.calendar.dayOfWeekFormat = XuniDayOfWeekFormatDDDD;
    self.calendar.calendarFont = [UIFont systemFontOfSize:14];
    self.calendar.todayFont = [UIFont boldSystemFontOfSize:14];

}

- (void)dayOfWeekSlotLoading:(XuniCalendar *)sender dayOfWeek:(XuniDayOfWeek)dayOfWeek isWeekend:(BOOL)isWeekend dayOfWeekSlot:(UILabel*)dayOfWeekSlot {
    dayOfWeekSlot.font = isWeekend ? [UIFont italicSystemFontOfSize:11.0] : [UIFont boldSystemFontOfSize:11.0];
}

- (XuniCalendarDaySlotBase*)daySlotLoading:(XuniCalendar *)sender date:(NSDate*)date isAdjacentDay:(BOOL)isAdjacentDay daySlot:(XuniCalendarDaySlotBase*)daySlot {
    if (isAdjacentDay) {
        return daySlot;
    }
    
    NSInteger day = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:date].day;
    CGRect rect = daySlot.frame;
    CGSize size = rect.size;
    CGRect rect1, rect2;
    XuniCalendarImageDaySlot *imageDaySlot = [[XuniCalendarImageDaySlot alloc] initWithCalendar:sender frame:rect];
    
    if (day >= 14 && day <= 23) {
        rect1 = CGRectMake(0, 0, size.height / 4, size.height / 4);
        rect2 = CGRectMake(size.width / 4, size.height / 5 * 2, size.width / 2, size.height / 2);
        
        imageDaySlot.dayTextRect = rect1;
        imageDaySlot.dayFont = [UIFont systemFontOfSize:9.0];
        imageDaySlot.imageRect = rect2;
        imageDaySlot.imageSource = [UIImage imageNamed:[weatherIcon objectAtIndex:(day % 4)]];
    }
    else {
        rect1 = CGRectMake(0, 0, size.width, size.height / 6 * 4);
        rect2 = CGRectMake(size.width / 2 - 6 / 2, size.height / 6 * 4, 6, 6);
        
        imageDaySlot.dayTextRect = rect1;
        imageDaySlot.imageRect = rect2;
        imageDaySlot.imageSource = [UIImage imageNamed:[dotIcon objectAtIndex:(day % 3)]];
    }
    
    return imageDaySlot;
}

@end
