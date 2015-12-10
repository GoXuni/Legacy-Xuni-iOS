//
//  MasterViewController.m
//  XuniExplorer
//
//  Created by kelley.ricker on 10/15/15.
//  Copyright © 2015 GrapeCity. All rights reserved.
//

#import "MasterViewController.h"
#import "SalesDashboardController.h"
#import "SalesDashboardTabletController.h"
#import "XuniWeatherController.h"
#import "SnapshotController.h"
#import "OnDemandController.h"
#import "FinancialDataController.h"
#import "EmployeeDataController.h"

@interface MasterViewController (){
    //handles segue to about if user changes orientation without selecting option
    //to populate detail section with about
    _Bool horizontalIpadFlag;
}
@property (strong, nonatomic) IBOutlet UITableView *table;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    horizontalIpadFlag = false;
    _table.backgroundColor = [UIColor colorWithRed:.9333 green:.9529 blue:.9765 alpha:1];
    //custom view for navbar title with image
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Elogo.png"]];
    img.frame = CGRectMake(0, 0, 45, 34);
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(50, 6, 150, 22)];
    title.text = @"Samples";
    title.font = [UIFont systemFontOfSize:22];
    title.textColor = [UIColor colorWithRed:.3843 green:.3137 blue:.5020 alpha:1];
    [view addSubview:img];
    [view addSubview:title];
    self.navigationItem.titleView = view;
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:.9333 green:.9529 blue:.9765 alpha:1]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:.3843 green:.3137 blue:.5020 alpha:1]}];
    [[UINavigationBar appearance]  setTranslucent:false];
    [self setUpSampleLists];
    if(horizontalIpadFlag == false){
        if(UI_USER_INTERFACE_IDIOM()  == UIUserInterfaceIdiomPad){
            horizontalIpadFlag = true;
            [self performSegueWithIdentifier:@"FinancialDataSegue" sender:self];
        }
    }
    
}
-(void)setUpSampleLists{
    //arrays that hold sample lists
    NSArray *performanceArray = [[NSMutableArray alloc]init];
    NSArray *deviceFeaturesArray = [[NSMutableArray alloc]init];
    NSArray *debugArray = [[NSMutableArray alloc]init];

    
    NSMutableDictionary *sampleDictionary = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *descriptions = [[NSMutableDictionary alloc] init];
    NSMutableArray *keys = [[NSMutableArray alloc] init];
    //these are the sample categories with lists of samples
    performanceArray =  @[@"Financial Data", @"Employee Data"];
    
    deviceFeaturesArray =  @[@"Image capture", @"Dashboard"];
    
    debugArray =  @[@"Xuni Weather", @"On Demand"];
    
    [sampleDictionary setObject:performanceArray forKey:@"Performance and Feel"];
    [sampleDictionary setObject:deviceFeaturesArray forKey:@"Device Features"];
    [sampleDictionary setObject:debugArray forKey:@"Development and Debugging"];

    [keys addObject:@"Performance and Feel"];
    [keys addObject:@"Device Features"];
    [keys addObject:@"Development and Debugging"];

    [descriptions setObject:@"Filtering, Cell Formatting, Custom Cells" forKey:@"Financial Data"];
    [descriptions setObject:@"Custom Editors, Datamapping, Grouping" forKey:@"Employee Data"];
    [descriptions setObject:@"Save chart image to camera roll" forKey:@"Image capture"];
    [descriptions setObject:@"Different layouts for phone and tablet" forKey:@"Dashboard"];
    [descriptions setObject:@"Debugging parsed Json" forKey:@"Xuni Weather"];
    [descriptions setObject:@"Profiling App performance" forKey:@"On Demand"];
    
    self.sampleKeys = keys;
    self.sampleList = sampleDictionary;
    self.sampleDescriptions = descriptions;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:true];
    if(horizontalIpadFlag == false){
        if(UI_USER_INTERFACE_IDIOM()  == UIUserInterfaceIdiomPad){
            //if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
                horizontalIpadFlag = true;
                [self performSegueWithIdentifier:@"FinancialDataSegue" sender:self];
            //}
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.sampleKeys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key =[self.sampleKeys objectAtIndex:section];
    NSArray *contents = [[self sampleList] objectForKey:key];
    NSInteger rows = [contents count];
    
    return rows;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, tableView.frame.size.height)];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, tableView.frame.size.width - 5, 22)];
    title.text = [self.sampleKeys objectAtIndex:section];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        title.font = [UIFont systemFontOfSize:19];
    }
    else{
        title.font = [UIFont systemFontOfSize:18];
    }
    [view addSubview:title];
    view.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
    return view;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *key =[self.sampleKeys objectAtIndex:section];
    return key;
}

