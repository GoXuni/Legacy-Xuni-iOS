//
//  CustomSelectionController.m
//  Calendar101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "CustomSelectionController.h"

@interface CustomSelectionController ()
@property (weak, nonatomic) IBOutlet XuniCalendar *calendar;

@end

@implementation CustomSelectionController {
    NSDateComponents *components;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Custom Selection"];
    
    // Do any additional setup after loading the view.
    components = [[NSDateComponents alloc] init];
    
    self.calendar.delegate = self;
    self.calendar.maxSelectionCount = 100;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)selectionChanging:(XuniCalendar *)sender selectedDates:(XuniCalendarRange*)selectedDates {
    for (NSDate *date = selectedDates.startDate;
         [date compare:selectedDates.endDate] == NSOrderedAscending
         || [date compare:selectedDates.endDate] == NSOrderedSame;
         date = [self getNextDateOf:date]) {
        
        NSInteger weekday = [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:date] weekday];
        if (weekday == 1 || weekday == 7) {
            [selectedDates addExcludedDates:date];
        }
    }
}

- (NSDate *)getNextDateOf:(NSDate *)date {
    [components setDay:1];
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:date options:0];
}


@end
