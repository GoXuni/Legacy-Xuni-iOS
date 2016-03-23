//
//  CustomHeaderController.m
//  Calendar101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "CustomHeaderController.h"

@interface CustomHeaderController ()

@end

@implementation CustomHeaderController {
    NSArray *viewTypePickerData;
    NSDateFormatter *dateFormatter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Custom Header"];
    
    // Do any additional setup after loading the view.
    viewTypePickerData = [[NSArray alloc] initWithObjects:@"Month View", @"Year View", nil];
    dateFormatter = [[NSDateFormatter alloc] init];
    
    UIPickerView *viewTypePicker = [[UIPickerView alloc] init];
    viewTypePicker.delegate = self;
    viewTypePicker.showsSelectionIndicator = YES;
    viewTypePicker.hidden = false;
    viewTypePicker.tag = 2;
    
    UILabel *dateLabel = [[UILabel alloc] init];
    dateLabel.text = @"";
    dateLabel.tag = 3;
    
    UIButton *todayBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [todayBtn setTitle:@"Today" forState:UIControlStateNormal];
    [todayBtn addTarget:self action:@selector(todayBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    todayBtn.tag = 4;
    
    XuniCalendar *calendar = [[XuniCalendar alloc] initWithFrame:CGRectZero];
    calendar.delegate = self;
    calendar.showHeader = NO;
    calendar.tag = 1;
    
    [self.view addSubview:viewTypePicker];
    [self.view addSubview:dateLabel];
    [self.view addSubview:todayBtn];
    [self.view addSubview:calendar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateDateLabel];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGSize size = self.view.bounds.size;
    CGFloat width = fminf(size.width, size.height);
    XuniCalendar *calendar = (XuniCalendar *)[self.view viewWithTag:1];
    UIPickerView *viewTypePicker = (UIPickerView *)[self.view viewWithTag:2];
    UILabel *dateLabel = (UILabel *)[self.view viewWithTag:3];
    UIButton *todayBtn = (UIButton *)[self.view viewWithTag:4];
    
    viewTypePicker.frame = CGRectMake(0, 55, 150, 120);
    dateLabel.frame = CGRectMake(170, 120, 130, 30);
    todayBtn.frame = CGRectMake(300, 120, 60, 30);
    calendar.frame = CGRectMake(0, 55 + 100, width, width - 55 - 120);
}

- (void)todayBtnClick:(id)sender {
    XuniCalendar *calendar = (XuniCalendar *)[self.view viewWithTag:1];
    calendar.selectedDate = [NSDate date];
    calendar.displayDate = [NSDate date];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [viewTypePickerData count];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    XuniCalendar *calendar = (XuniCalendar *)[self.view viewWithTag:1];
    
    if (pickerView.tag == 2) {
        if (row == 0) {
            calendar.viewMode = XuniCalendarViewModeMonth;
        }
        else if (row == 1) {
            calendar.viewMode = XuniCalendarViewModeYear;
        }
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(pickerView.tag == 2) {
        return [viewTypePickerData objectAtIndex:row];
    }
    else {
        return @"error";
    }
}

- (void)viewModeChanged:(XuniCalendar *)sender {
    [self updateDateLabel];
}

- (void)displayDateChanged:(XuniCalendar *)sender {
    [self updateDateLabel];
}

- (void)updateDateLabel {
    XuniCalendar *calendar = (XuniCalendar *)[self.view viewWithTag:1];
    UILabel *dateLabel = (UILabel *)[self.view viewWithTag:3];
    
    dateFormatter.dateFormat = (calendar.viewMode == XuniCalendarViewModeMonth) ? @"MMMM yyyy" : @"yyyy";
    dateLabel.text = [dateFormatter stringFromDate:calendar.displayDate];
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
