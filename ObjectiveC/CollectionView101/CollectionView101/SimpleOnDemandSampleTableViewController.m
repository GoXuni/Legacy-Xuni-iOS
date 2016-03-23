//
//  SimpleOnDemandSampleTableViewController.m
//  CollectionView101
//
//  Created by Mykola Kotyuck on 01.03.16.
//  Copyright © 2016 GrapeCity. All rights reserved.
//

#import "SimpleOnDemandSampleTableViewController.h"
#import <XuniCoreKit/XuniCoreKit.h>
#import "SampleData.h"

#define LOAD_PAGE_SIZE 10

@interface SimpleSampleCollectionView : XuniCursorCollectionView

@end

@implementation SimpleSampleCollectionView

- (bool)hasMoreItems;
{
    return self.itemCount<500;
}

- (NSMutableArray *)itemGetter:(NSNumber *)desiredNumber
{
    NSMutableArray<SampleData*>* dataToAppend = [[NSMutableArray alloc]init];
    
    int exists = self.itemCount;
    int wanted = desiredNumber == nil?LOAD_PAGE_SIZE:desiredNumber.intValue;
    
    for (int i = exists; i<exists+wanted; i++)
    {
        [dataToAppend addObject:[[SampleData alloc] initWithTitle:[NSString stringWithFormat:@"My Data Item %i", i+1] subtitle:[NSString stringWithFormat:@"created at: %@", [NSDate date]]]];
    }
    
    return dataToAppend;
}

@end

@interface SimpleOnDemandSampleTableViewController ()
@property SimpleSampleCollectionView* collectionView;
@property int lastRendered;
@end

@implementation SimpleOnDemandSampleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView = [[SimpleSampleCollectionView alloc]init];
    
    [self.collectionView loadMoreItems:nil completion:^{
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


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
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger lastSectionIndex = [tableView numberOfSections] - 1;
    NSInteger lastRowIndex = [tableView numberOfRowsInSection:lastSectionIndex] - 1;
    if ((indexPath.section == lastSectionIndex) && (indexPath.row == lastRowIndex)) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.collectionView.hasMoreItems)
            [self.collectionView loadMoreItems:nil completion:^{
                [self.tableView reloadData];
            }];
        });
    }
}

@end
