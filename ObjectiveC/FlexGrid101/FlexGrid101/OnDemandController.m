//
//  OnDemandController.m
//  FlexGrid101
//
//  Copyright © 2015 GrapeCity. All rights reserved.
//

#import "OnDemandController.h"
#import "CustomerData.h"
#import "XuniFlexGridKit/XuniFlexGridKit.h"

@interface DemoCursorCollectionView: XuniCursorCollectionView

@end


@interface OnDemandController ()

@end

@implementation DemoCursorCollectionView

-(id)init
{
    DemoCursorCollectionView * coll = [super init];
    
    coll.sourceCollection = [CustomerData getCustomerData:100];
    
    return coll;
}

-(NSMutableArray *)itemGetter:(NSNumber *)desiredNumber
{
    return [CustomerData getCustomerData:desiredNumber==nil?100:desiredNumber.intValue];
}

-(bool) hasMoreItems
{
    return self.sourceCollection.count < 400;
}
@end


@implementation OnDemandController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    FlexGrid *flex = [[FlexGrid alloc] init];
    flex.columnHeaderFont = [UIFont boldSystemFontOfSize:flex.columnHeaderFont.pointSize];
    flex.isReadOnly = true;
    flex.collectionView = [[DemoCursorCollectionView alloc] init];
    
    flex.tag = 1;
    [flex autoSizeColumn:0 to:flex.columns.count-1];
    [self.view addSubview:flex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    FlexGrid *flex = (FlexGrid*)[self.view viewWithTag:1];
    
    CGFloat ss = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.intrinsicContentSize.height;
    
    flex.frame = CGRectMake(0, ss, self.view.bounds.size.width, self.view.bounds.size.height - ss);
    [flex setNeedsDisplay];
}

@end
