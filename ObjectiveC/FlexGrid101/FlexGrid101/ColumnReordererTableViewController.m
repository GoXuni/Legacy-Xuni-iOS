//
//  ColumnReordererTableViewController.m
//  FlexGrid101
//
//  Copyright © 2015 GrapeCity. All rights reserved.
//

#import "ColumnReordererTableViewController.h"

@interface ColumnReordererTableViewController ()

@end


@implementation ColumnReordererTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.editing = true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    FlexGrid* fg = ((ColumnLayoutController*)self.parentViewController).flex;
    return fg.columns.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    
    FlexGrid* fg = ((ColumnLayoutController*)self.parentViewController).flex;
    GridColumn* col = [fg.columns objectAtIndex:indexPath.row];
    
    cell.textLabel.text = col.header;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        FlexGrid* fg = ((ColumnLayoutController*)self.parentViewController).flex;
        [fg.columns removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
    }   
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    FlexGrid* fg = ((ColumnLayoutController*)self.parentViewController).flex;
    GridColumn* fc = [fg.columns objectAtIndex:fromIndexPath.row];
    [fg.columns removeObjectAtIndex:fromIndexPath.row];
    [fg.columns insertObject:fc atIndex:toIndexPath.row];
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

@end
