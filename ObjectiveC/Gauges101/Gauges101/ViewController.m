//
//  ViewController.m
//  Gauages101
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
    self.samples = @[@"Getting Started", @"Displaying Values", @"Using Ranges", @"Automatic Scaling", @"Direction", @"Bullet Graph", @"Animation", @"Snapshot"];
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
            [self performSegueWithIdentifier:@"DisplayingValuesSegue" sender:tableView];
            break;
        case 2:
            [self performSegueWithIdentifier:@"UsingRangesSegue" sender:tableView];
            break;
        case 3:
            [self performSegueWithIdentifier:@"AutomaticScalingSegue" sender:tableView];
            break;
        case 4:
            [self performSegueWithIdentifier:@"DirectionSegue" sender:tableView];
            break;
        case 5:
            [self performSegueWithIdentifier:@"BulletGraphSegue" sender:tableView];
            break;
        case 6:
            [self performSegueWithIdentifier:@"CustomAnimationSegue" sender:tableView];
            break;
        case 7:
            [self performSegueWithIdentifier:@"SnapshotSegue" sender:tableView];
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
