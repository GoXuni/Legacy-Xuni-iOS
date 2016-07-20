//
//  CustomHeaderController.m
//  Calendar101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "CustomHeaderController.h"

@interface CustomHeaderController ()
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSelector;
@property (weak, nonatomic) IBOutlet XuniCalendar *calendar;

@end

@implementation CustomHeaderController {
    NSDateFormatter *dateFormatter;
    BOOL isEnglish;
}

- (IBAction)selectToday:(id)sender {
    self.calendar.selectedDate = [NSDate date];
    self.calendar.displayDate = [NSDate date];
}

- (IBAction)selectMode:(id)sender {
    if (self.modeSelector.selectedSegmentIndex == 0) {
        [self.calendar changeViewModeAsync:XuniCalendarViewModeMonth date:nil];
    }
    else if (self.modeSelector.selectedSegmentIndex == 1) {
        [self.calendar changeViewModeAsync:XuniCalendarViewModeYear date:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    
    NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
    isEnglish = ![language containsString:@"ja"] && ![language containsString:@"zh"];
   
    self.calendar.delegate = self;
    self.calendar.showHeader = NO;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateDateLabel];
}


- (void)viewModeChanged:(XuniCalendar *)sender {
    
    if (self.calendar.viewMode == XuniCalendarViewModeMonth) {
        self.modeSelector.selectedSegmentIndex = 0;
    }
    else if (self.calendar.viewMode == XuniCalendarViewModeYear) {
        self.modeSelector.selectedSegmentIndex = 1;
    }
    
    [self updateDateLabel];
}

- (void)displayDateChanged:(XuniCalendar *)sender {
    [self updateDateLabel];
}

- (void)updateDateLabel {
    XuniCalendar *calendar = self.calendar;
    UILabel *dateLabel = self.dateLabel;
    
    dateFormatter.dateFormat = (calendar.viewMode == XuniCalendarViewModeMonth) ? (isEnglish ? @"MMMM yyyy" : @"yyyy年M月") : @"yyyy";
    dateLabel.text = [dateFormatter stringFromDate:calendar.displayDate];
}


@end
