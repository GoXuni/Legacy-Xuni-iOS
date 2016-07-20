//
//  CustomMergingViewController.m
//  FlexGrid101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//

#import "XuniFlexGridDynamicKit/XuniFlexGridDynamicKit.h"
#import "CustomMergingViewController.h"

@interface CustomMergingViewController ()
@property (weak, nonatomic) IBOutlet FlexGrid *grid;
@property (weak, nonatomic) IBOutlet UILabel *showTitle;
@property (weak, nonatomic) IBOutlet UILabel *showTimetable;

@end

@interface CustomMergingFlexGrid: FlexGrid

@end

@implementation CustomMergingFlexGrid

- (void)prepareForInterfaceBuilder {
    self.columnHeaderFont = [UIFont boldSystemFontOfSize:self.columnHeaderFont.pointSize];
    
    NSArray* weekdays = @[@"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", @"Sunday"];
    
    for (NSString* dayName in weekdays) {
        GridColumn *c1 = [[GridColumn alloc] init];
        c1.header = dayName;
        c1.widthType = GridColumnWidthStar;
        c1.width = 1;
        c1.dataType = XuniDataTypeString;
        c1.minWidth = 120;
        c1.horizontalAlignment = NSTextAlignmentCenter;
        c1.headerHorizontalAlignment = NSTextAlignmentCenter;
        c1.allowMerging = true;
        [self.columns addObject:c1];
    }
    
    NSArray* timespans = @[@"12", @"13", @"14", @"15", @"16", @"17", @"18"];
    for (NSString* timeSpan in timespans) {
        GridRow* r1 = [[GridRow alloc] init];
        [self.rows addObject:r1];
        
        [self.rowHeaders setCellData:[NSString stringWithFormat:@"%@:00", timeSpan] forRow:(int)[self.rows indexOfObject:r1] inColumn:0];
    }
    
    [self.columnHeaders.rows insertObject:[[GridRow alloc]init] atIndex:0];
    
    self.columnHeaders.rows[0].allowMerging = true;
    
    self.columnHeaders[0][0] = @"Weekday";
    self.columnHeaders[0][1] = @"Weekday";
    self.columnHeaders[0][2] = @"Weekday";
    self.columnHeaders[0][3] = @"Weekday";
    self.columnHeaders[0][4] = @"Weekday";
    self.columnHeaders[0][5] = @"Weekend";
    self.columnHeaders[0][6] = @"Weekend";
    
    [self setCellData:@"Walker" forRow:0 inColumn:0];
    [self setCellData:@"Morning Show" forRow:0 inColumn:1];
    [self setCellData:@"Morning Show" forRow:0 inColumn:2];
    [self setCellData:@"Sports" forRow:0 inColumn:3];
    [self setCellData:@"Weather" forRow:0 inColumn:4];
    [self setCellData:@"N/A" forRow:0 inColumn:5];
    [self setCellData:@"N/A" forRow:0 inColumn:6];
    [self setCellData:@"N/A" forRow:1 inColumn:5];
    [self setCellData:@"N/A" forRow:1 inColumn:6];
    [self setCellData:@"N/A" forRow:2 inColumn:5];
    [self setCellData:@"N/A" forRow:2 inColumn:6];
    [self setCellData:@"N/A" forRow:3 inColumn:5];
    [self setCellData:@"N/A" forRow:3 inColumn:6];
    [self setCellData:@"N/A" forRow:4 inColumn:5];
    [self setCellData:@"N/A" forRow:4 inColumn:6];
    [self setCellData:@"Today Show" forRow:1 inColumn:0];
    [self setCellData:@"Today Show" forRow:1 inColumn:1];
    [self setCellData:@"Today Show" forRow:2 inColumn:0];
    [self setCellData:@"Today Show" forRow:2 inColumn:1];
    [self setCellData:@"Sesame Street" forRow:1 inColumn:2];
    [self setCellData:@"Football" forRow:1 inColumn:3];
    [self setCellData:@"Football" forRow:2 inColumn:3];
    [self setCellData:@"Market Watch" forRow:1 inColumn:4];
    [self setCellData:@"Kids Zone" forRow:2 inColumn:2];
    [self setCellData:@"Soap Opera" forRow:2 inColumn:4];
    [self setCellData:@"News" forRow:3 inColumn:0];
    [self setCellData:@"News" forRow:3 inColumn:1];
    [self setCellData:@"News" forRow:3 inColumn:2];
    [self setCellData:@"News" forRow:3 inColumn:3];
    [self setCellData:@"News" forRow:3 inColumn:4];
    [self setCellData:@"News" forRow:4 inColumn:0];
    [self setCellData:@"News" forRow:4 inColumn:1];
    [self setCellData:@"News" forRow:4 inColumn:2];
    [self setCellData:@"News" forRow:4 inColumn:3];
    [self setCellData:@"News" forRow:4 inColumn:4];
    [self setCellData:@"Weel of Fortune" forRow:5 inColumn:0];
    [self setCellData:@"Weel of Fortune" forRow:5 inColumn:1];
    [self setCellData:@"Weel of Fortune" forRow:5 inColumn:2];
    [self setCellData:@"Jeopardy" forRow:5 inColumn:3];
    [self setCellData:@"Jeopardy" forRow:5 inColumn:4];
    [self setCellData:@"Movie" forRow:5 inColumn:5];
    [self setCellData:@"Movie" forRow:6 inColumn:5];
    [self setCellData:@"Golf" forRow:5 inColumn:6];
    [self setCellData:@"Golf" forRow:6 inColumn:6];
    [self setCellData:@"Night Show" forRow:6 inColumn:0];
    [self setCellData:@"Night Show" forRow:6 inColumn:1];
    [self setCellData:@"Sports" forRow:6 inColumn:2];
    [self setCellData:@"Big Brother" forRow:6 inColumn:3];
    [self setCellData:@"Big Brother" forRow:6 inColumn:4];
    
    self.allowMerging = GridAllowMergingAll;
    
    [self autoSizeColumn:0 header:true];

}
@end

