//
//  CustomerObjectEditor.m
//  FlexGrid101
//
//  Copyright © 2015 GrapeCity. All rights reserved.
//

#import "CustomerObjectEditor.h"
#import "EditingFormController.h"

@interface CustomerObjectEditor ()
@property (weak, nonatomic) IBOutlet UITextField *firstNameEdit;
@property (weak, nonatomic) IBOutlet UITextField *secondNameEdit;
@property (weak, nonatomic) IBOutlet UITextField *countryEdit;
@property (weak, nonatomic) IBOutlet UITextField *cityEdit;
@property (weak, nonatomic) IBOutlet UITextField *addressEdit;
@property (weak, nonatomic) IBOutlet UITextField *emailEdit;
@end

@implementation CustomerObjectEditor

- (void)initObject {
    EditingFormController* efc = (EditingFormController*)self.parentViewController;
    
    self.firstNameEdit.text = efc.edited.firstName;

    self.secondNameEdit.text = efc.edited.lastName;
    self.countryEdit.text    = efc.edited.country;
    self.cityEdit.text       = efc.edited.city;
    self.addressEdit.text    = efc.edited.address;
    self.emailEdit.text      = efc.edited.email;

    self.firstNameEdit.placeholder  = self.firstNameEdit.text;
    self.secondNameEdit.placeholder = self.secondNameEdit.text;
    self.countryEdit.placeholder    = self.countryEdit.text;
    self.cityEdit.placeholder       = self.cityEdit.text;
    self.addressEdit.placeholder    = self.addressEdit.text;
    self.emailEdit.placeholder      = self.emailEdit.text;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell setBackgroundColor:[UIColor clearColor]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EditingFormController* efc = (EditingFormController*)self.parentViewController;
    
    if (indexPath.row == [self tableView:tableView numberOfRowsInSection:indexPath.section]-2) {
        [efc cancel];
    } else if (indexPath.row == [self tableView:tableView numberOfRowsInSection:indexPath.section]-3) {
        efc.edited.firstName = self.firstNameEdit.text;
        efc.edited.lastName  = self.secondNameEdit.text;
        efc.edited.country   = self.countryEdit.text;
        efc.edited.city      = self.cityEdit.text;
        efc.edited.address   = self.addressEdit.text;
        efc.edited.email     = self.emailEdit.text;
        [efc confirm];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:false];
}

- (IBAction)endEdit:(id)sender {
    [self resignFirstResponder];
}

@end
