//
//  OnDemandController.m
//  XuniExplorer
//
//  Created by kelley.ricker on 10/15/15.
//  Copyright © 2015 GrapeCity. All rights reserved.
//

#import "OnDemandController.h"
#import "CustomerData.h"
#import "XuniFlexGridKit/XuniFlexGridKit.h"

@interface DemoCursorCollectionView: XuniCursorCollectionView

@end


@interface OnDemandController (){
    NSArray *countriesArray;
}

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
    return [CustomerData getCustomerData:900];
}

-(bool) hasMoreItems
{
    return self.sourceCollection.count < 1000;
}
@end


@implementation OnDemandController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = NSLocalizedString(@"On Demand", @"On Demand");
    NSString *countries = @"US|Germany|UK|Japan|Italy|Greece";
    countriesArray = [countries componentsSeparatedByString:@"|"];
    // Do any additional setup after loading the view, typically from a nib.
    FlexGrid *flex = [[FlexGrid alloc] init];
    flex.columnHeaderFont = [UIFont boldSystemFontOfSize:flex.columnHeaderFont.pointSize];
    flex.isReadOnly = true;
    flex.collectionView = [[DemoCursorCollectionView alloc] init];
    flex.delegate = self;
    flex.tag = 1;
    if(UI_USER_INTERFACE_IDIOM()  == UIUserInterfaceIdiomPad){
        [self starSizing:flex];
    }
    [self.view addSubview:flex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    FlexGrid *flex = (FlexGrid*)[self.view viewWithTag:1];
    
    flex.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    //[flex setNeedsDisplay];
}
- (void)formatItem:(FlexFormatItemEventArgs*)args{
    FlexGrid *flex = (FlexGrid*)[self.view viewWithTag:1];
    FlexColumn *col = [flex.columns objectAtIndex:args.col];
    if ([col.binding isEqualToString:@"countryID"]) {
        NSObject *v = [args.panel getCellDataForRow:args.row inColumn:args.col formatted:false];
        if (v != nil) {
            //comment this out
            if (![v.description  isEqual: @"countryID"]){
                
                CGRect r = [args.panel getCellRectForRow:args.row inColumn:args.col];
                
                
                r.origin.x += (r.size.width/2 - 12);
                r.origin.y += (r.size.height/2 - 12);
                
                r.size.width = 24;
                r.size.height = 24;
                UIImage *image = [[UIImage alloc] init];
                image = [UIImage imageNamed:countriesArray[[v.description integerValue]]];
                [image drawInRect:r];
                args.cancel = YES;
            }
        }
    }
}
-(void)starSizing:(FlexGrid*)g{
    for (int i = 0; i < g.columns.count; i++) {
        FlexColumn *c = [g.columns objectAtIndex:i];
        c.widthType = FlexColumnWidthStar;
        // c.width = (i == 0) ? 5 : (i == 3) ? 3 : 4;
    }
}
@end