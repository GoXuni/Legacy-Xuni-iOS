//
//  ViewController.m
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *table = (UITableView*)[self.view viewWithTag:1];
    table.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    // Do any additional setup after loading the view, typically from a nib.
    self.samples = @[NSLocalizedString(@"Getting Started", nil), NSLocalizedString(@"Column Definitions", nil), NSLocalizedString(@"Selection Modes", nil), NSLocalizedString(@"Editing", nil), NSLocalizedString(@"Custom Cells", nil), NSLocalizedString(@"Grouping", nil), NSLocalizedString(@"Filter", nil), NSLocalizedString(@"Full Text Filter", nil), NSLocalizedString(@"Edit Confirmation", nil), NSLocalizedString(@"Star Sizing", nil), NSLocalizedString(@"Cell Freezing & Merging", nil), NSLocalizedString(@"Conditional Formatting", nil), NSLocalizedString(@"Editing form", nil), NSLocalizedString(@"Column Layout", nil), NSLocalizedString(@"On Demand Loading", nil)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.samples count];
}

-(UITableViewCell *) tableView: (UITableView *)tableview cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *SimpleIdentifier = @"SimpleIdentifier";
    
    UITableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:SimpleIdentifier];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleIdentifier];
    }
    cell.textLabel.text = self.samples[indexPath.row];
    
    return cell;
}

-(void) tableView: (UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self performSegueWithIdentifier:@"GettingStartedSegue" sender:tableView];
            break;
        case 1:
            [self performSegueWithIdentifier:@"ColumnDefinitionsSegue" sender:tableView];
            break;
        case 2:
            [self performSegueWithIdentifier:@"SelectionModesSegue" sender:tableView];
            break;
        case 3:
            [self performSegueWithIdentifier:@"EditingSegue" sender:tableView];
            break;
        case 4:
            [self performSegueWithIdentifier:@"CustomCellsSegue" sender:tableView];
            break;
        case 5:
            [self performSegueWithIdentifier:@"GroupingSegue" sender:tableView];
            break;
        case 6:
            [self performSegueWithIdentifier:@"FilterSegue" sender:tableView];
            break;
        case 7:
            [self performSegueWithIdentifier:@"FullTextFilterSegue" sender:tableView];
            break;
        case 8:
            [self performSegueWithIdentifier:@"EditConfirmationSegue" sender:tableView];
            break;
        case 9:
            [self performSegueWithIdentifier:@"StarSizingSegue" sender:tableView];
            break;
        case 10:
            [self performSegueWithIdentifier:@"FrozenCellsSegue" sender:tableView];
            break;
        case 11:
            [self performSegueWithIdentifier:@"ConditionalFormattingSegue" sender:tableView];
            break;
        case 12:
            [self performSegueWithIdentifier:@"EditingFormSegue" sender:tableView];
            break;
        case 13:
            [self performSegueWithIdentifier:@"ColumnLayoutSegue" sender:tableView];
            break;
        case 14:
            [self performSegueWithIdentifier:@"OnDemandSegue" sender:tableView];
            break;
        default:
            break;
    }
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    UITableView *table = (UITableView*)[self.view viewWithTag:1];
    table.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
}
@end
