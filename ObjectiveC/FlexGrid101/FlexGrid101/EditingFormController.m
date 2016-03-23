//
//  GettingStartedController.m
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "EditingFormController.h"
#import "CustomerData.h"
#import "XuniFlexGridKit/XuniFlexGridKit.h"
#import "CustomerObjectEditor.h"

EditingFormController* efc;
CustomerData* edited;

@interface EditingFormController ()
@property (weak, nonatomic) IBOutlet UIVisualEffectView *editpanel;

@end

@implementation EditingFormController
{
    FlexGrid *flex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    efc = self;
    // Do any additional setup after loading the view, typically from a nib.
    flex = [[FlexGrid alloc] init];
    flex.columnHeaderFont = [UIFont boldSystemFontOfSize:flex.columnHeaderFont.pointSize];
    flex.isReadOnly = true;
    flex.delegate = self;
    flex.itemsSource = [CustomerData getCustomerData:100];
    flex.tag = 1;
    [flex autoSizeColumns:0 to:flex.columns.count-1];
    [self.view addSubview:flex];
    [self.view sendSubviewToBack:flex];
}

-(void)cancel
{
    [objEdit resignFirstResponder];
    [UIView animateWithDuration:0.7 animations:^{
        _editpanel.alpha = 0;
    } completion:^(BOOL finished){
        _editpanel.hidden = true;
    }];
    
}

-(void)confirm
{
    [flex.collectionView raiseCollectionChanged];
    [self cancel];
}

-(BOOL)tapped:(FlexGrid *)sender point:(XuniPoint *)point
{
    [self cancel];
    
    return false;
}

-(bool)cellDoubleTapped:(FlexGrid *)sender panel:(FlexGridPanel *)panel forRange:(FlexCellRange *)range
{
    /*int i = args.row;
    
    CustomerData* dt = [[CustomerData alloc] initWithCustomerID:999 countryID:90 firstName:@"21" lastName:@"22" address:@"343" city:@"34243" country:@"hohland" postalCode:@"02222" lastOrderDate:nil orderCount:0 orderTotal:0 active:false];
    
    [flex.itemsSource setObject:dt atIndexedSubscript:i];
    [flex.collectionView raiseCollectionChanged];*/
    
    if(!_editpanel.hidden)
    {
        [self tapped:nil point:nil];
        return false;
    }
    
    edited = [flex.collectionView.items objectAtIndex:range.row];
    
    [objEdit initObject];
    
    _editpanel.alpha = 0;
    _editpanel.hidden = false;
    
    [UIView animateWithDuration:0.7 animations:^{
        _editpanel.alpha = 1;
    } completion:^(BOOL finished){
        _editpanel.alpha = 1;
    }];
    return false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    CGFloat ss = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.intrinsicContentSize.height;
    
    flex.frame = CGRectMake(0, ss, self.view.bounds.size.width, self.view.bounds.size.height - ss);
    [flex setNeedsDisplay];
}
@end