@implementation CustomMergingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.grid.selectionMode = GridSelectionModeCell;
    self.grid.isReadOnly = true;
    self.grid.columnHeaderFont = [UIFont boldSystemFontOfSize:self.grid.columnHeaderFont.pointSize];
    
    NSArray* weekdays = @[@"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", @"Sunday"];
    
    for (NSString* dayName in weekdays) {
        GridColumn *c1 = [[GridColumn alloc] init];
        c1.header = dayName;
        c1.widthType = GridColumnWidthStar;
        c1.width = 1;
        c1.dataType = XuniDataTypeString;
        c1.minWidth = 120;
        c1.horizontalAlignment = NSTextAlignmentCenter;
        c1.headerHorizontalAlignment = NSTextAlignmentCenter;
        c1.allowMerging = true;
        [self.grid.columns addObject:c1];
    }
    
    NSArray* timespans = @[@"12", @"13", @"14", @"15", @"16", @"17", @"18"];
    for (NSString* timeSpan in timespans) {
        GridRow* r1 = [[GridRow alloc] init];
        [self.grid.rows addObject:r1];
        
        [self.grid.rowHeaders setCellData:[NSString stringWithFormat:@"%@:00", timeSpan] forRow:(int)[self.grid.rows indexOfObject:r1] inColumn:0];
    }
    
    [self.grid.flexGridSelectionChanged addHandler:^(XuniEventContainer<GridCellRangeEventArgs *> *eventContainer) {
        int r = eventContainer.eventArgs.row;
        int c = eventContainer.eventArgs.col;
        
        NSString* thisShow = [self.grid getCellDataForRow:r inColumn:c formatted:YES].description;
        
        self.showTitle.text = thisShow;
        
        NSString* timetable = @"";
        
        for(int cc = 0; cc<7; cc++)
        {
            NSString* day = ((GridColumn*)[self.grid.columns objectAtIndex:cc]).header;
            NSString* spanStart = nil, *spanEnd = nil;
            for(int cr = 0; cr < 7; cr++)
            {
                NSString* candidate = [self.grid getCellDataForRow:cr inColumn:cc formatted:YES].description;
                if([candidate isEqualToString:thisShow])
                {
                    if(spanStart==nil) spanStart = [self.grid.rowHeaders getCellDataForRow:cr inColumn:0 formatted:YES].description;
                }
                else
                {
                    if(spanStart!=nil)
                    {
                        spanEnd = [self.grid.rowHeaders getCellDataForRow:cr inColumn:0 formatted:YES].description;
                        break;
                    }
                }
            }
            
            if(spanStart!=nil && spanEnd == nil) spanEnd=@"19:00";
            
            if(spanStart!=nil && spanEnd!=nil) timetable = [NSString stringWithFormat:@"%@%@: %@-%@\r", timetable, day,spanStart,spanEnd];
        }
        
        self.showTimetable.text = timetable;

    } forObject:self];
    
    [self.grid.columnHeaders.rows insertObject:[[GridRow alloc]init] atIndex:0];
    
    self.grid.columnHeaders.rows[0].allowMerging = true;
    
    self.grid.columnHeaders[0][0] = @"Weekday";
    self.grid.columnHeaders[0][1] = @"Weekday";
    self.grid.columnHeaders[0][2] = @"Weekday";
    self.grid.columnHeaders[0][3] = @"Weekday";
    self.grid.columnHeaders[0][4] = @"Weekday";
    self.grid.columnHeaders[0][5] = @"Weekend";
    self.grid.columnHeaders[0][6] = @"Weekend";
    
    [self.grid setCellData:@"Walker" forRow:0 inColumn:0];
    [self.grid setCellData:@"Morning Show" forRow:0 inColumn:1];
    [self.grid setCellData:@"Morning Show" forRow:0 inColumn:2];
    [self.grid setCellData:@"Sports" forRow:0 inColumn:3];
    [self.grid setCellData:@"Weather" forRow:0 inColumn:4];
    [self.grid setCellData:@"N/A" forRow:0 inColumn:5];
    [self.grid setCellData:@"N/A" forRow:0 inColumn:6];
    [self.grid setCellData:@"N/A" forRow:1 inColumn:5];
    [self.grid setCellData:@"N/A" forRow:1 inColumn:6];
    [self.grid setCellData:@"N/A" forRow:2 inColumn:5];
    [self.grid setCellData:@"N/A" forRow:2 inColumn:6];
    [self.grid setCellData:@"N/A" forRow:3 inColumn:5];
    [self.grid setCellData:@"N/A" forRow:3 inColumn:6];
    [self.grid setCellData:@"N/A" forRow:4 inColumn:5];
    [self.grid setCellData:@"N/A" forRow:4 inColumn:6];
    [self.grid setCellData:@"Today Show" forRow:1 inColumn:0];
    [self.grid setCellData:@"Today Show" forRow:1 inColumn:1];
    [self.grid setCellData:@"Today Show" forRow:2 inColumn:0];
    [self.grid setCellData:@"Today Show" forRow:2 inColumn:1];
    [self.grid setCellData:@"Sesame Street" forRow:1 inColumn:2];
    [self.grid setCellData:@"Football" forRow:1 inColumn:3];
    [self.grid setCellData:@"Football" forRow:2 inColumn:3];
    [self.grid setCellData:@"Market Watch" forRow:1 inColumn:4];
    [self.grid setCellData:@"Kids Zone" forRow:2 inColumn:2];
    [self.grid setCellData:@"Soap Opera" forRow:2 inColumn:4];
    [self.grid setCellData:@"News" forRow:3 inColumn:0];
    [self.grid setCellData:@"News" forRow:3 inColumn:1];
    [self.grid setCellData:@"News" forRow:3 inColumn:2];
    [self.grid setCellData:@"News" forRow:3 inColumn:3];
    [self.grid setCellData:@"News" forRow:3 inColumn:4];
    [self.grid setCellData:@"News" forRow:4 inColumn:0];
    [self.grid setCellData:@"News" forRow:4 inColumn:1];
    [self.grid setCellData:@"News" forRow:4 inColumn:2];
    [self.grid setCellData:@"News" forRow:4 inColumn:3];
    [self.grid setCellData:@"News" forRow:4 inColumn:4];
    [self.grid setCellData:@"Wheel of Fortune" forRow:5 inColumn:0];
    [self.grid setCellData:@"Wheel of Fortune" forRow:5 inColumn:1];
    [self.grid setCellData:@"Wheel of Fortune" forRow:5 inColumn:2];
    [self.grid setCellData:@"Jeopardy" forRow:5 inColumn:3];
    [self.grid setCellData:@"Jeopardy" forRow:5 inColumn:4];
    [self.grid setCellData:@"Movie" forRow:5 inColumn:5];
    [self.grid setCellData:@"Movie" forRow:6 inColumn:5];
    [self.grid setCellData:@"Golf" forRow:5 inColumn:6];
    [self.grid setCellData:@"Golf" forRow:6 inColumn:6];
    [self.grid setCellData:@"Night Show" forRow:6 inColumn:0];
    [self.grid setCellData:@"Night Show" forRow:6 inColumn:1];
    [self.grid setCellData:@"Sports" forRow:6 inColumn:2];
    [self.grid setCellData:@"Big Brother" forRow:6 inColumn:3];
    [self.grid setCellData:@"Big Brother" forRow:6 inColumn:4];
    
    self.grid.allowMerging = GridAllowMergingAll;
    
    [self.grid autoSizeColumn:0 header:true];
    
}



@end
