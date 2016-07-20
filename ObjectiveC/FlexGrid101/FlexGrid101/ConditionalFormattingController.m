//
//  ConditionalFormattingController.m
//  FlexGrid101
//
//  Copyright © 2015 GrapeCity. All rights reserved.
//

#import "ConditionalFormattingController.h"
#import "CustomerData.h"


@interface ConditionalFormattingController ()
@property (weak, nonatomic) IBOutlet FlexGrid *flex;

@end

@implementation ConditionalFormattingController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.flex.autoGenerateColumns = false;
    GridColumn *c1 = [[GridColumn alloc] init];
    c1.binding = @"firstName";
    c1.header  = NSLocalizedString(@"First Name", nil);
    c1.width   = 100;
    GridColumn *c2 = [[GridColumn alloc] init];
    c2.binding = @"lastName";
    c2.header  = NSLocalizedString(@"Last Name", nil);
    GridColumn *c3 = [[GridColumn alloc] init];
    c3.binding = @"orderTotal";
    c3.header  = NSLocalizedString(@"Total", nil);
    c3.format  = @"C";
    GridColumn *c4 = [[GridColumn alloc] init];
    c4.binding = @"orderCount";
    c4.header  = NSLocalizedString(@"Count", nil);
    c4.format  = @"N1";
    [self.flex.columns addObject:c1];
    [self.flex.columns addObject:c2];
    [self.flex.columns addObject:c3];
    [self.flex.columns addObject:c4];
    
    GridColumn *countryID = [[GridColumn alloc] init];
    countryID.binding = @"countryID";
    countryID.header = @"Country";
    countryID.horizontalAlignment = NSTextAlignmentLeft;
    NSMutableArray *items = [NSMutableArray arrayWithArray:[CustomerData defaultCountries]];
    countryID.dataMap = [[GridDataMap alloc] initWithArray:items selectedValuePath:@"identifier" displayMemberPath:@"title"];
    [self.flex.columns addObject:countryID];
    
    GridColumn *lastOrderDate = [[GridColumn alloc] init];
    lastOrderDate.binding = @"lastOrderDate";
    [self.flex.columns addObject:lastOrderDate];
    
    GridColumn *lastOrderTime = [[GridColumn alloc] init];
    lastOrderTime.binding = @"lastOrderDate";
    lastOrderTime.header = @"Last Order Time";
    NSDateFormatter* datefmt           = [[NSDateFormatter alloc] init];
    [datefmt setDateFormat:@"hh:mm a"];
    lastOrderTime.formatter = datefmt;
    [self.flex.columns addObject:lastOrderTime];

    self.flex.columnHeaderFont = [UIFont boldSystemFontOfSize:self.flex.columnHeaderFont.pointSize];
    self.flex.isReadOnly       = true;
    self.flex.itemsSource      = [CustomerData getCustomerData:100];
    
    [self.flex.flexGridFormatItem addHandler:^(XuniEventContainer<GridFormatItemEventArgs *> *eventContainer) {
        if (eventContainer.eventArgs.panel.cellType == GridCellTypeCell) {
            FlexGrid *g = _flex;
            GridColumn *col = [g.columns objectAtIndex:eventContainer.eventArgs.col];
            
            if ([col.binding isEqualToString:@"orderCount"]) {
                NSNumber *n = (NSNumber *)[eventContainer.eventArgs.panel getCellDataForRow:eventContainer.eventArgs.row inColumn:eventContainer.eventArgs.col formatted:NO];
                if (n != nil) {
                    if (n.integerValue >= 50) {
                        CGRect r = [eventContainer.eventArgs.panel getCellRectForRow:eventContainer.eventArgs.row inColumn:eventContainer.eventArgs.col];
                        CGContextSetFillColorWithColor(eventContainer.eventArgs.context, [UIColor colorWithRed:0.15 green:0.31 blue:0.07 alpha:1.0].CGColor);
                        CGContextFillRect(eventContainer.eventArgs.context, r);
                    } else if (n.integerValue < 50) {
                        CGRect r = [eventContainer.eventArgs.panel getCellRectForRow:eventContainer.eventArgs.row inColumn:eventContainer.eventArgs.col];
                        CGContextSetFillColorWithColor(eventContainer.eventArgs.context, [UIColor redColor].CGColor);
                        CGContextFillRect(eventContainer.eventArgs.context, r);
                    }
                    [eventContainer.eventArgs.panel.textAttributes setValue:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
                }
            }
            
            if ([col.binding isEqualToString:@"orderTotal"]) {
                NSNumber *n = (NSNumber *)[eventContainer.eventArgs.panel getCellDataForRow:eventContainer.eventArgs.row inColumn:eventContainer.eventArgs.col formatted:NO];
                if (n != nil) {
                    if (n.integerValue >= 5000) {
                        [eventContainer.eventArgs.panel.textAttributes setValue:[UIColor colorWithRed:0.15 green:0.31 blue:0.07 alpha:1.0] forKey:NSForegroundColorAttributeName];
                    } else if (n.integerValue < 5000) {
                        [eventContainer.eventArgs.panel.textAttributes setValue:[UIColor redColor] forKey:NSForegroundColorAttributeName];
                    }
                }
            }
        }
        eventContainer.eventArgs.cancel = false;

    } forObject:self];

}

@end
