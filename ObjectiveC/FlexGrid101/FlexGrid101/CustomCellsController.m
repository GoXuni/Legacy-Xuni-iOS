//
//  CustomCellsController.m
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "CustomCellsController.h"
#import "XuniFlexGridDynamicKit/XuniFlexGridDynamicKit.h"
#import "XuniGaugeDynamicKit/XuniGaugeDynamicKit.h"
#import "CustomerData.h"

@interface CustomCellsController ()
@property (weak, nonatomic) IBOutlet FlexGrid *flex;

@end

@implementation CustomCellsController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.flex.columnHeaderFont    = [UIFont boldSystemFontOfSize:self.flex.columnHeaderFont.pointSize];
    self.flex.autoGenerateColumns = false;
    self.flex.isReadOnly          = true;
    self.flex.selectionMode = GridSelectionModeRow;

    GridColumn *c1 = [[GridColumn alloc] init];
    c1.header  = NSLocalizedString(@"First Name", nil);
    c1.binding = @"firstName";
    GridColumn *c2 = [[GridColumn alloc] init];
    c2.header  = NSLocalizedString(@"Last Name", nil);
    c2.binding = @"lastName";
    GridColumn *c3 = [[GridColumn alloc] init];
    c3.header  = NSLocalizedString(@"Total Orders", nil);
    c3.binding = @"orderTotal";
    [self.flex.columns addObject:c1];
    [self.flex.columns addObject:c2];
    [self.flex.columns addObject:c3];

    self.flex.itemsSource   = [CustomerData getCustomerData:100];
    [self starSizing:self.flex];
    
    [self.flex.flexGridFormatItem addHandler:^(XuniEventContainer<GridFormatItemEventArgs *> *eventContainer) {
        eventContainer.eventArgs.cancel = NO;
        FlexGrid   *g     = self.flex;
        GridColumn *col   = g.columns[eventContainer.eventArgs.col];
        if ([col.binding isEqualToString:@"orderTotal"]) {
            NSObject *v = [eventContainer.eventArgs.panel getCellDataForRow:eventContainer.eventArgs.row inColumn:eventContainer.eventArgs.col formatted:false];
            if (v != nil) {
                if (![v.description isEqual:NSLocalizedString(@"Total Orders", nil)]) {
                    XuniRadialGauge *radialGauge = [[XuniRadialGauge alloc] init];
                    XuniGaugeRange  *lower       = [[XuniGaugeRange alloc] initWithGauge:radialGauge];
                    lower.min   = 0;
                    lower.max   = 40;
                    lower.color = [UIColor colorWithRed:0.133 green:0.694 blue:0.298 alpha:1];
                    XuniGaugeRange *middle = [[XuniGaugeRange alloc] initWithGauge:radialGauge];
                    middle.min   = 40;
                    middle.max   = 80;
                    middle.color = [UIColor colorWithRed:1 green:0.502 blue:0.502 alpha:1];
                    XuniGaugeRange *upper = [[XuniGaugeRange alloc] initWithGauge:radialGauge];
                    upper.min   = 80;
                    upper.max   = 100;
                    upper.color = [UIColor colorWithRed:0 green:0.635 blue:0.91 alpha:1];
                    
                    [radialGauge.ranges addObject:lower];
                    [radialGauge.ranges addObject:middle];
                    [radialGauge.ranges addObject:upper];
                    
                    radialGauge.backgroundColor = [UIColor clearColor];
                    radialGauge.showText      = XuniShowTextNone;
                    radialGauge.thickness     = 0.6;
                    radialGauge.min           = 0;
                    radialGauge.max           = 100;
                    radialGauge.loadAnimation = nil;
                    radialGauge.value         = [v.description doubleValue]*(100.0/90000.0);
                    radialGauge.showRanges    = false;
                    
                    CGRect r = [eventContainer.eventArgs.panel getCellRectForRow:eventContainer.eventArgs.row inColumn:eventContainer.eventArgs.col];
                    
                    XuniRect *t = [[XuniRect alloc] initLeft:0 top:0 width:r.size.width height:r.size.height];
                    radialGauge.rectGauge = t;
                    radialGauge.frame     = CGRectMake(0, 0, r.size.width, r.size.height);
                    
                    UIImage *image = [[UIImage alloc] init];
                    image = [UIImage imageWithData:[radialGauge getImage]];
                    [image drawInRect:r];
                    eventContainer.eventArgs.cancel = YES;
                }
            }
        }

    } forObject:self];
    
}

- (void)starSizing:(FlexGrid *)g {
    for (int i = 0; i < g.columns.count; i++) {
        GridColumn *c = [g.columns objectAtIndex:i];
        c.widthType = GridColumnWidthStar;
        c.width     = (i == 0) ? 5 : (i == 3) ? 3 : 4;
    }
}

@end