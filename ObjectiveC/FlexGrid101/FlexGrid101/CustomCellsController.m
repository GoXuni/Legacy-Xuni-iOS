//
//  CustomCellsController.m
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "CustomCellsController.h"
#import "FlexGridKit/FlexGridKit.h"
#import "XuniGaugeKit/XuniGaugeKit.h"
#import "CustomerData.h"

@interface CustomCellsController ()

@end

@implementation CustomCellsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    FlexGrid *flex = [[FlexGrid alloc] init];
    flex.autoGenerateColumns = false;
    flex.isReadOnly = true;
    flex.delegate = self;
    flex.tag = 1;
    
    FlexColumn *c1 = [[FlexColumn alloc] init];
    c1.binding = @"customerID";
    FlexColumn *c2 = [[FlexColumn alloc] init];
    c2.binding = @"first";
    FlexColumn *c3 = [[FlexColumn alloc] init];
    c3.header = @"performance";
    c3.binding = @"weight";
    [flex.columns addObject:c1];
    [flex.columns addObject:c2];
    [flex.columns addObject:c3];
    
    flex.itemsSource = [CustomerData getCustomerData:100];
    flex.tag = 1;
    [self starSizing:flex];
    [self.view addSubview:flex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    FlexGrid *flex = (FlexGrid*)[self.view viewWithTag:1];
    flex.frame = CGRectMake(0, 65, self.view.bounds.size.width, self.view.bounds.size.height - 65);
    [flex setNeedsDisplay];
}
-(void)starSizing:(FlexGrid*)g{
    for (int i = 0; i < g.columns.count; i++) {
        FlexColumn *c = [g.columns objectAtIndex:i];
        c.widthType = FlexColumnWidthStar;
        c.width = (i == 0) ? 5 : (i == 3) ? 3 : 4;
    }
}
- (void)formatItem:(FlexFormatItemEventArgs*)args{
        FlexGrid *g = (FlexGrid*)[self.view viewWithTag:1];
        FlexColumn *col = [g.columns objectAtIndex:args.col];
        if ([col.header isEqualToString:@"performance"]) {
            NSObject *v = [args.panel getCellDataForRow:args.row inColumn:args.col formatted:false];
            if (v != nil) {
                if (![v.description  isEqual: @"performance"]){
                    XuniRadialGauge *radialGauge = [[XuniRadialGauge alloc] init];
                    XuniGaugeRange *lower = [[XuniGaugeRange alloc] initWithGauge:radialGauge];
                    lower.min = 0;
                    lower.max = 40;
                    lower.color = [UIColor colorWithRed:0.133 green:0.694 blue:0.298 alpha:1];
                    XuniGaugeRange *middle = [[XuniGaugeRange alloc] initWithGauge:radialGauge];
                    middle.min = 40;
                    middle.max = 80;
                    middle.color = [UIColor colorWithRed:1 green:0.502 blue:0.502 alpha:1];
                    XuniGaugeRange *upper = [[XuniGaugeRange alloc] initWithGauge:radialGauge];
                    upper.min = 80;
                    upper.max = 100;
                    upper.color = [UIColor colorWithRed:0 green:0.635 blue:0.91 alpha:1];
                    
                    [radialGauge.ranges addObject:lower];
                    [radialGauge.ranges addObject:middle];
                    [radialGauge.ranges addObject:upper];
                    
                    radialGauge.showText = XuniShowTextNone;
                    radialGauge.thickness = 0.6;
                    radialGauge.min = 0;
                    radialGauge.max = 100;
                    radialGauge.loadAnimation = nil;
                    radialGauge.value =[v.description integerValue]/3;
                    radialGauge.showRanges = false;
                    
                    CGRect r = [args.panel getCellRectForRow:args.row inColumn:args.col];
                    
                    XuniRect *t = [[XuniRect alloc] initLeft:0 top:0 width:r.size.width height:r.size.height];
                    radialGauge.rectGauge = t;
                    radialGauge.frame = CGRectMake(0, 0, r.size.width, r.size.height);

                    UIImage *image = [[UIImage alloc] init];
                    image = [UIImage imageWithData:[radialGauge getImage]];
                    [image drawInRect:r];
                    args.cancel = YES;
                }
            }
        }
}
@end