//
//  CustomMergingViewController.m
//  FlexGrid101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//

#import "XuniFlexGridKit/XuniFlexGridKit.h"
#import "CustomMergingViewController.h"

@interface CustomMergingViewController ()
@property (weak, nonatomic) IBOutlet FlexGrid *grid;
@property (weak, nonatomic) IBOutlet UILabel *showTitle;
@property (weak, nonatomic) IBOutlet UILabel *showTimetable;

@end

@implementation CustomMergingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.grid.selectionMode = FlexSelectionModeCell;
    self.grid.isReadOnly = true;
    
    NSArray* weekdays = @[@"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", @"Sunday"];
    
    for (NSString* dayName in weekdays) {
        FlexColumn *c1 = [[FlexColumn alloc] init];
        c1.header = dayName;
        c1.widthType = FlexColumnWidthStar;
        c1.width = 1;
        c1.dataType = XuniDataTypeString;
        c1.minWidth = 120;
        c1.allowMerging = true;
        [self.grid.columns addObject:c1];
    }
    
    NSArray* timespans = @[@"12", @"13", @"14", @"15", @"16", @"17", @"18"];
    for (NSString* timeSpan in timespans) {
        FlexRow* r1 = [[FlexRow alloc] init];
        [self.grid.rows addObject:r1];
        
        [self.grid.rowHeaders setCellData:[NSString stringWithFormat:@"%@:00", timeSpan] forRow:(int)[self.grid.rows indexOfObject:r1] inColumn:0];
    }
    
    [self.grid.flexGridSelectionChanged addHandler:^(NSObject *sender, XuniEventArgs *args) {
        FlexCellRangeEventArgs *e = (FlexCellRangeEventArgs *)args;
        int r = e.row;
        int c = e.col;
        
        NSString* thisShow = [self.grid getCellDataForRow:r inColumn:c formatted:YES].description;
        
        self.showTitle.text = thisShow;
        
        NSString* timetable = @"";
        
        for(int cc = 0; cc<7; cc++)
        {
            NSString* day = ((FlexColumn*)[self.grid.columns objectAtIndex:cc]).header;
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
    [self.grid setCellData:@"Weel of Fortune" forRow:5 inColumn:0];
    [self.grid setCellData:@"Weel of Fortune" forRow:5 inColumn:1];
    [self.grid setCellData:@"Weel of Fortune" forRow:5 inColumn:2];
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
    
    self.grid.allowMerging = FlexGridAllowMergingCells;
    
    [self.grid autoSizeColumn:0 header:true];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
