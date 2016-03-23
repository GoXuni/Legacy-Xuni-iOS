//
//  CustomSelectionController.m
//  Calendar101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "CustomSelectionController.h"

@interface CustomSelectionController ()

@end

@implementation CustomSelectionController {
    NSDateComponents *components;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Custom Selection"];
    
    // Do any additional setup after loading the view.
    components = [[NSDateComponents alloc] init];
    
    UILabel *stepsLabel = [[UILabel alloc] init];
    stepsLabel.numberOfLines = 3;
    stepsLabel.text = @"Step1: Select a date.\nStep2: Select another date in a different week.\nObserve: The weekend days are not selected.";
    stepsLabel.tag = 2;
    
    XuniCalendar *calendar = [[XuniCalendar alloc] initWithFrame:CGRectZero];
    calendar.delegate = self;
    calendar.maxSelectionCount = 100;
    calendar.tag = 1;
    
    [self.view addSubview:stepsLabel];
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
    UILabel *stepsLabel = (UILabel *)[self.view viewWithTag:2];
    XuniCalendar *calendar = (XuniCalendar *)[self.view viewWithTag:1];
    
    stepsLabel.frame = CGRectMake(0, 55, width, 100);
    calendar.frame = CGRectMake(0, 55 + 100, width, width - 55 -100);
}

- (void)selectionChanging:(XuniCalendar *)sender args:(XuniCalendarSelectionChangedEventArgs *)args {
    
    for (NSDate *date = args.selectedDates.startDate;
         [date compare:args.selectedDates.endDate] == NSOrderedAscending
         || [date compare:args.selectedDates.endDate] == NSOrderedSame;
         date = [self getNextDateOf:date]) {
        
        NSInteger weekday = [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:date] weekday];
        if (weekday == 1 || weekday == 7) {
            [args.selectedDates addExcludedDates:date];
        }
    }
}

- (NSDate *)getNextDateOf:(NSDate *)date {
    [components setDay:1];
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:date options:0];
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
