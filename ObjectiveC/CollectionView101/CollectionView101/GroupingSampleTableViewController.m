//
//  GroupingSampleTableViewController.m
//  CollectionView101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//

#import "GroupingSampleTableViewController.h"
#import "YouTubeCollectionView.h"
#import "SortingSampleTableViewController.h"
#import "SampleData.h"


@interface GroupingSampleTableViewController ()
@property YouTubeCollectionView* collectionView;
@end

@implementation GroupingSampleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _collectionView = [[YouTubeCollectionView alloc] initWithQuery:@"xamarin" orderBy:@"relevance"];
    [_collectionView loadMoreItems:@(50) completion:^{
        XuniPropertyGroupDescription *gd = [[XuniPropertyGroupDescription alloc] initWithProperty:@"channelTitle"];
        [_collectionView.groupDescriptions addObject:gd];
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.collectionView.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    XuniCollectionViewGroup* group = [self.collectionView.groups objectAtIndex:section];
    return group.items.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    XuniCollectionViewGroup* group = [self.collectionView.groups objectAtIndex:section];
    SampleData* thisData = (SampleData*)[group.items objectAtIndex:0];
    return thisData.channelTitle;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YouTubeEntryCell" forIndexPath:indexPath];
    
    XuniCollectionViewGroup* group = [self.collectionView.groups objectAtIndex:indexPath.section];
    
    SampleData* thisData = (SampleData*)[group.items objectAtIndex:indexPath.row];
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
    XuniCollectionViewGroup* group = [self.collectionView.groups objectAtIndex:indexPath.section];
    
    SampleData* thisData = (SampleData*)[group.items objectAtIndex:indexPath.row];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:thisData.link]];
}


@end