-(UITableViewCell *) tableView: (UITableView *)tableview cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *SimpleIdentifier = @"SimpleIdentifier";
    
    UITableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:SimpleIdentifier];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SimpleIdentifier];
    }
    NSString *key =[self.sampleKeys objectAtIndex:[indexPath section]];
    NSArray *contents = [self.sampleList objectForKey:key];
    NSString *contentsForCell = [contents objectAtIndex:[indexPath row]];
    cell.textLabel.text = contentsForCell;
    cell.backgroundColor = [UIColor colorWithRed:.9333 green:.9529 blue:.9765 alpha:1];
    cell.textLabel.textColor = [UIColor colorWithRed:.3843 green:.3137 blue:.5020 alpha:1];
    cell.detailTextLabel.text = [self.sampleDescriptions objectForKey:contentsForCell];
    cell.detailTextLabel.numberOfLines = 0;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        cell.textLabel.font = [UIFont systemFontOfSize:18];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
    }
    else{
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
    }
    
    [cell.detailTextLabel sizeToFit];
    return cell;
}
-(void) tableView: (UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //changes once a user goes to sample
    horizontalIpadFlag = true;
    switch (indexPath.section) {
        case 0: //Perfomance
            switch (indexPath.row) {
                case 0:
                    [self performSegueWithIdentifier:@"FinancialDataSegue" sender:tableView];
                    break;
                case 1:
                    [self performSegueWithIdentifier:@"EmployeeDataSegue" sender:tableView];
                    break;
                default:
                    break;
            }
            break;
        case 1: //Device
            switch (indexPath.row) {
                case 0:
                    [self performSegueWithIdentifier:@"ImageCaptureSegue" sender:tableView];
                    break;
                case 1:
                    if(UI_USER_INTERFACE_IDIOM()  == UIUserInterfaceIdiomPad){
                        [self performSegueWithIdentifier:@"SalesDashboardTabletSegue" sender:tableView];
                    }
                    else{
                        [self performSegueWithIdentifier:@"SalesDashboardSegue" sender:tableView];
                    }
                    break;
                default:
                    break;
            }
            break;
        case 2: //Debug
            switch (indexPath.row) {
                case 0:
                    [self performSegueWithIdentifier:@"XuniWeatherSegue" sender:tableView];
                    break;
                case 1:
                    [self performSegueWithIdentifier:@"OnDemandSegue" sender:tableView];
                    break;
                default:
                    break;
            }
            break;
    }
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"SalesDashboardSegue"]) {
        SalesDashboardController *controller = (SalesDashboardController *)[segue destinationViewController];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = true;
        return;
        
    }
    else if ([[segue identifier] isEqualToString:@"SalesDashboardTabletSegue"]){
        SalesDashboardTabletController *controller = (SalesDashboardTabletController *)[segue destinationViewController];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = true;
        return;
    }
    else if ([[segue identifier] isEqualToString:@"XuniWeatherSegue"]){
        XuniWeatherController *controller = (XuniWeatherController *)[segue destinationViewController];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = true;
        return;
    }
    else if ([[segue identifier] isEqualToString:@"FinancialDataSegue"]){
        FinancialDataController *controller = (FinancialDataController *)[segue destinationViewController];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = true;
        return;
    }
    else if ([[segue identifier] isEqualToString:@"EmployeeDataSegue"]){
        EmployeeDataController *controller = (EmployeeDataController *)[segue destinationViewController];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = true;
        return;
    }
    else if ([[segue identifier] isEqualToString:@"ImageCaptureSegue"]){
        SnapshotController *controller = (SnapshotController *)[segue destinationViewController];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = true;
        return;
    }
    else if ([[segue identifier] isEqualToString:@"OnDemandSegue"]){
        OnDemandController *controller = (OnDemandController *)[segue destinationViewController];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = true;
        return;
    }
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
