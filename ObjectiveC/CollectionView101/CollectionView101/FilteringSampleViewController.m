//
//  FilteringSampleViewController.m
//  CollectionView101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//

#import "FilteringSampleViewController.h"
#import "FilteringDemoCanvasTableViewController.h"

@interface FilteringSampleViewController ()
@property (weak, nonatomic) IBOutlet UITextField *searchRequest;

@end

@implementation FilteringSampleViewController

-(void) searchBody
{
    FilteringDemoCanvasTableViewController* canvas = [self.childViewControllers  objectAtIndex:0];
    canvas.collectionView.filter = ^(NSObject *item) {
        if(!self.searchRequest.text.length) {
            return (bool)true;
        }
        SampleData *sd = (SampleData *)item;
        return (bool)([[sd.title uppercaseString] containsString:[self.searchRequest.text uppercaseString]] || [[sd.description uppercaseString] containsString:[self.searchRequest.text uppercaseString]]);
    };
    
    [canvas.tableView reloadData];
}

- (IBAction)doSearch:(id)sender {
    [self searchBody];
    
    [self.searchRequest resignFirstResponder];
}

- (IBAction)textChanged:(id)sender {
    [self searchBody];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
