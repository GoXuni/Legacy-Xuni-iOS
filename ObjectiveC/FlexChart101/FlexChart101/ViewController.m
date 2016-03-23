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
    NSArray* _samplesImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITableView *table = (UITableView*)[self.view viewWithTag:1];
    table.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    _samplesTitle = @[NSLocalizedString(@"Getting Started", nil),
                      NSLocalizedString(@"Basic Chart Types", nil),
                      NSLocalizedString(@"Mixed Chart Types", nil),
                      NSLocalizedString(@"Financial Chart", nil),
                      NSLocalizedString(@"Bubble Chart", nil),
                      NSLocalizedString(@"Custom Tooltips", nil),
                      NSLocalizedString(@"Data Labels", nil),
                      NSLocalizedString(@"Annotations", nil),
                      NSLocalizedString(@"Line Marker", nil),
                      NSLocalizedString(@"Customizing Axes", nil),
                      NSLocalizedString(@"Multiple Axes", nil),
                      NSLocalizedString(@"Legend and Titles", nil),
                      NSLocalizedString(@"Conditional Formatting", nil),
                      NSLocalizedString(@"Custom Plot Elements", nil),
                      NSLocalizedString(@"Selection Modes", nil),
                      NSLocalizedString(@"Toggle Series", nil),
                      NSLocalizedString(@"Load Animation Mode", nil),
                      NSLocalizedString(@"Update Animation", nil),
                      NSLocalizedString(@"Dynamic Charts", nil),
                      NSLocalizedString(@"Hit Test", nil),
                      NSLocalizedString(@"Scrolling", nil),
                      NSLocalizedString(@"Zooming and Scrolling", nil),
                      NSLocalizedString(@"Theming", nil),
                      NSLocalizedString(@"Styling Series", nil),
                      NSLocalizedString(@"Export Image", nil)];
    
    _samplesDescription = @[NSLocalizedString(@"Shows a simple chart with tooltips.", nil),
                            NSLocalizedString(@"Shows the basic chart types and stacking options.", nil),
                            NSLocalizedString(@"Shows a composite chart.", nil),
                            NSLocalizedString(@"Shows stock data in a candle chart.", nil),
                            NSLocalizedString(@"Shows a bubble chart.", nil),
                            NSLocalizedString(@"Shows a customized tooltip.", nil),
                            NSLocalizedString(@"Shows a simple chart with static data labels.", nil),
                            NSLocalizedString(@"Shows how to display annotations on FlexChart.", nil),
                            NSLocalizedString(@"Shows a moveable marker on top of the chart.", nil),
                            NSLocalizedString(@"Shows customized axis style and label format.", nil),
                            NSLocalizedString(@"Shows a chart with mutiple Y axes.", nil),
                            NSLocalizedString(@"Shows basic chart headers and axis titles.", nil),
                            NSLocalizedString(@"Shows conditional formatting by customizing plot elements.", nil),
                            NSLocalizedString(@"Shows how to fully customize plot elements.", nil),
                            NSLocalizedString(@"Shows the different selection modes.", nil),
                            NSLocalizedString(@"Shows the ability to toggle a series visibility.", nil),
                            NSLocalizedString(@"Shows animation modes when data is loaded.", nil),
                            NSLocalizedString(@"Shows animation when data is updated.", nil),
                            NSLocalizedString(@"Shows a dynamic, “live” chart.", nil),
                            NSLocalizedString(@"Demonstrates use of the FlexChart's hitTest method.", nil),
                            NSLocalizedString(@"Shows a chart with panning (or scrolling) along the axes.", nil),
                            NSLocalizedString(@"Shows stretch zoom-out and pinch zoom-in gestures.", nil),
                            NSLocalizedString(@"Shows the built-in palettes.", nil),
                            NSLocalizedString(@"Shows custom series styling.", nil),
                            NSLocalizedString(@"Shows how to export an image of FlexChart.", nil)];
    
    _samplesImage = @[@"Getting Started",
                      @"Basic Chart Types",
                      @"Mixed Chart Types",
                      @"Financial Chart",
                      @"Bubble Chart",
                      @"Custom Tooltips",
                      @"Data Labels",
                      @"Annotations",
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
    NSString *imageName = [_samplesImage[indexPath.row] stringByReplacingOccurrencesOfString:@" " withString:@""];
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
            [self performSegueWithIdentifier:@"AnnotationSegue" sender:tableView];
            break;
        case 8:
            [self performSegueWithIdentifier:@"CustomLineMarkerSegue" sender:tableView];
            break;
        case 9:
            [self performSegueWithIdentifier:@"CustomizingAxesSegue" sender:tableView];
            break;
        case 10:
            [self performSegueWithIdentifier:@"MultipleAxesSegue" sender:tableView];
            break;
        case 11:
            [self performSegueWithIdentifier:@"LegendsAndTitlesSegue" sender:tableView];
            break;
        case 12:
            [self performSegueWithIdentifier:@"ConditionalFormattingSegue" sender:tableView];
            break;
        case 13:
            [self performSegueWithIdentifier:@"CustomPlotElementsSegue" sender:tableView];
            break;
        case 14:
            [self performSegueWithIdentifier:@"SelectionModesSegue" sender:tableView];
            break;
        case 15:
            [self performSegueWithIdentifier:@"ToggleSeriesSegue" sender:tableView];
            break;
        case 16:
            [self performSegueWithIdentifier:@"LoadAnimationSegue" sender:tableView];
            break;
        case 17:
            [self performSegueWithIdentifier:@"UpdateAnimationSegue" sender:tableView];
            break;
        case 18:
            [self performSegueWithIdentifier:@"DynamicChartsSegue" sender:tableView];
            break;
        case 19:
            [self performSegueWithIdentifier:@"HitTestSegue" sender:tableView];
            break;
        case 20:
            [self performSegueWithIdentifier:@"ScrollingSegue" sender:tableView];
            break;
        case 21:
            [self performSegueWithIdentifier:@"ZoomingAndScrollingSegue" sender:tableView];
            break;
        case 22:
            [self performSegueWithIdentifier:@"ThemingSegue" sender:tableView];
            break;
        case 23:
            [self performSegueWithIdentifier:@"StylingSeriesSegue" sender:tableView];
            break;
        case 24:
            [self performSegueWithIdentifier:@"SnapshotSegue" sender:tableView];
            break;
        default:
            break;
    }
}

@end