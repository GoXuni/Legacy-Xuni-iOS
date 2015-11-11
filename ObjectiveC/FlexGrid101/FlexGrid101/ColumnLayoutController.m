//
//  ColumnLayoutController.m
//  FlexGrid101
//
//  Copyright © 2015 GrapeCity. All rights reserved.
//

#import "ColumnLayoutController.h"

@interface ColumnLayoutController ()
@property (weak, nonatomic) IBOutlet UIVisualEffectView *columnList;

@end

ColumnLayoutController* columnLayoutController;

@implementation ColumnLayoutController
{
    UIBarButtonItem *editButton;
}

- (void)viewDidLoad {
    
    columnLayoutController = self;
    
    [super viewDidLoad];
    
    editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit Columns" style:UIBarButtonItemStylePlain target:self action:@selector(editColumns:)];
    self.navigationItem.rightBarButtonItem = editButton;
    
    self.columnList.hidden = true;
    // Do any additional setup after loading the view, typically from a nib.
    _flex = [[FlexGrid alloc] init];
    _flex.columnHeaderFont = [UIFont boldSystemFontOfSize:_flex.columnHeaderFont.pointSize];
    _flex.isReadOnly = true;
    _flex.itemsSource = [CustomerData getCustomerData:100];
    _flex.tag = 1;
    [_flex autoSizeColumn:0 to:_flex.columns.count-1];
    [self.view addSubview:_flex];
    [self.view sendSubviewToBack:_flex];
}

-(void)beginEditing
{
    [columnReorderTable.tableView reloadData];
    
    self.columnList.alpha = 0;
    self.columnList.hidden = false;
    [UIView animateWithDuration:0.7 animations:^{
        self.columnList.alpha = 1;
    } completion:^(BOOL finished){
        
    }];
    
    
    editButton.title = @"Done";
}

-(void)endEditing
{
    [UIView animateWithDuration:0.7 animations:^{
        self.columnList.alpha = 0;
    } completion:^(BOOL finished){
        self.columnList.hidden = true;
    }];
    
    
    editButton.title = @"Edit Columns";
}


- (IBAction)editColumns:(id)sender
{
    if(self.columnList.hidden)
    {
        [self beginEditing];
    }
    else
    {
        [self endEditing];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    CGFloat ss = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.intrinsicContentSize.height;
    
    _flex.frame = CGRectMake(0, ss, self.view.bounds.size.width, self.view.bounds.size.height - ss);
    [_flex setNeedsDisplay];
}


@end
