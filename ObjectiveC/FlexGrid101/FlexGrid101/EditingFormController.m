//
//  GettingStartedController.m
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "EditingFormController.h"
#import "CustomerData.h"
#import "XuniFlexGridDynamicKit/XuniFlexGridDynamicKit.h"
#import "CustomerObjectEditor.h"

@interface EditingFormController ()
@property (weak, nonatomic) IBOutlet UIVisualEffectView *editpanel;
@property (weak, nonatomic) IBOutlet FlexGrid *flex;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editaction;

@end

@implementation EditingFormController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.flex.columnHeaderFont = [UIFont boldSystemFontOfSize:self.flex.columnHeaderFont.pointSize];
    self.flex.isReadOnly = true;
    self.flex.itemsSource = [CustomerData getCustomerData:100];
    
    [self.flex.flexGridSelectionChanged addHandler:^(XuniEventContainer<GridCellRangeEventArgs *> *eventContainer) {
        self.editaction.enabled = true;
    } forObject:self];
    
    
    [self.flex.flexGridTapped addHandler:^(XuniEventContainer<GridCellRangeEventArgs *> *eventContainer) {
        [self cancel];
    } forObject:self];
    
    [self.flex.flexGridCellDoubleTapped addHandler:^(XuniEventContainer<GridCellRangeEventArgs *> *eventContainer) {
        if(!_editpanel.hidden)
        {
            [self cancel];
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self beginEditing];
        });
        
    } forObject:self];
    
    [self.flex autoSizeColumns:0 to:self.flex.columns.count-1];
}

- (IBAction)doedit:(id)sender {
    [self beginEditing];
}


-(void)beginEditing
{
    self.edited = [self.flex.collectionView.items objectAtIndex:self.flex.selection.row];
    
    CustomerObjectEditor* objEdit = (CustomerObjectEditor*)self.childViewControllers[0];
    
    [objEdit initObject];
    
    _editpanel.alpha = 0;
    _editpanel.hidden = false;
    
    [UIView animateWithDuration:0.7 animations:^{
        _editpanel.alpha = 1;
    } completion:^(BOOL finished){
        _editpanel.alpha = 1;
    }];
}

-(void)cancel
{
    CustomerObjectEditor* objEdit = (CustomerObjectEditor*)self.childViewControllers[0];
    [objEdit resignFirstResponder];
    [UIView animateWithDuration:0.7 animations:^{
        _editpanel.alpha = 0;
    } completion:^(BOOL finished){
        _editpanel.hidden = true;
    }];
    
}

-(void)confirm
{
    [self.flex.collectionView raiseCollectionChanged];
    [self cancel];
}


@end