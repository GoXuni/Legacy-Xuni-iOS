//
//  ViewController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController {
    NSArray* _samplesTitle;
    NSArray* _samplesDescription;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITableView *table = (UITableView*)[self.view viewWithTag:1];
    table.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    _samplesTitle = @[@"Getting Started",
                     @"Basic Chart Types",
                     @"Mixed Chart Types",
                     @"Financial Chart",
                     @"Bubble Chart",
                     @"Custom Tooltips",
                     @"Data Labels",
                     @"Line Marker",
                     @"Customizing Axes",
                     @"Multiple Axes",
                     @"Legend and Titles",
                     @"Conditional Formatting",
                     @"Custom Plot Elements",
                     @"Selection Modes",
                     @"Toggle Series",
                     @"Load Animation Mode",
                     @"Update Animation",
                     @"Dynamic Charts",
                     @"Hit Test",
                     @"Scrolling",
                     @"Zooming and Scrolling",
                     @"Theming",
                     @"Styling Series",
                     @"Export Image"];
    
    _samplesDescription = @[@"Shows a simple chart with tooltips.",
                            @"Shows the basic chart types and stacking options.",
                            @"Shows a composite chart.",
                            @"Shows stock data in a candle chart.",
                            @"Shows a bubble chart.",
                            @"Shows a customized tooltip.",
                            @"Shows a simple chart with static data labels.",
                            @"Shows a moveable marker on top of the chart.",
                            @"Shows customized axis style and label format.",
                            @"Shows a chart with mutiple Y axes.",
                            @"Shows basic chart headers and axis titles.",
                            @"Shows conditional formatting by customizing plot elements.",
                            @"Shows how to fully customize plot elements.",
                            @"Shows the different selection modes.",
                            @"Shows the ability to toggle a series visibility.",
                            @"Shows animation modes when data is loaded.",
                            @"Shows animation when data is updated.",
                            @"Shows a dynamic, “live” chart.",
                            @"Demonstrates use of the FlexChart's hitTest method.",
                            @"Shows a chart with panning (or scrolling) along the axes.",
                            @"Shows stretch zoom-out and pinch zoom-in gestures.",
                            @"Shows the built-in palettes.",
                            @"Shows custom series styling.",
                            @"Shows how to export an image of FlexChart."];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    UITableView *table = (UITableView*)[self.view viewWithTag:1];
    table.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_samplesTitle count];
}

- (UITableViewCell *)tableView:(UITableView *)tableview cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *SimpleIdentifier = @"SimpleIdentifier";
    UITableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:SimpleIdentifier];
    NSString *imageName = [_samplesTitle[indexPath.row] stringByReplacingOccurrencesOfString:@" " withString:@""];
    imageName = [NSString stringWithFormat:@"%@%@", imageName.lowercaseString, @".png"];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SimpleIdentifier];
    }
    
    cell.textLabel.text = _samplesTitle[indexPath.row];
    cell.textLabel.textColor = [UIColor colorWithRed:176.0 / 255 green:15.0 / 255 blue:80.0 / 255 alpha:1];
    cell.detailTextLabel.text = _samplesDescription[indexPath.row];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    cell.imageView.image = [UIImage imageNamed:imageName];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
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
            [self performSegueWithIdentifier:@"DataLabelSegue" sender:tableView];
            break;
        case 7:
            [self performSegueWithIdentifier:@"CustomLineMarkerSegue" sender:tableView];
            break;
        case 8:
            [self performSegueWithIdentifier:@"CustomizingAxesSegue" sender:tableView];
            break;
        case 9:
            [self performSegueWithIdentifier:@"MultipleAxesSegue" sender:tableView];
            break;
        case 10:
            [self performSegueWithIdentifier:@"LegendsAndTitlesSegue" sender:tableView];
            break;
        case 11:
            [self performSegueWithIdentifier:@"ConditionalFormattingSegue" sender:tableView];
            break;
        case 12:
            [self performSegueWithIdentifier:@"CustomPlotElementsSegue" sender:tableView];
            break;
        case 13:
            [self performSegueWithIdentifier:@"SelectionModesSegue" sender:tableView];
            break;
        case 14:
            [self performSegueWithIdentifier:@"ToggleSeriesSegue" sender:tableView];
            break;
        case 15:
            [self performSegueWithIdentifier:@"LoadAnimationSegue" sender:tableView];
            break;
        case 16:
            [self performSegueWithIdentifier:@"UpdateAnimationSegue" sender:tableView];
            break;
        case 17:
            [self performSegueWithIdentifier:@"DynamicChartsSegue" sender:tableView];
            break;
        case 18:
            [self performSegueWithIdentifier:@"HitTestSegue" sender:tableView];
            break;
        case 19:
            [self performSegueWithIdentifier:@"ScrollingSegue" sender:tableView];
            break;
        case 20:
            [self performSegueWithIdentifier:@"ZoomingAndScrollingSegue" sender:tableView];
            break;
        case 21:
            [self performSegueWithIdentifier:@"ThemingSegue" sender:tableView];
            break;
        case 22:
            [self performSegueWithIdentifier:@"StylingSeriesSegue" sender:tableView];
            break;
        case 23:
            [self performSegueWithIdentifier:@"SnapshotSegue" sender:tableView];
            break;
        default:
            break;
    }
}

@end