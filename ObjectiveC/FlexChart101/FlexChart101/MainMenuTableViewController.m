//
//  MainMenuTableViewController.m
//  FlexChart101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//

#import "MainMenuTableViewController.h"

@interface MainMenuTableViewController ()

@end

@implementation MainMenuTableViewController
{
    NSArray *_samplesTitle;
    NSArray *_samplesDescription;
    NSArray *_samplesImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_samplesTitle count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString        *SimpleIdentifier = @"SimpleIdentifier";
    UITableViewCell *cell             = [tableView dequeueReusableCellWithIdentifier:SimpleIdentifier];
    NSString        *imageName        = [_samplesImage[indexPath.row] stringByReplacingOccurrencesOfString:@" " withString:@""];
    imageName = [NSString stringWithFormat:@"%@%@", imageName.lowercaseString, @".png"];

    cell.textLabel.text            = _samplesTitle[indexPath.row];
    cell.textLabel.textColor       = [UIColor colorWithRed:176.0 / 255 green:15.0 / 255 blue:80.0 / 255 alpha:1];
    cell.detailTextLabel.text      = _samplesDescription[indexPath.row];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    cell.imageView.image           = [UIImage imageNamed:imageName];

    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* sampleName = [_samplesImage objectAtIndex:indexPath.row];
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:nil];
    UIViewController *sample =
    [storyboard instantiateViewControllerWithIdentifier:sampleName];
    
    [self.navigationController pushViewController:sample animated:true];
}



@end
