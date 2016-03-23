//
//  ConditionalFormattingController.m
//  FlexGrid101
//
//  Copyright © 2015 GrapeCity. All rights reserved.
//

#import "ConditionalFormattingController.h"
#import "CustomerData.h"


@interface ConditionalFormattingController ()

@end

@implementation ConditionalFormattingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    FlexGrid *flex = [[FlexGrid alloc] init];
    
    flex.autoGenerateColumns = false;
    FlexColumn *c1 = [[FlexColumn alloc] init];
    c1.binding = @"firstName";
    c1.header = NSLocalizedString(@"First Name", nil);
    c1.width = 100;
    FlexColumn *c2 = [[FlexColumn alloc] init];
    c2.binding = @"lastName";
    c2.header = NSLocalizedString(@"Last Name", nil);
    FlexColumn *c3 = [[FlexColumn alloc] init];
    c3.binding = @"orderTotal";
    c3.header = NSLocalizedString(@"Total", nil);
    c3.format = @"C";
    FlexColumn *c4 = [[FlexColumn alloc] init];
    c4.binding = @"orderCount";
    c4.header = NSLocalizedString(@"Count", nil);
    c4.format = @"N1";
    [flex.columns addObject:c1];
    [flex.columns addObject:c2];
    [flex.columns addObject:c3];
    [flex.columns addObject:c4];
    
    flex.columnHeaderFont = [UIFont boldSystemFontOfSize:flex.columnHeaderFont.pointSize];
    flex.isReadOnly = true;
    flex.itemsSource = [CustomerData getCustomerData:100];
    flex.tag = 1;
    flex.delegate = self;
    
    [self.view addSubview:flex];
}

-(bool)formatItem:(FlexGrid *)sender panel:(FlexGridPanel *)panel forRange:(FlexCellRange *)range inContext:(CGContextRef)context {
    if (panel.cellType == FlexCellTypeCell) {
        FlexGrid *g = (FlexGrid*)[self.view viewWithTag:1];
        FlexColumn *col = [g.columns objectAtIndex:range.col];
        
        if ([col.binding isEqualToString:@"orderCount"]) {
            NSNumber *n = (NSNumber*)[panel getCellDataForRow:range.row inColumn:range.col formatted:NO];
            if (n != nil) {
                if (n.integerValue >= 50) {
                    CGRect r = [panel getCellRectForRow:range.row inColumn:range.col];
                    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0.15 green:0.31 blue:0.07 alpha:1.0].CGColor);
                    CGContextFillRect(context, r);
                }
                else if (n.integerValue < 50) {
                    CGRect r = [panel getCellRectForRow:range.row inColumn:range.col];
                    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
                    CGContextFillRect(context, r);
                }
                [panel.textAttributes setValue:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
            }
        }
        
        if ([col.binding isEqualToString:@"orderTotal"]) {
            NSNumber *n = (NSNumber*)[panel getCellDataForRow:range.row inColumn:range.col formatted:NO];
            if (n != nil) {
                if (n.integerValue >= 5000) {
                    [panel.textAttributes setValue:[UIColor colorWithRed:0.15 green:0.31 blue:0.07 alpha:1.0] forKey:NSForegroundColorAttributeName];
                }
                else if (n.integerValue < 5000) {
                    [panel.textAttributes setValue:[UIColor redColor] forKey:NSForegroundColorAttributeName];
                }
            }
        }
    }
    return false;
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
