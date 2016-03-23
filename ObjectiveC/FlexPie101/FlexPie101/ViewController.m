//
//  ViewController.m
//  FlexPie101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITableView *table = (UITableView*)[self.view viewWithTag:1];
    table.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    self.samples = @[NSLocalizedString(@"Getting Started",nil), NSLocalizedString(@"Basic Features",nil),
        NSLocalizedString(@"Legend Sample",nil),
        NSLocalizedString(@"Selection",nil),
        NSLocalizedString(@"Theming",nil),
        NSLocalizedString(@"Export Image",nil)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    UITableView *table = (UITableView*)[self.view viewWithTag:1];
    table.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
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
            [self performSegueWithIdentifier:@"BasicFeaturesSegue" sender:tableView];
            break;
        case 2:
            [self performSegueWithIdentifier:@"LegendAndTitlesSegue" sender:tableView];
            break;
        case 3:
            [self performSegueWithIdentifier:@"SelectionSampleSegue" sender:tableView];
            break;
        case 4:
            [self performSegueWithIdentifier:@"ThemingSegue" sender:tableView];
            break;
        case 5:
            [self performSegueWithIdentifier:@"SnapshotSegue" sender:tableView];
            break;
        default:
            break;
    }
}
@end

