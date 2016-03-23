//
//  CustomDayContentController.m
//  Calendar101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "CustomDayContentController.h"

@interface CustomDayContentController ()

@end

@implementation CustomDayContentController {
    NSArray *weatherIcon;
    NSArray *dotIcon;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Custom Day Content"];
    
    // Do any additional setup after loading the view.
    weatherIcon = [[NSArray alloc] initWithObjects:@"sunny", @"cloudy", @"rainy", @"stomy", nil];
    dotIcon = [[NSArray alloc] initWithObjects:@"blue", @"red", @"green", nil];
    
    XuniCalendar *calendar = [[XuniCalendar alloc] initWithFrame:CGRectZero];
    calendar.delegate = self;
    calendar.dayOfWeekFormat = XuniDayOfWeekFormatDDDD;
    calendar.calendarFont = [UIFont systemFontOfSize:14];
    calendar.todayFont = [UIFont boldSystemFontOfSize:14];
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

- (void)dayOfWeekSlotLoading:(XuniCalendar *)sender args:(XuniCalendarDayOfWeekSlotLoadingEventArgs *)args {
    args.dayOfWeekSlot.font = args.isWeekend ? [UIFont italicSystemFontOfSize:11.0] : [UIFont boldSystemFontOfSize:11.0];
}

- (void)daySlotLoading:(XuniCalendar *)sender args:(XuniCalendarDaySlotLoadingEventArgs *)args {
    if (args.isAdjacentDay) {
        return;
    }
    
    NSInteger day = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:args.date].day;
    CGRect rect = args.daySlot.frame;
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
    
    args.daySlot = imageDaySlot;
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
