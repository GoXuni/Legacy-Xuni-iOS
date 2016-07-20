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
    calendar.headerBackgroundColor = [UIColor whiteColor];
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
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
    view.backgroundColor  = [UIColor whiteColor];
    view.userInteractionEnabled = YES;
    view.layer.cornerRadius = 4;
    view.tag = 4;
    
    [self.view addSubview:pickBtn];
    [self.view addSubview:dateLabel];
    [self.view addSubview:view];
    [self.view addSubview:calendar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGSize size = self.view.bounds.size;
    CGFloat width = fminf(size.width, size.height) / 3 * 2;
    XuniCalendar *calendar = (XuniCalendar *)[self.view viewWithTag:1];
    UIButton *pickBtn = (UIButton *)[self.view viewWithTag:2];
    UILabel *dateLabel = (UILabel *)[self.view viewWithTag:3];
    UIView *view = (UIView *)[self.view viewWithTag:4];
    
    pickBtn.frame = CGRectMake(10, 55 + 10, size.width - 10 - 10, 30);
    dateLabel.frame = CGRectMake((size.width - 280) / 2, 55 + 50, 280, 30);
    calendar.frame = CGRectMake((size.width - width) / 2, 55 + 140, width, width);
    view.frame = CGRectMake((size.width - width) / 2 - 4, 55 + 140 - 4, width + 8, width + 8);
}

- (void)pickBtnClick:(id)sender {
    XuniCalendar *calendar = (XuniCalendar *)[self.view viewWithTag:1];
    calendar.hidden = !calendar.hidden;
    if (calendar.hidden == NO) {
        self.view.backgroundColor = [UIColor lightGrayColor];
        self.navigationController.navigationBar.barTintColor = [UIColor lightGrayColor];
    }
    else
    {
        self.view.backgroundColor = [UIColor whiteColor];
        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    }
}

- (void)selectionChanged:(XuniCalendar *)sender selectedDates:(XuniCalendarRange*)selectedDates {
    XuniCalendar *calendar = (XuniCalendar *)[self.view viewWithTag:1];
    UILabel *dateLabel = (UILabel *)[self.view viewWithTag:3];
    
    dateFormatter.dateFormat = @"M/d/yyyy";
    dateLabel.text = [NSString stringWithFormat:@"The date %@ was selected.", [dateFormatter stringFromDate:selectedDates.startDate]];
    calendar.hidden = YES;
    if (calendar.hidden == YES) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    }
}


@end
