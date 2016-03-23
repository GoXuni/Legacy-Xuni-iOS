//
//  YouTubeOnDemandSampleViewController.m
//  CollectionView101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//

#import "YouTubeCollectionView.h"
#import "SampleData.h"
#import "YouTubeOnDemandSampleViewController.h"
#import "YouTubeOnDemandCanvasTableViewController.h"

@interface YouTubeOnDemandSampleViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *sortSelect;
@property (weak, nonatomic) IBOutlet UITextField *textInput;

@end

@implementation YouTubeOnDemandSampleViewController
- (IBAction)searchModeChanged:(id)sender {
    [self updateSearch];
}

- (IBAction)startSearch:(id)sender {
    [self.textInput resignFirstResponder];
    [self updateSearch];
}

-(void) updateSearch
{
    YouTubeOnDemandCanvasTableViewController* canvas = [self.childViewControllers  objectAtIndex:0];
    
    NSArray* selArray = @[@"relevance",@"date",@"viewCount",@"rating",@"title"];
    
    canvas.collectionView = [[YouTubeCollectionView alloc] initWithQuery:self.textInput.text orderBy:[selArray objectAtIndex:self.sortSelect.selectedSegmentIndex]];
    [canvas.collectionView loadMoreItems:@(50) completion:^{
        [canvas.tableView reloadData];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sortSelect.selectedSegmentIndex = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
