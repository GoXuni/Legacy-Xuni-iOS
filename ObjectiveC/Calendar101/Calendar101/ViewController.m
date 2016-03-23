//
//  ViewController.m
//  Calendar101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

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
                      @"Vertical Orientation",
                      @"Custom Day Content",
                      @"Custom Header",
                      @"Custom Appearance",
                      @"Popup Editor",
                      @"Custom Selection"];
    
    _samplesDescription = @[@"Shows a basic calendar with selection and interaction.",
                            @"Shows a calendar with vertical navigation/scrolling.",
                            @"Shows how to customize a day slot to show custom content.",
                            @"Shows a custom header inspired by a popular Android or iOS calendar app.",
                            @"Shows a calendar with a custom style.",
                            @"Shows how to use the control as a pop-up date selector.",
                            @"Shows custom selection scenarios."];
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
            [self performSegueWithIdentifier:@"VerticalOrientationSegue" sender:tableView];
            break;
        case 2:
            [self performSegueWithIdentifier:@"CustomDayContentSegue" sender:tableView];
            break;
        case 3:
            [self performSegueWithIdentifier:@"CustomHeaderSegue" sender:tableView];
            break;
        case 4:
            [self performSegueWithIdentifier:@"CustomAppearanceSegue" sender:tableView];
            break;
        case 5:
            [self performSegueWithIdentifier:@"PopupEditorSegue" sender:tableView];
            break;
        case 6:
            [self performSegueWithIdentifier:@"CustomSelectionSegue" sender:tableView];
            break;
        default:
            break;
    }
}

@end
