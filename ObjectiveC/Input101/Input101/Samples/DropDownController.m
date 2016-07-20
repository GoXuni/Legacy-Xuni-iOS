//
//  DropDownController.m
//  Input101
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import "DropDownController.h"
@import XuniInputDynamicKit;
@import XuniCalendarDynamicKit;

@interface DropDownController ()<XuniDropDownDelegate,XuniCalendarDelegate>
@property (weak, nonatomic) IBOutlet XuniDropDown *dropdown;

@end

@implementation DropDownController
{
    XuniMaskedTextField *_field;
    XuniDropDownView *_dropdownView;
    XuniCalendar *_calendar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"DropDown";
    
    // Do any additional setup after loading the view.
    _dropdown.buttonColor = [UIColor lightGrayColor];
    _dropdown.dropDownHeight = 300;
    _dropdown.dropDownWidth = _dropdown.frame.size.width + 30;
    _dropdown.dropDownDirection = XuniDropDownDirectionForceBelow;
    _dropdown.isAnimated = YES;
    
    _field = [[XuniMaskedTextField alloc] init];
    _field.mask = @"00/00/0000";
    _field.borderStyle = UITextBorderStyleNone;
    _dropdown.header = _field;
    
    _calendar = [[XuniCalendar alloc] init];
    _calendar.delegate = self;
    _dropdown.dropDownView = _calendar;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)selectionChanged:(XuniCalendar *)sender selectedDates:(XuniCalendarRange*)selectedDates
{
     NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc]init];
    _dateFormatter.dateFormat = @"MM/dd/yyyy";
    _field.text = [_dateFormatter stringFromDate:((XuniCalendar *)sender).selectedDate];
    _dropdown.isDropDownOpen = NO;
}

@end
