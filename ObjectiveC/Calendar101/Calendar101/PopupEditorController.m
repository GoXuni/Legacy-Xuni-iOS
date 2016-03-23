//
//  PopupEditorController.m
//  Calendar101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "PopupEditorController.h"

@interface PopupEditorController ()

@end

@implementation PopupEditorController {
    NSDateFormatter *dateFormatter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Popup Editor"];
    
    // Do any additional setup after loading the view.
    dateFormatter = [[NSDateFormatter alloc] init];
    
    XuniCalendar *calendar = [[XuniCalendar alloc] initWithFrame:CGRectZero];
    calendar.delegate = self;
    calendar.hidden = YES;
    calendar.tag = 1;
    
    UIButton *pickBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [pickBtn setTitle:@"Pick a date" forState:UIControlStateNormal];
    [pickBtn addTarget:self action:@selector(pickBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    pickBtn.tag = 2;
    
    UILabel *dateLabel = [[UILabel alloc] init];
    dateLabel.text = @"";
    dateLabel.tag = 3;
    
    [self.view addSubview:pickBtn];
    [self.view addSubview:dateLabel];
    [self.view addSubview:calendar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGSize size = self.view.bounds.size;
    CGFloat width = fminf(size.width, size.height) / 3 * 2;
    XuniCalendar *calendar = (XuniCalendar *)[self.view viewWithTag:1];
    UIButton *pickBtn = (UIButton *)[self.view viewWithTag:2];
    UILabel *dateLabel = (UILabel *)[self.view viewWithTag:3];
    
    pickBtn.frame = CGRectMake(10, 55 + 10, size.width - 10 - 10, 30);
    dateLabel.frame = CGRectMake((size.width - 280) / 2, 55 + 50, 280, 30);
    calendar.frame = CGRectMake((size.width - width) / 2, 55 + 140, width, width);
}

- (void)pickBtnClick:(id)sender {
    XuniCalendar *calendar = (XuniCalendar *)[self.view viewWithTag:1];
    calendar.hidden = !calendar.hidden;
}

- (void)selectionChanged:(XuniCalendar *)sender args:(XuniCalendarSelectionChangedEventArgs *)args {
    XuniCalendar *calendar = (XuniCalendar *)[self.view viewWithTag:1];
    UILabel *dateLabel = (UILabel *)[self.view viewWithTag:3];
    
    dateFormatter.dateFormat = @"M/d/yyyy";
    dateLabel.text = [NSString stringWithFormat:@"The date %@ was selected.", [dateFormatter stringFromDate:args.selectedDates.startDate]];
    calendar.hidden = YES;
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
