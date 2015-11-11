//
//  CustomerObjectEditor.m
//  FlexGrid101
//
//  Copyright © 2015 GrapeCity. All rights reserved.
//

#import "CustomerObjectEditor.h"
#import "EditingFormController.h"
CustomerObjectEditor* objEdit;

@interface CustomerObjectEditor ()
@property (weak, nonatomic) IBOutlet UITextField *firstNameEdit;
@property (weak, nonatomic) IBOutlet UITextField *secondNameEdit;
@property (weak, nonatomic) IBOutlet UITextField *countryEdit;
@property (weak, nonatomic) IBOutlet UITextField *cityEdit;
@property (weak, nonatomic) IBOutlet UITextField *addressEdit;
@property (weak, nonatomic) IBOutlet UITextField *emailEdit;

@end

@implementation CustomerObjectEditor

-(void) initObject
{
    self.firstNameEdit.text = edited.firstName;
    
    self.secondNameEdit.text = edited.lastName;
    self.countryEdit.text = edited.country;
    self.cityEdit.text = edited.city;
    self.addressEdit.text = edited.address;
    self.emailEdit.text = edited.email;
    
    self.firstNameEdit.placeholder = self.firstNameEdit.text;
    self.secondNameEdit.placeholder = self.secondNameEdit.text;
    self.countryEdit.placeholder = self.countryEdit.text;
    self.cityEdit.placeholder = self.cityEdit.text;
    self.addressEdit.placeholder = self.addressEdit.text;
    self.emailEdit.placeholder = self.emailEdit.text;
}

-(void)tableView:(UITableView *)tableView
willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    objEdit = self;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self tableView:tableView numberOfRowsInSection:indexPath.section]-2)
    {
        [efc cancel];
    } else if (indexPath.row == [self tableView:tableView numberOfRowsInSection:indexPath.section]-3)
    {
        edited.firstName = objEdit.firstNameEdit.text;
        edited.lastName = objEdit.secondNameEdit.text;
        edited.country = objEdit.countryEdit.text;
        edited.city = objEdit.cityEdit.text;
        edited.address = objEdit.addressEdit.text;
        edited.email = objEdit.emailEdit.text;
        [efc confirm];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:false];
}
- (IBAction)endEdit:(id)sender {
    [self resignFirstResponder];
}

#pragma mark - Table view data source

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}*/

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
