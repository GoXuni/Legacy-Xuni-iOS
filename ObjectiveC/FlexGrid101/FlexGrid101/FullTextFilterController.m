//
//  FullTextFilterController.m
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "FullTextFilterController.h"
#import "CustomerData.h"
#import "FlexGridKit/FlexGridKit.h"


@interface FullTextFilterController ()

@end

@implementation FullTextFilterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITextField *filterField = [[UITextField alloc] init];
    filterField.delegate = self;
    filterField.text = @"Enter text to Filter";
    filterField.returnKeyType = UIReturnKeyDone;
    filterField.keyboardType = UIKeyboardTypeDefault;
    filterField.backgroundColor = [UIColor lightGrayColor];

    FlexGrid *flex = [[FlexGrid alloc] init];
    flex.isReadOnly = true;
    flex.itemsSource = [CustomerData getCustomerData:100];
    flex.tag = 1;
    filterField.tag = 2;
    [self.view addSubview:flex];
    [self.view addSubview:filterField];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    FlexGrid *flex = (FlexGrid*)[self.view viewWithTag:1];
    UITextField *filterField = (UITextField*)[self.view viewWithTag:2];

    filterField.frame = CGRectMake(0, 65, self.view.bounds.size.width, 50);
    flex.frame = CGRectMake(0, 115, self.view.bounds.size.width, self.view.bounds.size.height-115);
    [flex setNeedsDisplay];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return true;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [textField selectAll:nil];
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return true;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    FlexGrid *flex =  (FlexGrid *)[self.view viewWithTag:1];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"M/d/yy"];
    flex.collectionView.filter = ^ BOOL (NSObject *item){
        CustomerData *d = (CustomerData*)item;

        if ([[NSString stringWithFormat:@"%@", d.customerID] isEqualToString:textField.text]) {
            return true;
        }
        else if ([[NSString stringWithFormat:@"%@", d.countryID] isEqualToString:textField.text]) {
            return true;
        }
        else if ([[NSString stringWithFormat:@"%@", d.weight] isEqualToString:textField.text]) {
            return true;
        }
        else if ([d.first isEqualToString:textField.text]) {
            return true;
        }
        else if ([d.last isEqualToString:textField.text])
        {
            return true;
        }
        else if ([d.father isEqualToString:textField.text]){
            return true;
        }
        else if ([d.brother isEqualToString:textField.text]){
            return true;
        }
        else if ([d.cousin isEqualToString:textField.text]){
            return true;
        }
        else if ([[dateFormat stringFromDate:d.hireDate] isEqualToString:textField.text]) {
            return true;
        }
        else {
            return false;
        }
    };
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
}

@end
