//
//  EditConfirmationController.m
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "EditConfirmationController.h"
#import "CustomerData.h"
#import "FlexGridKit/FlexGridKit.h"

@interface EditConfirmationController (){
    NSObject *_temp;
}
@end

@implementation EditConfirmationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    FlexGrid *flex = [[FlexGrid alloc] init];
    _temp = [[NSObject alloc] init];
    flex.tag = 1;
    flex.delegate = self;
    flex.isReadOnly = false;
    flex.itemsSource = [CustomerData getCustomerData:100];
    [flex.columns removeObjectAtIndex:1];
    [self.view addSubview:flex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    FlexGrid *flex = (FlexGrid*)[self.view viewWithTag:1];
    flex.frame = CGRectMake(0, 65, self.view.bounds.size.width, self.view.bounds.size.height - 65);
    [flex setNeedsDisplay];
}
-(void) beginningEdit:(FlexCellRangeEventArgs *)args{
    FlexGrid *flex = (FlexGrid*)[self.view viewWithTag:1];
    _temp = [flex.cells getCellDataForRow:args.row inColumn:args.col formatted:false];
    
}
-(void) cellEditEnding:(FlexCellRangeEventArgs *)args{
    FlexGrid *flex = (FlexGrid*)[self.view viewWithTag:1];
    NSString *title = [[NSString alloc] init];
    NSString *message = [[NSString alloc] init];
    title = @"Edit Confirmation";
    message = @"Do you want to commit the edit?";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        [flex.cells setCellData:_temp forRow:args.row inColumn:args.col];
        [flex invalidate];
    }];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:true completion:nil];
}
@end
