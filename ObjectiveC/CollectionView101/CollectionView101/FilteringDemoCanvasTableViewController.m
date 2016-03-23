//
//  FilteringDemoCanvasTableViewController.m
//  CollectionView101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//

#import "FilteringDemoCanvasTableViewController.h"

@interface FilteringDemoCanvasTableViewController ()

@end

@implementation FilteringDemoCanvasTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _collectionView = [[YouTubeCollectionView alloc] initWithQuery:@"xamarin" orderBy:@"relevance"];
    [_collectionView loadMoreItems:@(50) completion:^{
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.collectionView.itemCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YouTubeEntryCell" forIndexPath:indexPath];
    
    SampleData* thisData = (SampleData*)[self.collectionView.items objectAtIndex:indexPath.row];
    cell.textLabel.text = thisData.title;
    cell.detailTextLabel.text = thisData.subtitle;
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:thisData.thumbnail]];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imageView.image = [UIImage imageWithData:data];
            [cell layoutSubviews];
        });
    });
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SampleData* thisData = (SampleData*)[self.collectionView.items objectAtIndex:indexPath.row];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:thisData.link]];
}

@end
