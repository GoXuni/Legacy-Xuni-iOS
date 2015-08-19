//
//  ViewController.m
//  FlexChart101
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
    self.samples = @[@"Getting Started", @"Basic Chart Types", @"Mixed Chart Types", @"Financial Chart", @"Bubble Chart", @"Custom Tooltips", @"Theming", @"Styling Series", @"Customizing Axes", @"Legends and Titles", @"Selection Modes", @"Toggle Series", @"Animation Options", @"Dynamic Charts", @"Zooming and Scrolling", @"Hit Test", @"Snapshot", @"Multiple Axes", @"Data Label"];
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
            [self performSegueWithIdentifier:@"BasicChartTypesSegue" sender:tableView];
            break;
        case 2:
            [self performSegueWithIdentifier:@"MixedChartTypesSegue" sender:tableView];
            break;
        case 3:
            [self performSegueWithIdentifier:@"FinancialChartSegue" sender:tableView];
            break;
        case 4:
            [self performSegueWithIdentifier:@"BubbleChartSegue" sender:tableView];
            break;
        case 5:
            [self performSegueWithIdentifier:@"CustomTooltipsSegue" sender:tableView];
            break;
        case 6:
            [self performSegueWithIdentifier:@"ThemingSegue" sender:tableView];
            break;
        case 7:
            [self performSegueWithIdentifier:@"StylingSeriesSegue" sender:tableView];
            break;
        case 8:
            [self performSegueWithIdentifier:@"CustomizingAxesSegue" sender:tableView];
            break;
        case 9:
            [self performSegueWithIdentifier:@"LegendsAndTitlesSegue" sender:tableView];
            break;
        case 10:
            [self performSegueWithIdentifier:@"SelectionModesSegue" sender:tableView];
            break;
        case 11:
            [self performSegueWithIdentifier:@"ToggleSeriesSegue" sender:tableView];
            break;
        case 12:
            [self performSegueWithIdentifier:@"AnimationOptionsSegue" sender:tableView];
            break;
        case 13:
            [self performSegueWithIdentifier:@"DynamicChartsSegue" sender:tableView];
            break;
        case 14:
            [self performSegueWithIdentifier:@"ZoomingAndScrollingSegue" sender:tableView];
            break;
        case 15:
            [self performSegueWithIdentifier:@"HitTestSegue" sender:tableView];
            break;
        case 16:
            [self performSegueWithIdentifier:@"SnapshotSegue" sender:tableView];
            break;
        case 17:
            [self performSegueWithIdentifier:@"MultipleAxesSegue" sender:tableView];
            break;
        case 18:
            [self performSegueWithIdentifier:@"DataLabelSegue" sender:tableView];
            break;
        default:
            break;
    }
}
@end