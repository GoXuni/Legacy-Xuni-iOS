//
//  EditConfirmationController.m
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "EditConfirmationController.h"
#import "CustomerData.h"
#import "XuniFlexGridDynamicKit/XuniFlexGridDynamicKit.h"

@interface EditConfirmationController ()
@property (weak, nonatomic) IBOutlet FlexGrid *flex;
@end

@implementation EditConfirmationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.flex.isReadOnly = false;
    
    self.flex.columnHeaderFont = [UIFont boldSystemFontOfSize:self.flex.columnHeaderFont.pointSize];
    self.flex.autoGenerateColumns = false;
    
    GridColumn *identifier = [[GridColumn alloc] init];
    identifier.binding = @"customerID";
    identifier.isReadOnly = true;
    identifier.widthType = GridColumnWidthPixel;
    identifier.width = 100;
    [self.flex.columns addObject:identifier];
    
    GridColumn *firstName = [[GridColumn alloc] init];
    firstName.binding = @"firstName";
    [self.flex.columns addObject:firstName];
    
    GridColumn *lastName = [[GridColumn alloc] init];
    lastName.binding = @"lastName";
    [self.flex.columns addObject:lastName];
    
    GridColumn *address = [[GridColumn alloc] init];
    address.binding = @"address";
    [self.flex.columns addObject:address];
    
    GridColumn *city = [[GridColumn alloc] init];
    city.binding = @"city";
    [self.flex.columns addObject:city];
    
    GridColumn *postalCode = [[GridColumn alloc] init];
    postalCode.binding = @"postalCode";
    [self.flex.columns addObject:postalCode];
    
    GridColumn *active = [[GridColumn alloc] init];
    active.binding = @"active";
    active.widthType = GridColumnWidthPixel;
    active.width = 70;
    [self.flex.columns addObject:active];
    
    self.flex.itemsSource = [CustomerData getCustomerData:100];
    
    [self.flex.flexGridCellEditEnding addHandler:^(XuniEventContainer<GridCellRangeEventArgs *> *eventContainer) {
        NSObject* activeEditorValue = self.flex.activeEditorValue;
        
        if(activeEditorValue == nil) activeEditorValue = @"";
        
        if([[self.flex.cells getCellDataForRow:eventContainer.eventArgs.row inColumn:eventContainer.eventArgs.col formatted:false] isEqual:activeEditorValue])
        {
            eventContainer.eventArgs.cancel = true;
            return;
        }
        
        NSObject* prev = [self.flex.cells getCellDataForRow:eventContainer.eventArgs.row inColumn:eventContainer.eventArgs.col formatted:false];
        
        NSString *title = [[NSString alloc] init];
        NSString *message = [[NSString alloc] init];
        title = NSLocalizedString(@"Edit Confirmation", nil);
        message = NSLocalizedString(@"Do you want to commit the edit?", nil);
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Ok", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
            [self.flex.cells setCellData:prev forRow:eventContainer.eventArgs.row inColumn:eventContainer.eventArgs.col];
        }];
        
        
        [alertController addAction:okAction];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:true completion:nil];
        
        eventContainer.eventArgs.cancel = false;

    } forObject:self];
}


@end
