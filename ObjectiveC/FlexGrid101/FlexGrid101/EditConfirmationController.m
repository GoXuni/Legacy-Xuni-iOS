//
//  EditConfirmationController.m
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "EditConfirmationController.h"
#import "CustomerData.h"
#import "XuniFlexGridKit/XuniFlexGridKit.h"

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

-(bool)beginningEdit:(FlexGrid *)sender panel:(FlexGridPanel *)panel forRange:(FlexCellRange *)range{
    FlexGrid *flex = (FlexGrid*)[self.view viewWithTag:1];
    _temp = [flex.cells getCellDataForRow:range.row inColumn:range.col formatted:false];
    return false;
}

-(bool)cellEditEnding:(FlexGrid *)sender panel:(FlexGridPanel *)panel forRange:(FlexCellRange *)range cancel:(BOOL)cancel{
    dispatch_async(dispatch_get_main_queue(), ^{
        
    FlexGrid *flex = (FlexGrid*)[self.view viewWithTag:1];
    
    if([[flex.cells getCellDataForRow:range.row inColumn:range.col formatted:false] isEqual:_temp])
    {
        return;
    }
    
    NSString *title = [[NSString alloc] init];
    NSString *message = [[NSString alloc] init];
    title = NSLocalizedString(@"Edit Confirmation", nil);
    message = NSLocalizedString(@"Do you want to commit the edit?", nil);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Ok", nil) style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        [flex.cells setCellData:_temp forRow:range.row inColumn:range.col];
        [flex invalidate];
    }];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:true completion:nil];
        
    });
    
    return false;
}
@end
